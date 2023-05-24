plan refresh init validate output:
	terraform $(@)

format:
	terraform fmt

upgrade:
	terraform init -upgrade

update:
	terraform get -update

