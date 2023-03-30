output "public_clusterB_ips" {
    value = aws_instance.clusterB[*].public_ip
}

output "public_clusterA_ips" {
    value = aws_instance.clusterA[*].public_ip
}
