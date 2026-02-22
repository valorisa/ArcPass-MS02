# ArcPass-MS02 🚀 

![Proxmox](https://img.shields.io/badge/Proxmox-VE_8.x-orange?logo=proxmox)
![Intel](https://img.shields.io/badge/GPU-Intel_Arc_Pro_B50-blue?logo=intel)
![Hardware](https://img.shields.io/badge/Hardware-Minisforum_MS--02_Ultra-white)
![License](https://img.shields.io/badge/License-MIT-green)

**ArcPass-MS02** est une solution "One-Click" (ou presque) pour automatiser le **GPU Passthrough** d'une carte **Intel Arc Pro B50** (Architecture Battlemage) sur un nœud **Proxmox VE**. 

Optimisé spécifiquement pour le châssis compact du **Minisforum MS-02 Ultra**, ce script configure le noyau, isole les périphériques et prépare l'environnement pour l'IA, le transcodage AV1 et le Cloud Gaming.

---

## ✨ Points forts
* 🛠 **Automatisation Kernel** : Configure GRUB et les modules VFIO sans erreur manuelle.
* ⚡ **Optimisation Battlemage** : Prise en charge native des nouveaux drivers `xe`.
* 🛡 **Sécurité** : Sauvegarde automatique de vos fichiers de configuration (`.bak`).

## 🛠 Prérequis

### 1. Configuration du BIOS (Crucial)
Accédez au BIOS de votre MS-02 Ultra et activez les options suivantes :
| Paramètre | État |
| :--- | :--- |
| **VT-d** | `Enabled` |
| **SR-IOV Support** | `Enabled` |
| **Above 4G Decoding** | `Enabled` |
| **Resizable BAR (ReBAR)** | `Enabled` |
| **Primary Display** | `Auto` or `IGFX` |

### 2. Système d'exploitation
- Proxmox VE 8.1 ou version ultérieure (Kernel 6.5+ recommandé).

---

## 🚀 Installation & Usage

### Étape 1 : Clonage et exécution
```bash
git clone https://github.com/valorisa/ArcPass-MS02.git
cd ArcPass-MS02
chmod +x setup_passthrough.sh
sudo ./setup_passthrough.sh
```

### Étape 2 : Identification du matériel
Une fois le script terminé, identifiez vos IDs PCI :
```bash
lspci -nn | grep -i intel
```

Cherchez la ligne correspondant à votre Arc Pro B50 (ex: [8086:abcd]).
Étape 3 : Finalisation
Éditez le fichier de configuration VFIO avec vos IDs :

```bash
echo "options vfio-pci ids=8086:VOTRE_ID_GPU,8086:VOTRE_ID_AUDIO" > /etc/modprobe.d/vfio.conf
update-initramfs -u
reboot
```

🖥 Configuration de la VM (GUI Proxmox)
Pour des performances optimales avec l'Intel Arc Pro B50 :
 * OS Type : Linux (Kernel 6.8+) ou Windows 11.
 * Machine : q35.
 * BIOS : OVMF (UEFI).
 * Hardware Add : PCI Device -> Sélectionnez la B50.
   * ✅ All Functions
   * ✅ Primary GPU
   * ✅ ROM-Bar
   * ✅ PCI-Express

⚠️ Dépannage (Troubleshooting)
 * Code 43 (Windows) : Assurez-vous que le paramètre PCI-Express est coché dans la config matérielle de la VM.
 * Performances faibles : Vérifiez que le Resizable BAR est bien activé dans le BIOS ; les cartes Intel Arc en dépendent pour la gestion de la mémoire.
 * L'hôte ne démarre plus : Si vous avez blacklisted l'iGPU par erreur, utilisez l'accès SSH pour restaurer /etc/default/grub.bak.

## 📄 Licence
Distribué sous licence MIT. Voir LICENSE pour plus d'informations.

