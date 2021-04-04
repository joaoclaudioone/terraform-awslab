/*
 * Commons
 */
variable "tags" {
  description = "Common tags"
  type        = map(string)
}

/*
 * EC2
 */
variable "query_ami" {
    description = "Values for query ami"
    type        = map
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "public_key" {
  description = "File with the public ssh key"
  type        = string
}

variable "security_group" {
  description = "Security Group id for instances"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List with the id of subnets"
  type        = list(string)
}

variable "instance_count" {
  description = "Quantity of instances that will be created"
  type        = number
  default     = 1
}

variable "credit_specification" {
  description = "Customize the credit specification of the instance"
  type        = string
  default     = "standard"
}

variable "ebs_delete_on_termination" {
  description = "If true will delete the block EBS on termination"
  type        = bool
  default     = true
}

variable "volume_size" {
  description = "Size of the volume in gibibytes"
  type        = number
  default     = 8
}

variable "api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = false
}
