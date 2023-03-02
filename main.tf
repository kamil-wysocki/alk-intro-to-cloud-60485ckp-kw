resource "google_compute_network" "vpc_network" {
    project = var.project_name
    name = "intro-alk-vpc-network"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
    project = var.project_name
    network = google_compute_network.vpc_network.id
    name = "intro-alk-vpc-subnetwork"
    region = var.region_name
    ip_cidr_range = "10.12.0.0/16"
}

resource "google_compute_instance" "vm_compute_engine" {
    name = "intro-alk-vm-${var.alk_login}"
    count = var.vm_count
    zone = var.zone_name
    machine_type = "e2-medium"

    tags = ["alk", "jupyter"]

    boot_disk {
        initialize_params {
          image = "debian-10-buster-v20230206"
        }
    }

    network_interface {
      network = google_compute_network.vpc_network.id
      subnetwork = google_compute_subnetwork.vpc_subnetwork.id
      access_config {
        
      }
    }

    metadata_startup_script =data.template_file.startup_vm_bash.rendered
}

resource "google_compute_firewall" "firewall_rule_allow_ssh_http_impq" {
  name = "fr-allow-${var.alk_login}"
  allow {
    ports = ["22","80"]
    protocol = "tcp"
  }
  allow {
    protocol = "icmp"
  }
  network = google_compute_network.vpc_network.id
  priority = 10
  source_ranges = ["0.0.0.0/0"]
}

data "template_file" "startup_vm_bash" {
  template = "${file("${path.module}/scripts/vm_init.sh")}"
}