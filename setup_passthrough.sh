#!/bin/bash

# Script d'automatisation GPU Passthrough pour Intel Arc Pro B50 sur MS-02 Ultra
# Auteur: valorisa / ArcPass-MS02
# Ce script doit être exécuté en tant que root sur ton hôte Proxmox.
set -e

echo "--- Début de la configuration ArcPass-MS02 ---"

# 1. Sauvegarde des fichiers critiques
cp /etc/default/grub /etc/default/grub.bak
cp /etc/modules /etc/modules.bak

# 2. Configuration du GRUB pour IOMMU et ACS Override
echo "[-] Configuration du GRUB..."
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt pcie_acs_override=downstream,multifunction"/' /etc/default/grub
update-grub

# 3. Ajout des modules VFIO
echo "[-] Ajout des modules VFIO au noyau..."
cat <<EOF >> /etc/modules
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
EOF

# 4. Blacklist des drivers hôtes (pour libérer le GPU)
echo "[-] Blacklist des drivers Intel (i915/xe)..."
cat <<EOF > /etc/modprobe.d/pve-blacklist.conf
blacklist i915
blacklist xe
EOF

# 5. Message final
echo "--- Configuration terminée ! ---"
echo "[!] IMPORTANT : Vous devez identifier l'ID PCI de votre B50 avec 'lspci -nn | grep -i intel'"
echo "[!] Ajoutez ensuite ces IDs dans /etc/modprobe.d/vfio.conf"
echo "[!] Un redémarrage est nécessaire : type 'reboot'"
