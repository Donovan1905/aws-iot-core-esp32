data "http" "root_ca" {
	url = "https://www.amazontrust.com/repository/AmazonRootCA1.pem"
}

output "aws_iot_ca_certificate" {
  sensitive = true
	value = data.http.root_ca.response_body
}

output "aws_iot_device_certificate" {
  sensitive = true
  value = aws_iot_certificate.cert.certificate_pem
}

output "aws_iot_device_private_key" {
  sensitive = true
  value = tls_private_key.key.private_key_pem
}