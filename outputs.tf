output "public_mongoc_ips" {
    value = aws_instance.mongoc[*].public_ip
}

output "public_mongod_ips" {
    value = aws_instance.mongod[*].public_ip
}
