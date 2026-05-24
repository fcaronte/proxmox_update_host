#!/bin/bash

echo "--- Inizio Aggiornamento Completo Proxmox: $(date) ---"

# 1. Sincronizza i repository
apt-get update

# 2. Aggiornamento intelligente (stile GUI Proxmox)
apt-get dist-upgrade -y

# 3. Rimuove pacchetti orfani e vecchi kernel non più necessari
# Fondamentale per non riempire il disco con versioni obsolete
apt-get autoremove -y

# 4. Pulizia della cache dei pacchetti scaricati
apt-get autoclean

# 5. Verifica se è richiesto un riavvio (Versione Corretta e Robusta)
running_kernel=$(uname -r)

# Cerchiamo l'ultimo file che contiene "-pve" nel nome
latest_kernel_file=$(ls -v /boot/vmlinuz-*-pve | tail -n 1)

if [ -z "$latest_kernel_file" ]; then
    echo "❌ Errore: Kernel non rilevato in /boot (controlla i permessi o il percorso)."
else
    # Puliamo il nome per il confronto
    latest_kernel=$(basename "$latest_kernel_file" | sed 's/vmlinuz-//')

    if [ "$running_kernel" != "$latest_kernel" ]; then
        echo ""
        echo "#####################################################"
        echo "⚠️  ATTENZIONE: RIAVVIO RICHIESTO ⚠️"
        echo "Kernel in uso:     $running_kernel"
        echo "Nuovo disponibile: $latest_kernel"
        echo "#####################################################"
    else
        echo ""
        echo "✅ Sistema aggiornato e Kernel allineato ($running_kernel)."
    fi
fi

echo ""
echo "--- Procedura terminata: $(date) ---"
