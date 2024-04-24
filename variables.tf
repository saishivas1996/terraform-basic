variable "vpc_range" {
    description = "creating vpc"
    type = string 
}

variable "subnet" {
    description = "subnet range"
    type = string
}

variable "subnet2" {
    description = "subnet range2"
    type = string
}

variable "region" {
    description = "which region we need tocreate vpc"
    type = string
}

variable "region2" {
    description = "region2 or other subnet"
    type = string
}

variable "image_id" {
    description = "image id"
    type = string
}

variable "instance_type" {
    description = "instance-type"
    type = string
  
}