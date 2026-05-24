# Proxmox Host Updater

Uno script Bash leggero e robusto per automatizzare l'aggiornamento completo del sistema operativo del tuo host Proxmox VE. Lo script esegue la sincronizzazione dei repository, l'aggiornamento dei pacchetti (dist-upgrade), la pulizia dei file obsoleti e verifica automaticamente se è necessario un riavvio a causa di un aggiornamento del Kernel.

## 🚀 Caratteristiche

* **Dist-Upgrade:** Aggiornamento completo del sistema, gestendo correttamente le dipendenze.
* **Manutenzione Automatica:** Esegue `autoremove` e `autoclean` per mantenere il disco pulito da kernel obsoleti e cache inutile.
* **Kernel Monitor:** Confronta il kernel attualmente in uso con quello più recente installato su `/boot` e avvisa chiaramente se il sistema richiede un riavvio.
* **Log semplice:** Mostra data e ora di inizio e fine procedura.

## 📥 Installazione e Utilizzo

Puoi scaricare ed eseguire lo script direttamente sulla shell del tuo host Proxmox con un singolo comando:

```bash
wget -qLO update-proxmox.sh https://github.com/fcaronte/proxmox_update_host/raw/refs/heads/main/update-proxmox.sh && chmod +x update-proxmox.sh && ./update-proxmox.sh

```

## 📋 Cosa fa esattamente lo script?

1. **`apt-get update`**: Aggiorna l'elenco dei pacchetti disponibili dai repository.
2. **`apt-get dist-upgrade`**: Aggiorna il sistema gestendo le modifiche alle dipendenze (raccomandato per Proxmox).
3. **`apt-get autoremove`**: Rimuove i pacchetti installati automaticamente come dipendenze che non sono più necessari.
4. **`apt-get autoclean`**: Rimuove dalla cache i file dei pacchetti non più scaricabili o obsoleti.
5. **Kernel Check**: Esegue un confronto intelligente tra il kernel corrente (`uname -r`) e l'ultimo file kernel presente in `/boot`. Se non coincidono, ti avvisa che è necessario riavviare l'host per applicare le patch di sicurezza.

## ⚠️ Avvertenze

* **Riavvio:** Anche se lo script segnala la necessità di un riavvio, **non riavvierà automaticamente l'host**. È responsabilità dell'amministratore pianificare il riavvio nel momento più opportuno per minimizzare il downtime dei container e delle macchine virtuali.
* **Ambiente:** Lo script è ottimizzato per Proxmox VE. Assicurati di eseguirlo con privilegi di root.

---

### Personalizzazione

Se desideri che lo script sia eseguito automaticamente ogni settimana, puoi aggiungerlo al `crontab` di root:

1. Apri il crontab: `crontab -e`
2. Aggiungi questa riga per eseguirlo ogni lunedì alle 03:00:
```bash
0 3 * * 1 /percorso/di/update-proxmox.sh >> /var/log/proxmox-update.log 2>&1

```



---

*Creato per semplificare la manutenzione quotidiana di Proxmox.*
