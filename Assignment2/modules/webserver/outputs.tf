output "instances_info" {
  value = { for name, inst in aws_instance.server : name => {
    public_ip  = inst.public_ip
    private_ip = inst.private_ip
    instance_id= inst.id
  }}
}
