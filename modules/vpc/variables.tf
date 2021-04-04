/*
 * Commons
 */
variable "project_name" {
  description = "Prefix of the resources, whitespaces are not allowed"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}

/*
 * VPC
 */
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "dns_support" {
  description = "Boolean flag to enable/disable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "dns_hostnames" {
  description = "Boolean flag to enable/disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "dns_servers" {
  description = "List of name servers to configure in /etc/resolv.conf"
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}

/*
 * Subnets
 */
variable "subnets_info" {
  description = "Subnets information"
  type = map(object({
    cidr_block              = string
    map_public_ip_on_launch = bool
    type                    = string
    availability_zone       = string
  }))
}