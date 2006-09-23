Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWIWQpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWIWQpB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 12:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWIWQpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 12:45:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55036 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751291AbWIWQo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 12:44:59 -0400
Date: Sat, 23 Sep 2006 12:44:58 -0400
From: Vincent Gentilcore <vincent.gentilcore@videotron.ca>
Subject: dmesg
To: linux-kernel@vger.kernel.org
Message-id: <4515648A.5080807@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_1pgWKmiJmJxtuPFZMPK6Eg)"
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_1pgWKmiJmJxtuPFZMPK6Eg)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

dmesg

Vincent Gentilcore

--Boundary_(ID_1pgWKmiJmJxtuPFZMPK6Eg)
Content-type: text/plain; CHARSET=US-ASCII; name=dmesg
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=dmesg

[    0.000000] Linux version 2.6.18.230906 (root@vinnyduke-desktop) (gcc version 4.1.2 20060920 (prerelease) (Ubuntu 4.1.1-13ubuntu3)) #2 SMP Sat Sep 23 10:15:55 EDT 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ff40000 (usable)
[    0.000000]  BIOS-e820: 000000003ff40000 - 000000003ff50000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003ff50000 - 0000000040000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff380000 - 0000000100000000 (reserved)
[    0.000000] 127MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] On node 0 totalpages: 261952
[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
[    0.000000]   Normal zone: 225280 pages, LIFO batch:31
[    0.000000]   HighMem zone: 32576 pages, LIFO batch:7
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP (v000 ACPIAM                                ) @ 0x000fa580
[    0.000000] ACPI: RSDT (v001 A M I  OEMRSDT  0x07000612 MSFT 0x00000097) @ 0x3ff40000
[    0.000000] ACPI: FADT (v002 A M I  OEMFACP  0x07000612 MSFT 0x00000097) @ 0x3ff40200
[    0.000000] ACPI: MADT (v001 A M I  OEMAPIC  0x07000612 MSFT 0x00000097) @ 0x3ff40300
[    0.000000] ACPI: OEMB (v001 A M I  OEMBIOS  0x07000612 MSFT 0x00000097) @ 0x3ff50040
[    0.000000] ACPI: DSDT (v001  75i6G 75i6G242 0x00000242 INTL 0x02002026) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:6 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:6 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:bed00000)
[    0.000000] Detected 2999.918 MHz processor.
[   17.449606] Built 1 zonelists.  Total pages: 261952
[   17.449610] Kernel command line: root=/dev/hda1 ro quiet locale=fr
[   17.449785] mapped APIC to ffffd000 (fee00000)
[   17.449787] mapped IOAPIC to ffffc000 (fec00000)
[   17.449790] Enabling fast FPU save and restore... done.
[   17.449793] Enabling unmasked SIMD FPU exception support... done.
[   17.449796] Initializing CPU#0
[   17.449858] PID hash table entries: 4096 (order: 12, 16384 bytes)
[   17.453990] Console: colour VGA+ 80x25
[   17.454320] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   17.454655] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   17.474644] Memory: 1027260k/1047808k available (2141k kernel code, 19856k reserved, 1358k data, 308k init, 130304k highmem)
[   17.474648] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   17.533758] Calibrating delay using timer specific routine.. 6001.60 BogoMIPS (lpj=3000803)
[   17.533792] Security Framework v1.0.0 initialized
[   17.533796] SELinux:  Disabled at boot.
[   17.533810] Mount-cache hash table entries: 512
[   17.533921] CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000e43d 00000000 00000001
[   17.533931] CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 0000e43d 00000000 00000001
[   17.533937] monitor/mwait feature present.
[   17.533939] using mwait in idle threads.
[   17.533946] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   17.533948] CPU: L2 cache: 2048K
[   17.533951] CPU: Physical Processor ID: 0
[   17.533952] CPU: Processor Core ID: 0
[   17.533954] CPU: After all inits, caps: bfebfbff 20000000 00000000 00000180 0000e43d 00000000 00000001
[   17.533963] Compat vDSO mapped to ffffe000.
[   17.533976] Checking 'hlt' instruction... OK.
[   17.537824] SMP alternatives: switching to UP code
[   17.537944] ACPI: Core revision 20060707
[   17.540082] CPU0: Intel(R) Pentium(R) D CPU 3.00GHz stepping 02
[   17.540090] SMP alternatives: switching to SMP code
[   17.540118] Booting processor 1/1 eip 3000
[   18.267557] Initializing CPU#1
[   18.327549] Calibrating delay using timer specific routine.. 5998.54 BogoMIPS (lpj=2999271)
[   18.327558] CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000e43d 00000000 00000001
[   18.327565] CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 0000e43d 00000000 00000001
[   18.327570] monitor/mwait feature present.
[   18.327576] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   18.327578] CPU: L2 cache: 2048K
[   18.327580] CPU: Physical Processor ID: 0
[   18.327582] CPU: Processor Core ID: 1
[   18.327583] CPU: After all inits, caps: bfebfbff 20000000 00000000 00000180 0000e43d 00000000 00000001
[   17.611122] CPU1: Intel(R) Pentium(R) D CPU 3.00GHz stepping 02
[   17.611155] Total of 2 processors activated (12000.14 BogoMIPS).
[   17.611280] ENABLING IO-APIC IRQs
[   17.611435] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   17.722534] checking TSC synchronization across 2 CPUs: 
[    0.000002] CPU#0 had -358913 usecs TSC skew, fixed it up.
[    0.000005] CPU#1 had 358913 usecs TSC skew, fixed it up.
[    0.000997] Brought up 2 CPUs
[    0.131938] migration_cost=1163
[    0.132069] checking if image is initramfs... it is
[    0.669101] Freeing initrd memory: 6531k freed
[    0.669426] NET: Registered protocol family 16
[    0.669511] EISA bus registered
[    0.669516] ACPI: bus type pci registered
[    0.669595] PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
[    0.669601] PCI: Using configuration type 1
[    0.669603] Setting up standard PCI resources
[    0.682539] ACPI: Interpreter enabled
[    0.682542] ACPI: Using IOAPIC for interrupt routing
[    0.682998] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.683003] PCI: Probing PCI hardware (bus 00)
[    0.686115] PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
[    0.686119] PCI quirk: region 0480-04bf claimed by ICH4 GPIO
[    0.686174] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[    0.686413] Boot video device is 0000:01:00.0
[    0.686588] PCI: Transparent bridge - 0000:00:1e.0
[    0.686614] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.688505] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
[    0.693094] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    0.693341] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[    0.693577] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    0.693815] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
[    0.694050] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.694295] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.694531] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 *4 5 6 7 10 11 12 14 15)
[    0.694768] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    0.694908] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.694918] pnp: PnP ACPI init
[    0.698108] pnp: PnP ACPI: found 11 devices
[    0.698116] PnPBIOS: Disabled by ACPI PNP
[    0.698193] usbcore: registered new driver usbfs
[    0.698229] usbcore: registered new driver hub
[    0.698303] PCI: Using ACPI for IRQ routing
[    0.698306] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.702914] pnp: 00:09: ioport range 0x290-0x29f has been reserved
[    0.703193] PCI: Bridge: 0000:00:01.0
[    0.703195]   IO window: disabled.
[    0.703200]   MEM window: fa900000-fe9fffff
[    0.703204]   PREFETCH window: bff00000-dfefffff
[    0.703208] PCI: Bridge: 0000:00:1e.0
[    0.703211]   IO window: b000-bfff
[    0.703217]   MEM window: fea00000-feafffff
[    0.703220]   PREFETCH window: disabled.
[    0.703236] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    0.703264] NET: Registered protocol family 2
[    0.714175] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.714313] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.714938] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.715257] TCP: Hash tables configured (established 131072 bind 65536)
[    0.715260] TCP reno registered
[    0.716526] audit: initializing netlink socket (disabled)
[    0.716540] audit(1159014889.184:1): initialized
[    0.716649] highmem bounce pool size: 64 pages
[    0.716740] VFS: Disk quotas dquot_6.5.1
[    0.716761] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.716831] Initializing Cryptographic API
[    0.716835] io scheduler noop registered
[    0.716846] io scheduler anticipatory registered
[    0.716853] io scheduler deadline registered
[    0.716870] io scheduler cfq registered (default)
[    0.717055] isapnp: Scanning for PnP cards...
[    1.071122] isapnp: No Plug & Play device found
[    1.095531] Real Time Clock Driver v1.12ac
[    1.095581] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    1.096727] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[    1.096860] 8139too Fast Ethernet driver 0.9.27
[    1.096880] ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 169
[    1.097172] eth0: RealTek RTL8139 at 0xf8804c00, 00:13:8f:9d:c2:2f, IRQ 169
[    1.097175] eth0:  Identified 8139 chip type 'RTL-8101'
[    1.097182] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    1.097186] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    1.097209] ICH5: IDE controller at PCI slot 0000:00:1f.1
[    1.097215] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
[    1.097222] ICH5: chipset revision 2
[    1.097224] ICH5: not 100% native mode: will probe irqs later
[    1.097234]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
[    1.097247]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
[    1.097256] Probing IDE interface ide0...
[    1.360475] hda: Maxtor 6Y120L0, ATA DISK drive
[    1.971764] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    1.971815] Probing IDE interface ide1...
[    2.642913] hdc: HL-DT-ST DVDRAM GSA-4160B, ATAPI CD/DVD-ROM drive
[    3.356044] hdd: HL-DT-STDVD-ROM GDR8160B, ATAPI CD/DVD-ROM drive
[    3.419088] ide1 at 0x170-0x177,0x376 on irq 15
[    3.419383] hda: max request size: 512KiB
[    3.424818] hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
[    3.424966] hda: cache flushes supported
[    3.425004]  hda: hda1 hda2
[    3.434529] hdc: ATAPI 79X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
[    3.434537] Uniform CD-ROM driver Revision: 3.20
[    3.451760] hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
[    3.460455] usbmon: debugfs is not available
[    3.460513] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 185
[    3.460530] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[    3.460535] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    3.460589] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[    3.460623] ehci_hcd 0000:00:1d.7: debug port 1
[    3.460629] PCI: cache line size of 128 is not supported by device 0000:00:1d.7
[    3.460639] ehci_hcd 0000:00:1d.7: irq 185, io mem 0xfebffc00
[    3.464532] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    3.464650] usb usb1: configuration #1 chosen from 1 choice
[    3.464696] hub 1-0:1.0: USB hub found
[    3.464704] hub 1-0:1.0: 8 ports detected
[    3.565743] USB Universal Host Controller Interface driver v3.0
[    3.565799] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 193
[    3.565809] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[    3.565812] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    3.565849] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    3.565871] uhci_hcd 0000:00:1d.0: irq 193, io base 0x0000e000
[    3.565994] usb usb2: configuration #1 chosen from 1 choice
[    3.566033] hub 2-0:1.0: USB hub found
[    3.566041] hub 2-0:1.0: 2 ports detected
[    3.666619] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 201
[    3.666627] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[    3.666630] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    3.666667] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[    3.666691] uhci_hcd 0000:00:1d.1: irq 201, io base 0x0000e400
[    3.666809] usb usb3: configuration #1 chosen from 1 choice
[    3.666849] hub 3-0:1.0: USB hub found
[    3.666855] hub 3-0:1.0: 2 ports detected
[    3.767495] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 177
[    3.767503] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[    3.767507] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    3.767543] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[    3.767565] uhci_hcd 0000:00:1d.2: irq 177, io base 0x0000e800
[    3.767690] usb usb4: configuration #1 chosen from 1 choice
[    3.767730] hub 4-0:1.0: USB hub found
[    3.767737] hub 4-0:1.0: 2 ports detected
[    3.868369] ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 193
[    3.868376] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[    3.868380] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    3.868417] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[    3.868436] uhci_hcd 0000:00:1d.3: irq 193, io base 0x0000ec00
[    3.868558] usb usb5: configuration #1 chosen from 1 choice
[    3.868597] hub 5-0:1.0: USB hub found
[    3.868604] hub 5-0:1.0: 2 ports detected
[    4.081026] usb 3-1: new low speed USB device using uhci_hcd and address 2
[    4.244080] usb 3-1: configuration #1 chosen from 1 choice
[    4.452573] usb 3-2: new full speed USB device using uhci_hcd and address 3
[    4.604627] usb 3-2: configuration #1 chosen from 1 choice
[    4.607711] usbcore: registered new driver libusual
[    4.607789] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    4.607793] PNP: PS/2 controller doesn't have AUX irq; using default 12
[    4.609675] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.609887] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.610007] mice: PS/2 mouse device common for all mice
[    4.610495] EISA: Probing bus 0 at eisa.0
[    4.610537] EISA: Detected 0 cards.
[    4.610560] Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22 13:55:50 2006 UTC).
[    4.610640] ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 209
[    4.610664] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[    4.883549] input: AT Translated Set 2 keyboard as /class/input/input0
[    4.920004] intel8x0_measure_ac97_clock: measured 50993 usecs
[    4.920006] intel8x0: clocking to 48000
[    4.920278] ALSA device list:
[    4.920281]   #0: Intel ICH5 with CMI9761 at 0xfebff800, irq 209
[    4.920345] TCP bic registered
[    4.920353] NET: Registered protocol family 1
[    4.920360] NET: Registered protocol family 8
[    4.920362] NET: Registered protocol family 20
[    4.920396] Starting balanced_irq
[    4.920402] Using IPI No-Shortcut mode
[    4.920472] ACPI: (supports S0 S1 S3 S4 S5)
[    4.920698] Freeing unused kernel memory: 308k freed
[    4.920864] Time: tsc clocksource has been installed.
[    4.984997] ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU1._PDC] (Node c18e589c), AE_BAD_HEADER
[    4.985058] ACPI: Processor [CPU1] (supports 8 throttling states)
[    4.985123] ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU2._PDC] (Node c18e57fc), AE_BAD_HEADER
[    4.985154] ACPI: Processor [CPU2] (supports 8 throttling states)
[    4.985162] ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
[    4.985167] ACPI: Getting cpuindex for acpiid 0x3
[    4.985230] ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
[    4.985234] ACPI: Getting cpuindex for acpiid 0x4
[    5.292911] usbcore: registered new driver hiddev
[    5.313324] input: Logitech USB-PS/2 Optical Mouse as /class/input/input1
[    5.313451] input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
[    5.313465] usbcore: registered new driver usbhid
[    5.313469] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[    5.467733] SCSI subsystem initialized
[    5.472161] libata version 2.00 loaded.
[    5.474210] ata_piix 0000:00:1f.2: version 2.00
[    5.474215] ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
[    5.474232] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 177
[    5.474244] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[    5.474501] ata1: SATA max UDMA/133 cmd 0xD400 ctl 0xD002 bmdma 0xC400 irq 177
[    5.474533] ata2: SATA max UDMA/133 cmd 0xCC00 ctl 0xC802 bmdma 0xC408 irq 177
[    5.474541] scsi0 : ata_piix
[    5.625854] ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 
[    5.625858] ata1.00: ata1: dev 0 multi count 16
[    5.626626] ata1.00: configured for UDMA/133
[    5.626634] scsi1 : ata_piix
[    5.787151] ATA: abnormal status 0x7F on port 0xCC07
[    5.787244]   Vendor: ATA       Model: WDC WD2500KS-00M  Rev: 02.0
[    5.787259]   Type:   Direct-Access                      ANSI SCSI revision: 05
[    5.792555] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[    5.792569] sda: Write Protect is off
[    5.792572] sda: Mode Sense: 00 3a 00 00
[    5.792590] SCSI device sda: drive cache: write back
[    5.792639] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[    5.792650] sda: Write Protect is off
[    5.792653] sda: Mode Sense: 00 3a 00 00
[    5.792670] SCSI device sda: drive cache: write back
[    5.792672]  sda: sda1 sda2 sda3 < sda5 >
[    5.822730] sd 0:0:0:0: Attached scsi disk sda
[    6.066138] Attempting manual resume
[    6.079865] kjournald starting.  Commit interval 5 seconds
[    6.079875] EXT3-fs: mounted filesystem with ordered data mode.
[   13.303256] hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
[   13.303262] ide: failed opcode was: unknown
[   13.403770] hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
[   13.403774] ide: failed opcode was: unknown
[   13.499601] Floppy drive(s): fd0 is 1.44M
[   13.515306] FDC 0 is a post-1991 82077
[   13.517655] input: PC Speaker as /class/input/input2
[   13.540917] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   13.570894] Linux agpgart interface v0.101 (c) Dave Jones
[   13.576466] hda: CHECK for good STATUS
[   13.576493] hda: CHECK for good STATUS
[   13.591592] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   13.606916] agpgart: Detected an Intel 865 Chipset.
[   13.619975] agpgart: AGP aperture is 256M @ 0xe0000000
[   13.633518] hda: CHECK for good STATUS
[   13.740274] hdc: CHECK for good STATUS
[   13.740596] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   13.740603] hdc: drive_cmd: error=0x04 { AbortedCommand }
[   13.740605] ide: failed opcode was: 0xef
[   13.741517] hdc: CHECK for good STATUS
[   13.751393] 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
[   13.753696] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   13.753703] hdc: drive_cmd: error=0x04 { AbortedCommand }
[   13.753706] ide: failed opcode was: 0xef
[   13.766783] hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
[   13.766790] hdd: set_drive_speed_status: error=0x24 { AbortedCommand LastFailedSense=0x02 }
[   13.766795] ide: failed opcode was: unknown
[   13.819989] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   13.842515] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[   13.847136] hdc: CHECK for good STATUS
[   13.847460] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   13.847467] hdc: drive_cmd: error=0x04 { AbortedCommand }
[   13.847469] ide: failed opcode was: 0xef
[   13.919047] hdd: CHECK for good STATUS
[   13.926870] hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   13.926876] hdd: drive_cmd: error=0x04 { AbortedCommand }
[   13.926878] ide: failed opcode was: 0xef
[   13.933029] hdd: CHECK for good STATUS
[   13.933616] hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   13.933621] hdd: drive_cmd: error=0x04 { AbortedCommand }
[   13.933624] ide: failed opcode was: 0xef
[   14.015928] hdd: CHECK for good STATUS
[   14.027834] hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   14.027840] hdd: drive_cmd: error=0x04 { AbortedCommand }
[   14.027843] ide: failed opcode was: 0xef
[   14.064387] ts: Compaq touchscreen protocol output
[   14.092948] NET: Registered protocol family 10
[   14.093040] lo: Disabled Privacy Extensions
[   14.093165] IPv6 over IPv4 tunneling driver
[   14.216674] nvidia: module license 'NVIDIA' taints kernel.
[   14.219257] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 193
[   14.219432] NVRM: loading NVIDIA Linux x86 Kernel Module  1.0-8774  Tue Aug  1 20:54:08 PDT 2006
[   14.557270] lp: driver loaded but no devices found
[   14.568869] ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 209
[   14.682453] Adding 2546260k swap on /dev/disk/by-uuid/0fa29cb5-36a3-4637-8e6a-2567cf375865.  Priority:-1 extents:1 across:2546260k
[   14.742403] EXT3 FS on hda1, internal journal
[   14.989335] kjournald starting.  Commit interval 5 seconds
[   14.989628] EXT3 FS on sda2, internal journal
[   14.989633] EXT3-fs: mounted filesystem with ordered data mode.
[   14.997800] kjournald starting.  Commit interval 5 seconds
[   14.997994] EXT3 FS on hda2, internal journal
[   14.997998] EXT3-fs: mounted filesystem with ordered data mode.
[   15.027052] NTFS driver 2.1.27 [Flags: R/O MODULE].
[   15.046091] NTFS volume version 3.1.
[   16.272652] NET: Registered protocol family 17

--Boundary_(ID_1pgWKmiJmJxtuPFZMPK6Eg)--
