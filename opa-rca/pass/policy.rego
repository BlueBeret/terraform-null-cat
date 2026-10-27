package main

import future.keywords.contains
import future.keywords.if

# passes: nothing in the plan is an S3 bucket, so deny stays empty
deny contains msg if {
	some i
	resource := input.resource_changes[i]
	resource.type == "aws_s3_bucket"
	msg := sprintf("[SECURITY] %v: S3 bucket must have logging.", [resource.address])
}

default allow := false

allow if count(deny) == 0
