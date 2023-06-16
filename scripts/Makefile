AWS_PROFILE ?= default
AWS_REGION ?= us-east-1

# Define directories
TERRAFORM_DIR := terraform
ENVIRONMENTS_DIR := $(TERRAFORM_DIR)/environments
MODULES_DIR := $(TERRAFORM_DIR)/modules
APP_DIR := app
SCRIPTS_DIR := scripts
BUILD_DIR := build
LAMBDA_DIR := app/lambda
LAMBDA_FOLDERS := $(wildcard $(LAMBDA_DIR)/*)
LAMBDA_ZIPS := $(addprefix $(BUILD_DIR)/, $(notdir $(LAMBDA_FOLDERS:=.zip)))

# Define the environment
ENV ?= dev

# Targets

all: init validate build deploy

init:
	@echo "Initializing Terraform"; \
	cd $(ENVIRONMENTS_DIR)/$(ENV) && terraform init; \

validate:
	@echo "Validating Terraform configuration"
	cd $(ENVIRONMENTS_DIR)/$(ENV) && terraform validate

build: $(LAMBDA_ZIPS)
	@echo "Building the application"

$(BUILD_DIR)/%.zip: $(LAMBDA_DIR)/%
	@echo "Building lambda function in folder $*"
	mkdir -p $(BUILD_DIR)
	mkdir -p $(LAMBDA_DIR)/$*/.build
	if [ -f $(LAMBDA_DIR)/$*/requirements.txt ]; then \
		pip install -r $(LAMBDA_DIR)/$*/requirements.txt -t $(LAMBDA_DIR)/$*/.build; \
	fi
	cd $(LAMBDA_DIR)/$* && cp -r * .build/
	cd $(LAMBDA_DIR)/$*/.build && zip -r ../../../../$(BUILD_DIR)/$*.zip .
	rm -rf $(LAMBDA_DIR)/$*/.build

deploy:
	@echo "Deploying the application"
	cd $(ENVIRONMENTS_DIR)/$(ENV) && terraform apply -auto-approve

destroy:
	@echo "Destroying the application"
	cd $(ENVIRONMENTS_DIR)/$(ENV) && terraform destroy -auto-approve

clean:
	@echo "Cleaning up"
	rm -rf $(BUILD_DIR)