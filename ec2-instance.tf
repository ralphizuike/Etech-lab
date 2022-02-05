resource "aws_instance" "testserver" {
        ami = "ami-0fcda042dd8ae41c7"
        instance_type = "t2.micro"
        tags = {
           Name = "testserver"
           Description = "use for demo"
         }
}
