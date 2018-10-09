variable "trigger" {
  description = "Trigger to activate the module"
}

variable "delay_interval" {
  description = "Sleep interval in seconds"
}
variable "command" {
  description = "Command to execute after delay"
}

variable "enable" {
  default = 0
}

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep ${var.delay_interval}"
  }
  triggers = {
    "before" = "${var.trigger}"
  }
}

resource "null_resource" "command" {
  provisioner "local-exec" {
    command = "${var.command}"
  }
  depends_on = ["null_resource.delay"]
}
