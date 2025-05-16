# NixOS Configuration

Welcome to the **NixOS Configuration** repository by DarthHelmut. This repository houses my personal, modular, and reproducible NixOS configuration files. It is designed to help you set up and customize your NixOS system using declarative configurations, ensuring consistency and ease of maintenance on your systems.

## Overview

This repository is built around several key principles:

- **Modularity:** Each component of the configuration is broken into manageable, logically separated modules.
- **Reproducibility:** Leverage the power of NixOS to recreate your system exactly as defined.
- **Monitoring & Optimization:** Integrated support for various monitoring tools (e.g., Prometheus, Grafana, Netdata) alongside system optimization tweaks.

Whether you're setting up a personal desktop or configuring servers, these files provide a robust starting point.

## Repository Structure

A typical directory layout in this repository might look like:


## Getting Started

### Prerequisites

- **NixOS:** A system running NixOS (the stable channel is recommended).
- **Familiarity with Nix:** Basic knowledge of the Nix language and declarative configuration.

### Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/DarthHelmut/NixOS.git
   cd NixOS


sudo nixos-rebuild switch -I nixos-config=./configuration.nix
In the .configuration.nix Uncomment the nvidiagpu.nix if you have a Nvidia gpu, "WAYLAND MAY OR NOT WORK"
If you dont want hyprland you can comment it out and make your own .nix for your DE/WM
