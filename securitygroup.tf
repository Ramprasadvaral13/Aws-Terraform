resource "aws_security_group" "demo-sg" {
    vpc_id = aws_vpc.demo-vpc.id
    name = "tets-sg"
    description = "test-sg"

    ingress {
        protocol = "tcp"
        from_port = 22
        to_port = 22
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
}