# ArcPass-MS02 🚀

**ArcPass-MS02** est un script d'automatisation conçu pour configurer le GPU Passthrough d'une carte **Intel Arc Pro B50** sur un mini-PC **Minisforum MS-02 Ultra** tournant sous Proxmox VE.

Ce projet optimise l'utilisation de l'architecture Intel Battlemage pour l'IA, le transcodage vidéo et le cloud gaming personnel.

## 🛠 Prérequis

- **Matériel** : Minisforum MS-02 Ultra + Intel Arc Pro B50 (ou série B).
- **BIOS** : 
  - VT-d : `Enabled`
  - SR-IOV : `Enabled`
  - ReBAR (Resizable BAR) : `Enabled`
  - Above 4G Decoding : `Enabled`
- **OS** : Proxmox VE 8.x ou supérieur.

## 🚀 Installation rapide

1. Clonez le dépôt sur votre hôte Proxmox :
   ```bash
   git clone [https://github.com/votre-pseudo/ArcPass-MS02.git](https://github.com/votre-pseudo/ArcPass-MS02.git)
   cd ArcPass-MS02

 * Rendez le script exécutable :
   chmod +x setup_passthrough.sh

 * Exécutez le script en tant que root :
   ./setup_passthrough.sh

⚙️ Configuration Post-Installation
Une fois le script exécuté :
 * Trouvez les IDs de votre GPU :
   lspci -nn | grep -i intel

   Notez les codes entre crochets, ex: [8086:abcd].
 * Créez le fichier d'ID VFIO :
   echo "options vfio-pci ids=8086:votre_id_gpu,8086:votre_id_audio" > /etc/modprobe.d/vfio.conf

 * Redémarrez l'hôte.
🖥 Configuration de la VM (Proxmox GUI)
Pour que la carte fonctionne dans votre VM :
 * Machine : q35
 * BIOS : OVMF (UEFI)
 * Add PCI Device : Sélectionnez l'Intel Arc B50.
 * Options à cocher : All Functions, Primary GPU (si pas de GPU virtuel), ROM-Bar, PCI-Express.

📄 Licence
Ce projet est sous licence MIT. Libre à vous de l'utiliser et de le modifier.

---
