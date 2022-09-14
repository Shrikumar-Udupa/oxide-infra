variable "cidr" {
	description = "CIDR Range for vpc"
	type = string
	default = "10.1.0.0/16"
}

variable "enable_dns_hostnames" {
	description = "Enable dns hostname"
	type = bool
	default = null
}

variable "enable_vpc_support" {
	description = "Enable VPC support"
	type = bool
	default = null
}

variable "vpc_name" {
	description = "VPC name"
	type = string
	default = "a206399-torus-vpc-prod-use1"
}

variable "igw_name" {
	description = "Igw name"
	type = string
	default = "a206399-torus-igw-prod-use1"
}

variable "public_subnets_cidr" {
	description = "public_subnets_cidr"
	type = string
	default = "10.1.1.0/24"
}

variable "map_public_ip_on_launch" {
	description = "map_public_ip_on_launch"
	type = bool
	default = null
}

variable "public_subnet_name" {
	description = "database_subnet_tag"
	type = string
	default = "a206399-torud-public-subnet-prod-use1"
}

variable "private_subnets_cidr" {
	description = "private_subnets_cidr"
	type = string
	default = "10.1.2.0/24"
}

variable "public_route_table_name" {
	description = "public_route_table_name"
	type = string
	default = "a206399-torus-public-route-table-prod-use1"
}

variable "private_route_table_name" {
	description = "private_route_table_name"
	type = string
	default = "a206399-torus-private-route-table-prod-use1"
}

variable "sg_name" {
	description = "Secuirty group name"
	type = string
	default = "a206399-torus-ec2-sg-prod-use1"
}

variable "allow_all_cidr_block" {
	description = "Security group Cidr"
	default = "0.0.0.0/0"
}
