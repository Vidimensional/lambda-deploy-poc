.PHONY: build push deploy shared lambda

build:
	mkdir -p build
	zip build/code.zip lambda/*
	# sha256 hash needed for letting know Terraform when the code changes
	sha256sum build/code.zip | cut -f1 -d ' ' > build/code.zip.sha256

push:
	aws s3 cp build/code.zip s3://vidi-lambdacode/lambdatest/code.$(DEPLOY_VERSION).zip
	# We need to define content-type as text/* in order to be able to read it in Terraform
	aws s3 cp --content-type=text/sha256 build/code.zip.sha256 s3://vidi-lambdacode/lambdatest/code.$(DEPLOY_VERSION).zip.sha256

lambda: deploy
deploy:
	aws ssm put-parameter --name /lambda/lambdatest/version --value $(DEPLOY_VERSION) --overwrite --type String
	terraform -chdir=./terraform/lambda init -reconfigure 
	terraform -chdir=./terraform/lambda apply -auto-approve -var-file=vars.tfvars

shared:
	terraform -chdir=./terraform/shared init -reconfigure 
	terraform -chdir=./terraform/shared apply -auto-approve

check:
	@aws lambda invoke --function-name lambdatest output.txt
	@cat output.txt
	@rm output.txt
