Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWIIVzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWIIVzf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 17:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWIIVzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 17:55:35 -0400
Received: from smtp2.libero.it ([193.70.192.52]:27604 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S964876AbWIIVzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 17:55:33 -0400
From: srtcst@libero.it
To: linux-kernel@vger.kernel.org
Subject: bug kernel - filesystem
Date: Sat, 9 Sep 2006 23:55:35 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XhzAFO5BLWXk/kI"
Message-Id: <200609092355.35183.srtcst@libero.it>
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_XhzAFO5BLWXk/kI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

After partition mount and copy files block disk ( sleep )
System function ok poweroff finished correct.
Probable files damaged!!
dmesg total after bug.
Hardware:
mainboard qdi advance 10b/f
video nvidia 400 mx
Other information on dmesg attachment.

Cristian Sartori

Italy

=2D-=20
=2D------------------------------------------------------------------------=
=2D--

       Questo Pc e' libero dal Monopolio di Microsoft
            OPEN SOURCE - GNU PUBLIC LICENSE
         LINUX LA POTENZA E' NULLA SENZA CONTROLLO
      Cristian Sartori Schio (Vicenza) Nord-est Italy
=2D------------------------------------------------------------------------=
=2D--


=2D------------------------------------------------------------------------=
=2D--

Le informazioni trasmesse sono destinate esclusivamente alla persona o
alla societ=E0 in indirizzo e sono da intendersi confidenziali e riservate.
Ogni trasmissione, inoltro, diffusione o altro uso di queste
informazioni a persone o societ=E0 differenti dal destinatario =E9 proibita.
Se ricevete questa comunicazione per errore, contattate il mittente e
cancellate le informazioni da ogni computer.

The information transmitted is intended only for the person or entity to
which it is addressed and may contain confidential and/or privileged
material.  Any review, retransmission, dissemination or other use of, or
taking of any action in reliance upon, this information by persons or
entities other than the intended recipient is prohibited.
If you received this in error, please contact the sender and delete
the material from any computer.
=2D------------------------------------------------------------------------=
=2D--

--Boundary-00=_XhzAFO5BLWXk/kI
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg-log-kernel.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-log-kernel.txt"

Linux version 2.6.17-1.2174_FC5 (brewbuilder@hs20-bc2-3.build.redhat.com) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 Tue Aug 8 15:30:55 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
 BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
767MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 196592
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 192496 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 QDIGRP                                ) @ 0x000f7e00
ACPI: RSDT (v001 QDIGRP AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x2fff3000
ACPI: FADT (v001 QDIGRP AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x2fff3040
ACPI: DSDT (v001 QDIGRP AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Allocating PCI resources starting at 40000000 (gap: 30000000:cfff0000)
Built 1 zonelists
Kernel command line: ro root=/dev/hdb6 rhgb quiet
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01607000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c075c000 soft=c075b000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 997.568 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 774024k/786368k available (2068k kernel code, 11800k reserved, 1127k data, 216k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1997.33 BogoMIPS (lpj=3994663)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383f1ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 0a
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0800 (from 0e20)
checking if image is initramfs... it is
Freeing initrd memory: 933k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb1d0, last bus=1
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 6000-607f claimed by vt82c686 HW-mon
PCI quirk: region 5000-500f claimed by vt82c686 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: d8000000-d9ffffff
  PREFETCH window: d0000000-d7ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1157833432.492:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 159031EDF350496D
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Disabling Via external APIC routing
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 2 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: AGP aperture is 4M @ 0xda000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
PCI: VIA IRQ fixup for 0000:00:07.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6Y120L0, ATA DISK drive
hdb: Maxtor 6Y080L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: PIONEER DVD-RW DVR-110D, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST GCE-8526B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
hdb: max request size: 128KiB
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 hdb11 >
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
PCI0 USB0 USB1 MODM UAR1 UAR2 ECP1 
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 216k freed
Write protecting the kernel read-only data: 705k
input: AT Translated Set 2 keyboard as /class/input/input0
input: ImExPS/2 Logitech Wheel Mouse as /class/input/input1
ReiserFS: hdb6: found reiserfs format "3.6" with standard journal
ReiserFS: hdb6: using ordered data mode
ReiserFS: hdb6: journal params: device hdb6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb6: checking transaction log (hdb6)
ReiserFS: hdb6: Using r5 hash to sort names
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1157833439.308:2): selinux=0 auid=4294967295
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
8139cp: pci dev 0000:00:09.0 (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
8139cp: Try the "8139too" driver instead.
gameport: EMU10K1 is pci0000:00:0a.1/gameport0, io 0xe400, speed 1242kHz
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
eth0: RealTek RTL8139 at 0xf0944000, 00:06:7b:03:94:d5, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
parport_pc: VIA parallel port: io=0x378, irq=7
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
PCI: VIA IRQ fixup for 0000:00:07.2, from 9 to 10
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 10, io base 0x0000d400
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:07.3[D] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
PCI: VIA IRQ fixup for 0000:00:07.3, from 9 to 10
uhci_hcd 0000:00:07.3: UHCI Host Controller
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:07.3: irq 10, io base 0x0000d800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-2: new full speed USB device using uhci_hcd and address 2
usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
lp0: using parport0 (interrupt-driven).
lp0: console ready
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
ReiserFS: hdb7: found reiserfs format "3.6" with standard journal
ReiserFS: hdb7: using ordered data mode
ReiserFS: hdb7: journal params: device hdb7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb7: checking transaction log (hdb7)
ReiserFS: hdb7: Using r5 hash to sort names
ReiserFS: hdb5: found reiserfs format "3.6" with standard journal
ReiserFS: hdb5: using ordered data mode
ReiserFS: hdb5: journal params: device hdb5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb5: checking transaction log (hdb5)
ReiserFS: hdb5: Using r5 hash to sort names
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
Adding 273128k swap on /dev/hda7.  Priority:-1 extents:1 across:273128k
Adding 216680k swap on /dev/hdb11.  Priority:-2 extents:1 across:216680k
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (6143 buckets, 49144 max) - 224 bytes per conntrack
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
eth0: no IPv6 routers present
ReiserFS: hdb8: found reiserfs format "3.6" with standard journal
ReiserFS: hdb8: using ordered data mode
ReiserFS: hdb8: journal params: device hdb8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb8: checking transaction log (hdb8)
ReiserFS: hdb8: Using r5 hash to sort names
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
application firefox-bin uses obsolete OSS audio interface
application mplayer uses obsolete OSS audio interface
BUG: unable to handle kernel paging request at virtual address 00020000
 printing eip:
c043f898
*pde = 183fb067
Oops: 0000 [#1]
last sysfs file: /devices/platform/i2c-9191/9191-6000/temp1_input
Modules linked in: autofs4 eeprom hidp l2cap bluetooth sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables x_tables acpi_cpufreq ipv6 dm_mirror dm_mod video button battery ac lp uhci_hcd floppy snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_device parport_pc snd_timer i2c_viapro parport snd_page_alloc 8139too via686a emu10k1_gp serio_raw snd_util_mem 8139cp hwmon snd_hwdep i2c_isa mii gameport snd i2c_core soundcore reiserfs
CPU:    0
EIP:    0060:[<c043f898>]    Not tainted VLI
EFLAGS: 00010006   (2.6.17-1.2174_FC5 #1) 
EIP is at find_lock_page+0x20/0x7a
eax: 00020000   ebx: 00000000   ecx: 00020000   edx: 00000000
esi: 00020000   edi: dc48aa5c   ebp: 000027c3   esp: ece5fc30
ds: 007b   es: 007b   ss: 0068
Process mc (pid: 3078, threadinfo=ece5f000 task=da07caa0)
Stack: 00000000 ece5fde4 000200d2 00000002 c0441bae c13fe040 000027c3 dc48aa5c 
       c06bf998 dc48aa5c ece5fde4 027c2000 00000000 f086a6fd 00000000 da07caa0 
       c042c17c ece5fc74 ece5fc74 00000000 dc48a974 00000003 0000002c 000027c3 
Call Trace:
 <c0441bae> find_or_create_page+0x31/0x8f  <f086a6fd> reiserfs_prepare_file_region_for_write+0x9a/0x781 [reiserfs]
 <c042c17c> autoremove_wake_function+0x0/0x35  <f0870c32> reiserfs_dirty_inode+0x68/0x6e [reiserfs]
 <c04204e4> current_fs_time+0x45/0x51  <f086b6dc> reiserfs_file_write+0x58d/0x19cf [reiserfs]
 <c0445791> blockable_page_cache_readahead+0x4c/0x9f  <c0445860> make_ahead_window+0x7c/0x99
 <c04204e4> current_fs_time+0x45/0x51  <c0473766> touch_atime+0x60/0x92
 <c0440127> do_generic_mapping_read+0x418/0x465  <c044098d> __generic_file_aio_read+0x167/0x1ac
 <c043f625> file_read_actor+0x0/0xe0  <c042f6b2> debug_mutex_add_waiter+0x1c/0x2c
 <c0602194> __mutex_lock_slowpath+0x339/0x439  <c04810ef> inotify_inode_queue_event+0x3e/0x126
 <c0441a06> generic_file_read+0xa3/0xb9  <c04810ef> inotify_inode_queue_event+0x3e/0x126
 <c04810ef> inotify_inode_queue_event+0x3e/0x126  <c0601e4b> __mutex_unlock_slowpath+0x1e7/0x1ef
 <c0470b65> dput+0x35/0x230  <f086b14f> reiserfs_file_write+0x0/0x19cf [reiserfs]
 <c045c523> vfs_write+0xa8/0x150  <c045ca57> sys_write+0x41/0x67
 <c0402cb3> syscall_call+0x7/0xb 
Code: ff 89 da 31 c9 5b e9 bb c8 fe ff 55 89 d5 57 89 c7 56 53 8d 40 10 e8 a8 32 1c 00 8d 47 04 89 ea e8 66 65 09 00 85 c0 89 c6 74 4b <8b> 00 89 f2 f6 c4 40 74 03 8b 56 0c ff 42 04 0f ba 2e 00 19 c0 
EIP: [<c043f898>] find_lock_page+0x20/0x7a SS:ESP 0068:ece5fc30
 <3>BUG: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():0, irqs_disabled():1
 <c0426d91> blocking_notifier_call_chain+0x18/0x49  <c041e800> do_exit+0x19/0x768
 <c0529103> do_unblank_screen+0x2a/0x127  <c04042c0> die+0x27b/0x2a0
 <c0603b4e> do_page_fault+0x443/0x5ad  <c060370b> do_page_fault+0x0/0x5ad
 <c04037df> error_code+0x4f/0x54  <c043f898> find_lock_page+0x20/0x7a
 <c0441bae> find_or_create_page+0x31/0x8f  <f086a6fd> reiserfs_prepare_file_region_for_write+0x9a/0x781 [reiserfs]
 <c042c17c> autoremove_wake_function+0x0/0x35  <f0870c32> reiserfs_dirty_inode+0x68/0x6e [reiserfs]
 <c04204e4> current_fs_time+0x45/0x51  <f086b6dc> reiserfs_file_write+0x58d/0x19cf [reiserfs]
 <c0445791> blockable_page_cache_readahead+0x4c/0x9f  <c0445860> make_ahead_window+0x7c/0x99
 <c04204e4> current_fs_time+0x45/0x51  <c0473766> touch_atime+0x60/0x92
 <c0440127> do_generic_mapping_read+0x418/0x465  <c044098d> __generic_file_aio_read+0x167/0x1ac
 <c043f625> file_read_actor+0x0/0xe0  <c042f6b2> debug_mutex_add_waiter+0x1c/0x2c
 <c0602194> __mutex_lock_slowpath+0x339/0x439  <c04810ef> inotify_inode_queue_event+0x3e/0x126
 <c0441a06> generic_file_read+0xa3/0xb9  <c04810ef> inotify_inode_queue_event+0x3e/0x126
 <c04810ef> inotify_inode_queue_event+0x3e/0x126  <c0601e4b> __mutex_unlock_slowpath+0x1e7/0x1ef
 <c0470b65> dput+0x35/0x230  <f086b14f> reiserfs_file_write+0x0/0x19cf [reiserfs]
 <c045c523> vfs_write+0xa8/0x150  <c045ca57> sys_write+0x41/0x67
 <c0402cb3> syscall_call+0x7/0xb 

==========================================
[ BUG: lock recursion deadlock detected! |
------------------------------------------

mc/3078 is trying to acquire this lock:
 [dc48a9f8] {inode_init_once}
.. held by:                mc: 3078 [da07caa0, 118]
... acquired at:               reiserfs_file_write+0x1f5/0x19cf [reiserfs]
... trying at:                 reiserfs_file_release+0x169/0x37a [reiserfs]
------------------------------
| showing all locks held by: |  (mc/3078 [da07caa0, 118]):
------------------------------

#001:             [dc48a9f8] {inode_init_once}
... acquired at:               reiserfs_file_write+0x1f5/0x19cf [reiserfs]


mc/3078's [current] stackdump:

 <c042f517> report_deadlock+0x11b/0x135  <c042f68e> check_deadlock+0x15d/0x165
 <f086cc87> reiserfs_file_release+0x169/0x37a [reiserfs]  <c042f6b2> debug_mutex_add_waiter+0x1c/0x2c
 <f086cc87> reiserfs_file_release+0x169/0x37a [reiserfs]  <c0601faa> __mutex_lock_slowpath+0x14f/0x439
 <f086cc87> reiserfs_file_release+0x169/0x37a [reiserfs]  <c0602194> __mutex_lock_slowpath+0x339/0x439
 <c04810ef> inotify_inode_queue_event+0x3e/0x126  <f086cc87> reiserfs_file_release+0x169/0x37a [reiserfs]
 <f086cc87> reiserfs_file_release+0x169/0x37a [reiserfs]  <c0601e4b> __mutex_unlock_slowpath+0x1e7/0x1ef
 <c0470b65> dput+0x35/0x230  <c045cdf2> __fput+0xb2/0x158
 <c045a724> filp_close+0x52/0x59  <c041d918> put_files_struct+0x63/0xa5
 <c041e9df> do_exit+0x1f8/0x768  <c0529103> do_unblank_screen+0x2a/0x127
 <c04042c0> die+0x27b/0x2a0  <c0603b4e> do_page_fault+0x443/0x5ad
 <c060370b> do_page_fault+0x0/0x5ad  <c04037df> error_code+0x4f/0x54
 <c043f898> find_lock_page+0x20/0x7a  <c0441bae> find_or_create_page+0x31/0x8f
 <f086a6fd> reiserfs_prepare_file_region_for_write+0x9a/0x781 [reiserfs]  <c042c17c> autoremove_wake_function+0x0/0x35
 <f0870c32> reiserfs_dirty_inode+0x68/0x6e [reiserfs]  <c04204e4> current_fs_time+0x45/0x51
 <f086b6dc> reiserfs_file_write+0x58d/0x19cf [reiserfs]  <c0445791> blockable_page_cache_readahead+0x4c/0x9f
 <c0445860> make_ahead_window+0x7c/0x99  <c04204e4> current_fs_time+0x45/0x51
 <c0473766> touch_atime+0x60/0x92  <c0440127> do_generic_mapping_read+0x418/0x465
 <c044098d> __generic_file_aio_read+0x167/0x1ac  <c043f625> file_read_actor+0x0/0xe0
 <c042f6b2> debug_mutex_add_waiter+0x1c/0x2c  <c0602194> __mutex_lock_slowpath+0x339/0x439
 <c04810ef> inotify_inode_queue_event+0x3e/0x126  <c0441a06> generic_file_read+0xa3/0xb9
 <c04810ef> inotify_inode_queue_event+0x3e/0x126  <c04810ef> inotify_inode_queue_event+0x3e/0x126
 <c0601e4b> __mutex_unlock_slowpath+0x1e7/0x1ef  <c0470b65> dput+0x35/0x230
 <f086b14f> reiserfs_file_write+0x0/0x19cf [reiserfs]  <c045c523> vfs_write+0xa8/0x150
 <c045ca57> sys_write+0x41/0x67  <c0402cb3> syscall_call+0x7/0xb

Showing all blocking locks in the system:
S            init:    1 [efec1aa0, 116] (not blocked on mutex)
S     ksoftirqd/0:    2 [efec1550, 134] (not blocked on mutex)
S      watchdog/0:    3 [efec1000,   0] (not blocked on mutex)
S        events/0:    4 [effdfaa0, 110] (not blocked on mutex)
S         khelper:    5 [effdf550, 110] (not blocked on mutex)
S         kthread:    6 [effdf000, 110] (not blocked on mutex)
S       kblockd/0:    8 [effc9550, 110] (not blocked on mutex)
S          kacpid:    9 [effc9000, 120] (not blocked on mutex)
S           khubd:   69 [eff61550, 110] (not blocked on mutex)
S         kseriod:   71 [eff5daa0, 110] (not blocked on mutex)
S         pdflush:  127 [eff29000, 115] (not blocked on mutex)
S         kswapd0:  128 [eff2daa0, 115] (not blocked on mutex)
S           aio/0:  129 [eff2d550, 120] (not blocked on mutex)
S       kpsmoused:  307 [efc89550, 111] (not blocked on mutex)
S    nash-hotplug:  319 [eff61000, 115] (not blocked on mutex)
S      reiserfs/0:  322 [eff2d000, 110] (not blocked on mutex)
S         kauditd:  360 [eff5d000, 111] (not blocked on mutex)
S           udevd:  384 [effc9aa0, 112] (not blocked on mutex)
S      kgameportd:  625 [eedca550, 110] (not blocked on mutex)
S        kmirrord: 1368 [efc7faa0, 111] (not blocked on mutex)
D         syslogd: 1699 [eff91000, 115] (not blocked on mutex)
S           klogd: 1702 [efc85aa0, 115] (not blocked on mutex)
S         portmap: 1721 [eedcaaa0, 119] (not blocked on mutex)
S       rpc.statd: 1740 [eefcc550, 120] (not blocked on mutex)
S      rpc.idmapd: 1764 [eefcc000, 115] (not blocked on mutex)
S     dbus-daemon: 1778 [eff5d550, 116] (not blocked on mutex)
S            hidd: 1815 [efc85550, 115] (not blocked on mutex)
S       automount: 1934 [effa8000, 116] (not blocked on mutex)
S           acpid: 1947 [eff29aa0, 116] (not blocked on mutex)
S           cupsd: 1957 [efc85000, 115] (not blocked on mutex)
S            sshd: 1965 [ee9ed000, 124] (not blocked on mutex)
S          xinetd: 1975 [ee9edaa0, 122] (not blocked on mutex)
S           spamd: 1985 [efc7f550, 115] (not blocked on mutex)
S             gpm: 1995 [eff91550, 115] (not blocked on mutex)
S           crond: 2004 [eff38000, 116] (not blocked on mutex)
S             xfs: 2039 [eff6e550, 116] (not blocked on mutex)
S           spamd: 2048 [eff6eaa0, 116] (not blocked on mutex)
S           spamd: 2049 [eff61aa0, 116] (not blocked on mutex)
S            smbd: 2050 [eff6e000, 120] (not blocked on mutex)
S            smbd: 2053 [eff38aa0, 121] (not blocked on mutex)
S            nmbd: 2054 [eedca000, 115] (not blocked on mutex)
S         anacron: 2080 [ee8ad000, 139] (not blocked on mutex)
S             atd: 2089 [efc89000, 116] (not blocked on mutex)
S    avahi-daemon: 2153 [efc7f000, 115] (not blocked on mutex)
S    avahi-daemon: 2154 [e5c08aa0, 124] (not blocked on mutex)
S cups-config-dae: 2163 [e33a9aa0, 124] (not blocked on mutex)
S            hald: 2173 [e2c5d550, 115] (not blocked on mutex)
S     hald-runner: 2174 [e4b7b000, 116] (not blocked on mutex)
S hald-addon-acpi: 2180 [e28c6aa0, 118] (not blocked on mutex)
S hald-addon-keyb: 2184 [e28c6550, 115] (not blocked on mutex)
S hald-addon-stor: 2194 [e28c6000, 115] (not blocked on mutex)
D hald-addon-stor: 2196 [e2be6aa0, 116] (not blocked on mutex)
S        mingetty: 2256 [e4b7baa0, 116] (not blocked on mutex)
S        mingetty: 2259 [e33a9550, 116] (not blocked on mutex)
S        mingetty: 2262 [e2d94aa0, 116] (not blocked on mutex)
S        mingetty: 2265 [e3106000, 116] (not blocked on mutex)
S        mingetty: 2268 [e2d38aa0, 119] (not blocked on mutex)
S        mingetty: 2277 [e2be6550, 118] (not blocked on mutex)
S          prefdm: 2280 [ee8adaa0, 122] (not blocked on mutex)
S             kdm: 2328 [eff91aa0, 116] (not blocked on mutex)
S               X: 2330 [e4b7b550, 115] (not blocked on mutex)
S             kdm: 2331 [e2d38000, 117] (not blocked on mutex)
S        startkde: 2354 [eefccaa0, 116] (not blocked on mutex)
S       ssh-agent: 2389 [effa8aa0, 115] (not blocked on mutex)
S     dbus-launch: 2392 [e2c5d000, 116] (not blocked on mutex)
S     dbus-daemon: 2393 [efc89aa0, 125] (not blocked on mutex)
S         kdeinit: 2448 [e2d94000, 116] (not blocked on mutex)
S      dcopserver: 2451 [e383b000, 115] (not blocked on mutex)
S       klauncher: 2453 [e2d38550, 115] (not blocked on mutex)
S            kded: 2455 [ee9ed550, 115] (not blocked on mutex)
S      gam_server: 2457 [e383b550, 115] (not blocked on mutex)
S         kaccess: 2467 [e5c08550, 115] (not blocked on mutex)
S           artsd: 2471 [e5c08000, 115] (not blocked on mutex)
S        kwrapper: 2472 [e33a9000, 115] (not blocked on mutex)
S       ksmserver: 2474 [ee8ad550, 115] (not blocked on mutex)
S            kwin: 2475 [eff38550, 115] (not blocked on mutex)
S        kdesktop: 2478 [e2d94550, 115] (not blocked on mutex)
S          kicker: 2480 [e2c5daa0, 115] (not blocked on mutex)
S        kio_file: 2481 [e3106550, 115] (not blocked on mutex)
S            kmix: 2484 [effa8550, 115] (not blocked on mutex)
S         konsole: 2485 [e2be6000, 115] (not blocked on mutex)
S      krandrtray: 2487 [da07c550, 115] (not blocked on mutex)
S        ksensors: 2489 [d9ca4aa0, 115] (not blocked on mutex)
S            xmms: 2490 [d9ca4550, 115] (not blocked on mutex)
S            xmms: 2491 [e383baa0, 115] (not blocked on mutex)
S            xmms: 2551 [d7c3d550, 115] (not blocked on mutex)
S           opera: 2492 [d9ca4000, 115] (not blocked on mutex)
S        kwikdisk: 2495 [da07c000, 115] (not blocked on mutex)
S            bash: 2496 [d83c5aa0, 115] (not blocked on mutex)
S            bash: 2498 [d83c5000, 115] (not blocked on mutex)
S            bash: 2502 [d7c3d000, 116] (not blocked on mutex)
S           kmail: 2549 [d7fa2550, 115] (not blocked on mutex)
S           kmail: 2555 [e3106aa0, 117] (not blocked on mutex)
S           kmail: 2556 [d7f39aa0, 117] (not blocked on mutex)
S           kmail: 2557 [d7f39550, 117] (not blocked on mutex)
S           kmail: 2558 [d7f39000, 117] (not blocked on mutex)
S         knotify: 2554 [d83c5550, 115] (not blocked on mutex)
S         firefox: 2612 [d4884000, 121] (not blocked on mutex)
S  run-mozilla.sh: 2621 [d4cbb000, 122] (not blocked on mutex)
S     firefox-bin: 2626 [d4c5caa0, 115] (not blocked on mutex)
S     firefox-bin: 2627 [d4cbb550, 115] (not blocked on mutex)
S     firefox-bin: 2628 [d4c5c000, 115] (not blocked on mutex)
S        gconfd-2: 2630 [d57ec000, 115] (not blocked on mutex)
S             k3b: 2688 [d420f000, 115] (not blocked on mutex)
S              su: 2891 [d4c5c550, 117] (not blocked on mutex)
S            bash: 2894 [d7c3daa0, 115] (not blocked on mutex)
S              mc: 2919 [d4cbbaa0, 115] (not blocked on mutex)
S            bash: 2921 [d57ec550, 116] (not blocked on mutex)
R              mc: 3078 [da07caa0, 118] (not blocked on mutex)
D            bash: 3080 [d4884aa0, 116] (not blocked on mutex)
S        kio_pop3: 3205 [c925b000, 115] (not blocked on mutex)
S        kio_pop3: 3209 [d7fa2000, 115] (not blocked on mutex)
S        kio_pop3: 3215 [c925b550, 115] (not blocked on mutex)
S        kio_pop3: 3221 [df4a6550, 115] (not blocked on mutex)
D         pdflush: 3267 [df4a6000, 115] (not blocked on mutex)

---------------------------
| showing all locks held: |
---------------------------

#001:             [e2f91414] {initialize_tty_struct}
.. held by:          mingetty: 2256 [e4b7baa0, 116]
... acquired at:               read_chan+0x1aa/0x56e

#002:             [ef53fc14] {initialize_tty_struct}
.. held by:          mingetty: 2259 [e33a9550, 116]
... acquired at:               read_chan+0x1aa/0x56e

#003:             [ef53f414] {initialize_tty_struct}
.. held by:          mingetty: 2262 [e2d94aa0, 116]
... acquired at:               read_chan+0x1aa/0x56e

#004:             [e33adc14] {initialize_tty_struct}
.. held by:          mingetty: 2265 [e3106000, 116]
... acquired at:               read_chan+0x1aa/0x56e

#005:             [e33ad414] {initialize_tty_struct}
.. held by:          mingetty: 2277 [e2be6550, 118]
... acquired at:               read_chan+0x1aa/0x56e

#006:             [edfb1c14] {initialize_tty_struct}
.. held by:          mingetty: 2268 [e2d38aa0, 119]
... acquired at:               read_chan+0x1aa/0x56e

#007:             [da2b4414] {initialize_tty_struct}
.. held by:              bash: 2921 [d57ec550, 116]
... acquired at:               read_chan+0x1aa/0x56e

#008:             [da2b4c14] {initialize_tty_struct}
.. held by:              bash: 2502 [d7c3d000, 116]
... acquired at:               read_chan+0x1aa/0x56e

#009:             [d4685858] {alloc_super}
.. held by:           pdflush: 3267 [df4a6000, 115]
... acquired at:               sync_supers+0x6d/0xe6

#010:             [dc48a9f8] {inode_init_once}
.. held by:                mc: 3078 [da07caa0, 118]
... acquired at:               reiserfs_file_write+0x1f5/0x19cf [reiserfs]

#011:             [e6b24e68] {inode_init_once}
.. held by:           syslogd: 1699 [eff91000, 115]
... acquired at:               reiserfs_file_write+0x1f5/0x19cf [reiserfs]

=============================================

[ turning off deadlock detection. Please report this. ]

BUG: unable to handle kernel paging request at virtual address 00020000
 printing eip:
c043f7a0
*pde = 2b7b1067
Oops: 0000 [#2]
last sysfs file: /devices/platform/i2c-9191/9191-6000/temp1_input
Modules linked in: autofs4 eeprom hidp l2cap bluetooth sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables x_tables acpi_cpufreq ipv6 dm_mirror dm_mod video button battery ac lp uhci_hcd floppy snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_device parport_pc snd_timer i2c_viapro parport snd_page_alloc 8139too via686a emu10k1_gp serio_raw snd_util_mem 8139cp hwmon snd_hwdep i2c_isa mii gameport snd i2c_core soundcore reiserfs
CPU:    0
EIP:    0060:[<c043f7a0>]    Not tainted VLI
EFLAGS: 00010006   (2.6.17-1.2174_FC5 #1) 
EIP is at find_get_page+0x23/0x3f
eax: 00020000   ebx: 00020000   ecx: 0000c800   edx: 00000000
esi: 0000c874   edi: cecb3a6c   ebp: 0000c874   esp: dfb3ce28
ds: 007b   es: 007b   ss: 0068
Process mc (pid: 3427, threadinfo=dfb3c000 task=d7fa2aa0)
Stack: 00000000 dfb3ced8 00002000 c043fe49 0000c874 00000002 0000c874 00000000 
       d831e900 d831e950 cecb3a5c cecb3974 0004b1b3 00000000 0000c876 0000c876 
       0000c873 4b1b4000 00000000 00000000 00001000 0000c85c 00000020 00000000 
Call Trace:
 <c043fe49> do_generic_mapping_read+0x13a/0x465  <c044098d> __generic_file_aio_read+0x167/0x1ac
 <c043f625> file_read_actor+0x0/0xe0  <c0441963> generic_file_read+0x0/0xb9
 <c0441a06> generic_file_read+0xa3/0xb9  <c042c17c> autoremove_wake_function+0x0/0x35
 <c0602aed> _spin_unlock_irq+0x5/0x7  <c042458f> do_sigaction+0x147/0x158
 <c045c671> vfs_read+0xa6/0x14e  <c045c9f0> sys_read+0x41/0x67
 <c0402cb3> syscall_call+0x7/0xb 
Code: 83 c4 0c 5b 5e 5f 5d c3 57 56 89 d6 8d 78 10 53 89 c3 89 f8 83 c3 04 e8 9f 33 1c 00 89 d8 89 f2 e8 5e 66 09 00 85 c0 89 c3 74 0f <8b> 00 89 da f6 c4 40 74 03 8b 53 0c ff 42 04 89 f8 e8 10 33 1c 
EIP: [<c043f7a0>] find_get_page+0x23/0x3f SS:ESP 0068:dfb3ce28
 <3>BUG: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():0, irqs_disabled():1
 <c0426d91> blocking_notifier_call_chain+0x18/0x49  <c041e800> do_exit+0x19/0x768
 <c0529103> do_unblank_screen+0x2a/0x127  <c04042c0> die+0x27b/0x2a0
 <c0603b4e> do_page_fault+0x443/0x5ad  <c060370b> do_page_fault+0x0/0x5ad
 <c04037df> error_code+0x4f/0x54  <c043f7a0> find_get_page+0x23/0x3f
 <c043fe49> do_generic_mapping_read+0x13a/0x465  <c044098d> __generic_file_aio_read+0x167/0x1ac
 <c043f625> file_read_actor+0x0/0xe0  <c0441963> generic_file_read+0x0/0xb9
 <c0441a06> generic_file_read+0xa3/0xb9  <c042c17c> autoremove_wake_function+0x0/0x35
 <c0602aed> _spin_unlock_irq+0x5/0x7  <c042458f> do_sigaction+0x147/0x158
 <c045c671> vfs_read+0xa6/0x14e  <c045c9f0> sys_read+0x41/0x67
 <c0402cb3> syscall_call+0x7/0xb 

--Boundary-00=_XhzAFO5BLWXk/kI--
