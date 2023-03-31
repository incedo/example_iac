# Infrastructure of Example
This is part of the example project to show how to setup Azure in combination with 
- static web app support

## dependencies to run
- azure cli -> https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build


## newbie az stuff
- az login
- az account set --subscription "<SUBSCRIPTION_ID>"
### first time setup
- az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"


## github actions used
- https://github.com/marketplace/actions/hashicorp-setup-terraform