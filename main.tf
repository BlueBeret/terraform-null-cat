provider "local" {}

variable "cat_file" {
  description = "Path to the file containing the cat's message"
  type        = string
}

data "local_file" "cat_content" {
  filename = var.cat_file
}

output "cat_says" {
  value = "cat says:\n${data.local_file.cat_content.content}"
}
