terraform {
  required_version = ">= 1.0.0"
}

locals {
  environments = ["dev", "stage", "prod"]
  services     = ["api", "db", "cache"]
  flags        = { enable_extra = true, enable_alt = false }

  matrix = flatten([
    for env in local.environments : [
      for svc in local.services : {
        id  = "${env}-${svc}"
        env = env
        svc = svc
      }
    ]
  ])
}

########################################
# Static resources
########################################

resource "null_resource" "always_1" {
  triggers = {
    name = "always_1"
  }

  provisioner "local-exec" {
    command = "echo Static always_1"
  }
}

resource "null_resource" "always_2" {
  triggers = {
    name = "always_2"
  }

  provisioner "local-exec" {
    command = "echo Static always_2"
  }

  depends_on = [null_resource.always_1]
}

########################################
# Count-based dynamic block
########################################

resource "null_resource" "count_based" {
  count = length(local.environments)

  triggers = {
    env = local.environments[count.index]
  }

  provisioner "local-exec" {
    command = "echo Environment = ${self.triggers.env}"
  }
}

########################################
# for_each with map
########################################

resource "null_resource" "foreach_service" {
  for_each = toset(local.services)

  triggers = {
    service = each.key
  }

  provisioner "local-exec" {
    command = "echo Service = ${each.key}"
  }
}

########################################
# Matrix simulation
########################################

resource "null_resource" "matrix_combo" {
  for_each = {
    for combo in local.matrix : combo.id => combo
  }

  triggers = {
    id  = each.value.id
    env = each.value.env
    svc = each.value.svc
  }

  provisioner "local-exec" {
    command = "echo Matrix = ${each.value.id}"
  }
}

########################################
# Conditional resource
########################################

resource "null_resource" "conditional_extra" {
  count = local.flags.enable_extra ? 2 : 0

  triggers = {
    name = "extra_${count.index}"
  }

  provisioner "local-exec" {
    command = "echo Extra resource ${self.triggers.name}"
  }
}

########################################
# Simulate dependency
########################################

resource "null_resource" "finalizer" {
  triggers = {
    done = "true"
  }

  depends_on = [
    null_resource.matrix_combo,
    null_resource.conditional_extra
  ]

  provisioner "local-exec" {
    command = "echo All dummy setup complete"
  }
}
