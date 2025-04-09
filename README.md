# Web & Game Hosting Demo

This is a public-facing modular infrastructure demo using Terraform.
=======
# 🎮 Web & Game Hosting Platform Demo  
[![](https://img.shields.io/badge/status-Coming--Soon-informational?style=flat-square)](#)
[![](https://img.shields.io/badge/kubernetes-ready-blue?style=flat-square&logo=kubernetes)](#)
[![](https://img.shields.io/badge/terraform-infrastructure-informational?style=flat-square&logo=terraform)](#)
[![](https://img.shields.io/badge/proxmox-virtualization-lightgrey?style=flat-square)](#)
[![](https://img.shields.io/badge/CI%2FCD-enabled-success?style=flat-square&logo=githubactions)](#)

> ⚠️ This is a **trimmed, public-facing version** of a larger hosting infrastructure platform currently in development.  
> Built for dynamic provisioning of game servers and websites using **Proxmox**, **Kubernetes**, and **CI/CD automation**.

---

## 🧠 Overview

This demo showcases the core concepts behind a self-hosted **Web & Game Hosting Platform**. It is built to automate the deployment and lifecycle management of game servers, websites, and supporting services using modern DevOps and Infrastructure-as-Code tools.

Designed to be scalable, modular, and secure — this stack forms the foundation for a custom hosting provider offering dynamic provisioning, monitoring, and resource automation.

---

## ⚙️ Architecture Highlights

- **Hypervisor Layer:**  
  Proxmox VE used for dynamic VM provisioning, pool creation, and snapshot automation.

- **Orchestration Layer:**  
  Kubernetes clusters run web services, game pods, databases, and monitoring tools.

- **Automation Layer:**  
  Terraform + Ansible automate configuration, deployment, and scaling.

- **CI/CD Pipelines:**  
  GitHub Actions used for container builds, server template updates, and rollout tasks.

- **Secret Management:**  
  HashiCorp Vault manages API keys, credentials, and provisioning secrets.

---

## 🧩 Tech Stack

| Layer | Technologies |
|-------|--------------|
| Infrastructure | Proxmox VE, Terraform, Ansible |
| Orchestration | Kubernetes (K8s), Helm |
| CI/CD | GitHub Actions, Docker |
| Secrets & Config | HashiCorp Vault |
| Monitoring | Grafana, Prometheus |
| Web Hosting | Nginx, PostgreSQL, Redis |
| Game Hosting | Dynamic provisioning logic for containerized game servers |

---

## 🗂️ What's Included

🗂️ What's Included
✅ Sample `main.tf` showing Terraform layout for base VM provisioning  
✅ Safe, demo-ready Terraform module for Proxmox-based VM deployment  
🚧 Kubernetes manifest examples (*.yaml) — coming soon  
🚧 Basic Ansible role structure — coming soon  
🚧 Architecture diagram or screenshots — coming soon  
📖 This README.md for public visibility  

> 🔐 Full code and deployment logic remain private for now. This demo repo is designed to give technical recruiters or collaborators a breakdown of architecture and tooling used.

---

## 📌 Demo Goals

✅ Display architectural thinking  
✅ Highlight DevOps & game hosting automation skills  
✅ Share safe, non-sensitive public breakdown  
🚧 More detailed implementation coming soon!

---

## 👩‍💻 About the Developer

**Rebecca Turner**  
DevSecOps & Infrastructure Automation Engineer  
Passionate about scalable backend systems, infrastructure orchestration, and secure hosting platforms.

📫 Portfolio: [mystshara.github.io](https://mystshara.github.io)  
💼 LinkedIn: [linkedin.com/in/rebecca-turner-81377598](https://www.linkedin.com/in/rebecca-turner-81377598)

---

## ✉️ Want to Collaborate or Learn More?

This project is part of a larger infrastructure-as-service buildout.  
If you're interested in hiring, collaborating, or reviewing more, please reach out!



