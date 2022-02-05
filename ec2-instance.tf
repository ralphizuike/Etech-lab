resource "aws_instance" "testserver" {
        ami = "ami-03f4121463e28151e"
        instance_type = "t2.micro"
        tags = {
           Name = "testserver"
           Description = "use for demo"
         }
}
