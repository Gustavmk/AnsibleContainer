#!/bin/bash
set -e # Exit if any of the intermediate steps fail
az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET -t $ARM_TENANT_ID >/dev/null
az account set --subscription $ARM_SUBSCRIPTION_ID