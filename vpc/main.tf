###VPC##

resource aws_vpc "a206399-torus-vpc-prod-use1" {
	cidr_block = var.cidr
	enable_dns_hostnames = var.enable_dns_hostnames
	enable_dns_support = var.enable_vpc_support
	tags = {
		Name = var.vpc_name
	}

}

##Internet gateway###

resource "aws_internet_gateway" "a206399-torus-igw-prod-use1" {
	vpc = aws_vpc.a206399-enterprise-vpc-prod-use1.id
	tags = {
	  Name = var.igw_name
	}
}

##Public Subnet##

resource "aws_subnet" "a206399-torus-public-subnet-prod-use1" {
	vpc_id = aws_vpc.a206399-torus-vpc-prod-use1.id
	cidr_block = var.public_subnets_cidr
	availability_zone = data.aws_availability_zones.a206399-az.names[0]
	map_public_ip_on_launch = var.map_public_ip_on_launch
	tags = {
	  Name = var.public_subnet_name
	}
}

resource "aws_subnet" "a206399-torus-private-subnet-prod-use1" {
	vpc_id = aws_vpc.a206399-torus-vpc-prod-use1.id
	cidr_block = var.private_subnets_cidr
	availability_zone = data.aws_availability_zones.a206399-az.names[1]
	map_public_ip_on_launch = false
	tags = {
	  Name = var.public_subnet_name
	}
}

##Public Route##
resource "aws_route_table" "a206399-torus-public-route-table-prod-use1" {
	vpc_id = aws_vpc.a206399-torus-vpc-prod-use1.id
	tags = {
	  Name = var.public_route_table_name
	}
}

resource "aws_route" "a206399-torus-public-igw-prod-use1" {
	route_table_id = aws_route_table.a206399-torus-public-route-table-prod-use1.id
	destination_cidr_block = "0.0.0.0/0"
	gateway_id = aws_internet_gateway.a206399-torus-igw-prod-use1.id
}

# Database route table##

resource "aws_route_table" "a206399-torus-private-route-table-prod-use1" {
	vpc_id = aws_vpc.a206399-torus-vpc-prod-use1.id
	tags = {
	  Name = var.private_route_table_name
	}
}

# Route table association with subnets

resource "aws_route_table_association" "a206399-torus-public-subnet-route-association-prod-use1" {
	subnet_id = aws_subnet.a206399-torus-public-subnet-prod-use1.id
	route_table_id = aws_route_table.a206399-torus-public-route-table-prod-use1.id
}

# Route table association with Private subnet
resource "aws_route_table_association" "a206399-torus-private-subnet-route-association-prod-use1" {
	subnet_id = aws_subnet.a206399-torus-private-subnet-prod-use1.id
	route_table_id =aws_route_table.a206399-torus-private-route-table-prod-use1.id
}

## Security group
resource "aws_security_group" "a206399-torus-ec2-sg-prod-use1" {
	name = "a206399-torus-ec2-sg-prod-use1"
	description = "a206399-torus-ec2-sg-prod-use1"
	vpc_id = aws_vpc.a206399-torus-vpc-prod-use1.id

	ingress = [
	  {
	    description = "Port 22"
	    from_port = 22
	    to_port = 22
	    protocol = "tcp"
	    cidr_block = [var.cidr_block]

	  }
	]
	tags = {
	  Name = var.sg_name
	}
}

resource "aws_security_group_rule" "a206399-torus-ec2-rule-http-prod-use1" {
	type = "ingress"
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_block = [var.allow_all_cidr_block]
	security_group_id = aws_security_group.a206399-torus-ec2-sg-prod-use1.id
}

resource "aws_security_group_rule" "a206399-torus-ec2-rule-https-prod-use1" {
	type = "ingress"
	from_port = 443
	to_port = 443
	protocol = "tcp"
	cidr_block = [var.allow_all_cidr_block]
	security_group_id = aws_security_group.a206399-torus-ec2-sg-prod-use1.id
}

