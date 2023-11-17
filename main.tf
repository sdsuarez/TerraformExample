provider "local" {}

# Archivo HTML
resource "local_file" "index" {
  content  = file("${path.module}/web/index.html")
  filename = "${path.module}/web/index.html"
}

# Archivo CSS
resource "local_file" "styles" {
  content  = file("${path.module}/web/styles.css")
  filename = "${path.module}/web/styles.css"
}

# Servidor local para la página web
resource "null_resource" "web_server" {
  provisioner "local-exec" {
    command = "python -m http.server 8000 -d ${path.module}/web"
  }

  depends_on = [local_file.index, local_file.styles]
}
