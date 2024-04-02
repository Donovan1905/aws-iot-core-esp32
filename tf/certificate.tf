resource "tls_private_key" "key" {
	algorithm   = "RSA"
	rsa_bits = 2048
}

resource "tls_self_signed_cert" "cert" {
	private_key_pem = tls_private_key.key.private_key_pem

	validity_period_hours = 240

	allowed_uses = [
	]

	subject {
		organization = "test"
	}
}

resource "aws_iot_certificate" "cert" {
	certificate_pem = trimspace(tls_self_signed_cert.cert.cert_pem)
	active          = true
}

