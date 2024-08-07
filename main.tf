provider "local" {}

variable "cat_file" {
  description = "Path to the file containing the cat's message"
  type        = string
}

resource "local_file" "cat_message" {
  content  = templatefile(var.cat_file, {})
  filename = "cat_message.txt"
}

output "cat_says" {
  value = "cat says:\n${local_file.cat_message.content}"
}
