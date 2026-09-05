# PS2 OPL SMB Share

Guest-accessible read/write SMB share with legacy SMB1 (NT1) support for PS2 Open PS2 Loader.

## Usage

```sh
docker-compose up -d --build
```

The container creates the standard OPL folders (DVD, CD, CFG, ART, VMC, LNG, THM, CHT) at the share root on every start. Drop game ISOs into `/Volumes/WANDERER/PS2SMB/DVD/` or `/Volumes/WANDERER/PS2SMB/CD/`.

Share details:

- Share name: `PS2SMB`
- Access: log in as user `guest` with no password, read and write
- Folders on the host: `/Volumes/WANDERER/PS2SMB`
- Ports: 139 and 445

## Connecting

Use the IP of the machine running the container (find it with `ipconfig getifaddr en0` on macOS or `hostname -I` on Linux). Every client logs in as user `guest` with no password.

macOS Finder — Go → Connect to Server (`Cmd+K`), enter `smb://<host-ip>/PS2SMB`, user `guest`, password empty.

Windows Explorer — address bar: `\\<host-ip>\PS2SMB`, user `guest`, password empty.

Linux with cifs-utils — `mount -t cifs //<host-ip>/PS2SMB /mnt/ps2smb -o username=guest,password=`

Quick check from Linux or with samba-client installed — `smbclient -m NT1 //<host-ip>/PS2SMB -U guest% -c "ls"` (the `-m NT1` flag simulates the legacy protocol OPL uses).

## OPL settings

In the OPL Network Settings set:

- PS2 IP: any free address in your LAN subnet
- Gateway / Mask: your LAN values
- SMB server: IP or hostname of the machine running this container
- Share: `PS2SMB`
- User: `guest`, Password: leave empty

Set the game type to SMB in the OPL main menu and start games from `DVD` / `CD`.

## Tuning

Edit `smb.conf`, then rebuild and restart with `docker-compose up -d --build`. The `server min protocol = NT1` line enables the legacy SMB1 dialect OPL requires; it can be removed if the share is only used by modern clients.

## Security

SMB1 and passwordless guest access are intentionally enabled for a 2000-era console. Run this container only on a trusted network and do not expose ports to the internet.
