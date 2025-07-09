terraform {
  required_version = ">= 0.12"
}

output "secret_value" {
  value     = var.secret_name != "" ? data.aws_secretsmanager_secret_version.this[0].secret_string : null
  sensitive = true
}

output "secrets" {
  value = var.secret_name != "" ? null : data.aws_secretsmanager_secrets.this[0].names
}

locals {
  cat_names = [
    "Whiskerina",
    "Floppa",
    "Ballerina Cappuccina",
    "Tung Tung Tung Sahur",
    "Bombardiro Crocodilo",
    "Tralalero Tralala"
  ]

  cat_lore = {
    ballerina = "Cappuccina pirouette through dimensions"
    sahur     = "Tung Tung Tung awaken the void"
    bomber    = "Bombardiro Crocodilo strikes at dawn"
    shark     = "Tralalero Tralala swims with static"
  }

  cat_stats = {
    Whiskerina = {
      agility = 99
      chaos   = 88
    }
    Floppa = {
      power = 9001
      void  = 100
    }
  }

  mixed_tuple = ["Whiskerina", 1337, true]
  cat_set     = toset(["voidcat", "chaoscat", "cappuccinacat"])

  null_val = null
}

output "all_cat_names" {
  value = local.cat_names
}

output "ballerina_description" {
  value = local.cat_lore["ballerina"]
}

output "sahur_cat_sound" {
  value = local.cat_lore["sahur"]
}

output "bombardiro_cat" {
  value = local.cat_lore["bomber"]
}

output "tralalero_cat" {
  value = local.cat_lore["shark"]
}

output "cat_lore_keys" {
  value = keys(local.cat_lore)
}

output "cat_lore_values" {
  value = values(local.cat_lore)
}

output "floppa_power" {
  value = local.cat_stats["Floppa"]["power"]
}

output "whiskerina_agility" {
  value = local.cat_stats["Whiskerina"]["agility"]
}

output "mixed_tuple_example" {
  value = local.mixed_tuple
}

output "cat_set_example" {
  value = local.cat_set
}

output "joined_cat_names" {
  value = join(" | ", local.cat_names)
}

output "first_cat_name" {
  value = local.cat_names[0]
}

output "is_floppa_strong" {
  value = local.cat_stats["Floppa"]["power"] > 5000
}

output "null_cat_check" {
  value = local.null_val
}

output "upper_sahur" {
  value = upper(local.cat_lore["sahur"])
}

output "replace_bombardiro" {
  value = replace(local.cat_lore["bomber"], "dawn", "noon")
}

output "cat_name_length" {
  value = length(local.cat_names)
}

output "cat_stats_object" {
  value = local.cat_stats
}

output "contains_cappuccina" {
  value = contains(local.cat_names, "Ballerina Cappuccina")
}

output "timestamp_now" {
  value = timestamp()
}

output "cat_name_lengths" {
  value = [for name in local.cat_names : length(name)]
}

output "cat_prefix_map" {
  value = { for name in local.cat_names : name => "cat-${name}" }
}

output "map_example" {
  value = {
    name   = "Tung Cat"
    origin = "Void Market"
    sound  = "TUNG TUNG TUNG"
  }
}

output "tuple_unpack" {
  value = "Name: ${local.mixed_tuple[0]}, Code: ${local.mixed_tuple[1]}"
}

output "cat_object_example" {
  value = {
    ballerina = {
      name   = "Cappuccina"
      skill  = "pirouette"
      danger = 99
    }
  }
}

output "flatten_example" {
  value = flatten([[["cat1"]], ["cat2", "cat3"]])
}

output "ternary_check" {
  value = contains(local.cat_names, "Floppa") ? "Floppa found" : "Floppa missing"
}

output "anomaly_cat_count" {
  value = length(local.cat_lore)
}
