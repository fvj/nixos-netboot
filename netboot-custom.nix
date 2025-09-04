{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/netboot/netboot-minimal.nix>
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;


# Ensure these modules are loaded
  boot.initrd.kernelModules = [
    "r8169"
    "nvme"
    "xhci_pci"
    "ahci"
  ];

  boot.kernelParams = [ "r8169.aspm=0" ];  # Disable ASPM for Realtek

# Blacklist nouveau to avoid issues with 5090
    boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.cpu.amd.updateMicrocode = true;
  boot.kernelModules = [ "kvm-amd" "zenpower" ];

  system.stateVersion = "25.11";
}
