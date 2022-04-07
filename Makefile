.PHONY: build push deploy s3 lambda

build:
	mkdir -p build

	zip build/code.zip lambda/*

	# sha256 hash needed for letting know Terraform when the code changes
	sha256sum build/code.zip | cut -f1 -d ' ' > build/code.zip.sha256

push:
	aws s3 cp\
		build/code.zip\
		s3://vidi-lambdacode/lambdatest/code.zip

	# We need to define content-type as text/* in order to be able to read it in Terraform
	aws s3 cp\
		--content-type=text/sha256\
		build/code.zip.sha256\
		s3://vidi-lambdacode/lambdatest/code.zip.sha256

lambda: deploy
deploy:
	terraform init -reconfigure terraform/lambda
	terraform apply\
		-auto-approve\
		-var-file terraform/lambda/vars.tfvars \
		terraform/lambda

s3:
	terraform init -reconfigure terraform/s3
	terraform apply terraform/s3
