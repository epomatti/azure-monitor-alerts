variable "location" {
  type    = string
  default = "eastus2"
}

variable "vm_size" {
  type = string
}

variable "sms_country_code" {
  type = string
}

variable "sms_phone_number" {
  type = string
}

variable "email_address" {
  type = string
}

variable "email_name" {
  type = string
}

variable "storage_transactions_threshold" {
  type = number
}
