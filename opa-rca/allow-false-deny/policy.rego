package main

import future.keywords.contains
import future.keywords.if

# allow is false when deny has entries
deny contains msg if {
	some i
	resource := input.resource_changes[i]
	resource.type == "local_file"
	msg := sprintf("❌ [SECURITY] %v: local file must not be world writable. Set file_permission to 0600.", [resource.address])
}

deny contains msg if {
	some i
	resource := input.resource_changes[i]
	resource.type == "null_resource"
	msg := sprintf("❌ [SECURITY] %v: null_resource must define triggers.", [resource.address])
}

default allow := false

allow if count(deny) == 0
