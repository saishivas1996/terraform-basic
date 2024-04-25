resource "aws_vpc" "learning" {
    cidr_block = var.vpc_range
  
}
resource "aws_subnet" "pub1" {
    vpc_id = aws_vpc.learning.id

    availability_zone =   var.region
    cidr_block = var.subnet
    map_public_ip_on_launch = true
}

resource "aws_subnet" "pub2" {
    vpc_id = aws_vpc.learning.id

    availability_zone = var.region2
    cidr_block = var.subnet2
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.learning.id
  
}

resource "aws_route_table" "rt1" {

    vpc_id = aws_vpc.learning.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "rt-ass" {
    subnet_id = aws_subnet.pub1.id
    route_table_id = aws_route_table.rt1.id
  
}

resource "aws_route_table_association" "rt-ass2" {
    subnet_id = aws_subnet.pub2.id
    route_table_id = aws_route_table.rt1.id
  
}

resource "aws_security_group" "sg1" {
    name = "web-sg"
    vpc_id = aws_vpc.learning.id

    ingress {
        description = "security group"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "ssh port"
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "port"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "web1" {
    ami = var.image_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg1.id]
    subnet_id = aws_subnet.pub1.id
    user_data = base64encode(file("userdata.sh")) 
}

resource "aws_instance" "web2" {
    ami = var.image_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg1.id]
    subnet_id = aws_subnet.pub2.id
    user_data = base64encode(file("userdata.sh")) 
}
