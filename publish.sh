#!/usr/bin/env bash

set -euo pipefail

if ! command -v aws >/dev/null; then
    echo "Requires AWS cli (brew install aws)" 1>&2
    exit 1
fi

RDJ_AWS_ACCOUNT_ID=490923113599
BUCKET=www.latentninja.com
export AWS_REGION=us-east-1
export AWS_DEFAULT_REGION=us-east-1

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
unset AWS_ACCESS_KEY_SECRET
unset AWS_SECURITY_TOKEN

if [[ -z "${AWS_PROFILE:-}" || "${AWS_PROFILE}" == "rdj-readonly" ]]; then
  AWS_PROFILE=rdj-admin
fi
export AWS_PROFILE

aws_account_id() {
  aws sts get-caller-identity --query Account --output text 2>/dev/null
}

if ! current_aws_account_id=$(aws_account_id); then
  echo "AWS credentials unavailable for profile ${AWS_PROFILE}; starting SSO login"
  aws sso login --profile "${AWS_PROFILE}"
  current_aws_account_id=$(aws_account_id)
fi

if [[ "${current_aws_account_id}" != "${RDJ_AWS_ACCOUNT_ID}" ]]; then
  echo "Refusing to publish in unexpected AWS account ${current_aws_account_id}"
  echo "Expected RDJ account ${RDJ_AWS_ACCOUNT_ID}; current AWS_PROFILE=${AWS_PROFILE}"
  exit 1
fi

echo "Using AWS_PROFILE=${AWS_PROFILE} in account ${current_aws_account_id}"

cd "$(dirname "$0")"
aws s3 sync public "s3://${BUCKET}/" --exclude .gitkeep --exclude "*.key" --exclude "*.pem" --exclude "*.crt" --exclude mkcert
