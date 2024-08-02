provider "local" {}

variable "cat" {
  description = "The command to execute with all arguments and parameters"
  type        = string
}

data "external" "execute_cat_command" {
  program = ["bash", "-c", var.cat]
}

output "command_output" {
  value = data.external.execute_cat_command.result.stdout
}
