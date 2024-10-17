provider "local" {}

# Variable to specify the file name
variable "cat_file" {
  description = "Name of the file containing the cat's message (no /)"
  type        = string
  default     = "cat_file.txt"

  validation {
    condition     = !contains(var.cat_file, "/") && !contains(var.cat_file, "\\")
    error_message = "The file name must not contain '/' or '\\'. Only the file name without any directory structure is allowed."
  }
}

# Variable for the file content
variable "cat_message" {
  description = "Message that the cat says"
  type        = string
  default     = "say_something"
}

# Create the file with the content specified by the variable
resource "local_file" "cat_message" {
  # Assuming the file is created in the current working directory
  filename = "${path.module}/${var.cat_file}"
  content  = var.cat_message
}

# Output the file content after creation
data "local_file" "cat_content" {
  filename = local_file.cat_message.filename
}

output "cat_says" {
  value = "cat says:\n${data.local_file.cat_content.content}"
}
