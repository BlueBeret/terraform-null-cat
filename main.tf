provider "local" {}

resource "null_resource" "execute_shell_script" {
  provisioner "local-exec" {
    command = "sh ./script.sh"
  }
}
