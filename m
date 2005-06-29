Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVF2Egp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVF2Egp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 00:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVF2Egp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 00:36:45 -0400
Received: from iron.pdx.net ([207.149.241.18]:28366 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S262272AbVF2EfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 00:35:15 -0400
Subject: Re: ASUS K8N-DL Beta BIOS AKA PROBLEM: Devices behind PCI
	Express-to-PCI bridge not mapped
From: Sean Bruno <sean.bruno@dsl-only.net>
To: linux-kernel@vger.kernel.org
Cc: kevin.mullins@asusts.com, JASON_RILEY@asusts.com, karim@opersys.com,
       Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Peter Buckingham <peter@pantasys.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dave.jones@redhat.com
In-Reply-To: <1120018942.6936.20.camel@home-lap>
References: <1119996349.3484.40.camel@oscar.metro1.com>
	 <42C1FD7F.2060003@opersys.com>  <1120018942.6936.20.camel@home-lap>
Content-Type: multipart/mixed; boundary="=-IDJ8VQYL4ePzjTBTw1Sy"
Date: Tue, 28 Jun 2005 21:35:10 -0700
Message-Id: <1120019710.6936.24.camel@home-lap>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IDJ8VQYL4ePzjTBTw1Sy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Whoops, I guess you all got a copy of my Laptop's "lshw"....

Why don't I try to attach the correct copy this time...

Sean

--=-IDJ8VQYL4ePzjTBTw1Sy
Content-Disposition: attachment; filename=lshw.out
Content-Type: text/plain; name=lshw.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

home-desk
    description: Tower Computer
    product: System Product Name
    vendor: System manufacturer
    version: System Version
    serial: System Serial Number
    width: 32 bits
    capabilities: smbios-2.3 dmi-2.3
    configuration: boot=normal chassis=tower uuid=50ECB49C-06A4-D911-B7D5-E9686682C17E
  *-core
       description: Motherboard
       product: K8N-DL
       vendor: ASUSTek Computer INC.
       physical id: 0
       version: 1.XX
       serial: 123456789000
     *-firmware
          description: BIOS
          vendor: Phoenix Technologies, LTD
          physical id: 0
          version: ASUS K8N-DL ACPI BIOS Revision 1004.007 (06/28/2005)
          size: 128KB
          capacity: 448KB
          capabilities: pci pnp apm upgrade shadowing cdboot bootselect socketedrom edd int13floppy360 int13floppy1200 int13floppy720 int13floppy2880 int5printscreen int9keyboard int14serial int17printer int10video acpi usb ls120boot zipboot biosbootspecification
     *-cpu:0
          description: CPU
          product: AMD Opteron(tm) Processor 246
          vendor: Advanced Micro Devices [AMD]
          physical id: 3
          bus info: cpu@0
          version: AMD Opteron(tm) Processor 246
          slot: Socket 940
          size: 1GHz
          capacity: 3700MHz
          width: 64 bits
          clock: 200MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext x86-64 3dnowext 3dnow cpufreq
        *-cache:0
             description: L1 cache
             physical id: d
             slot: L1 Cache
             size: 128KB
             capacity: 128KB
             capabilities: synchronous internal write-back data
        *-cache:1
             description: L2 cache
             physical id: f
             slot: L2 Cache
             size: 1MB
             capacity: 1MB
             capabilities: synchronous internal write-back unified
     *-cpu:1
          description: CPU
          product: AMD Opteron(tm) Processor 246
          vendor: Advanced Micro Devices [AMD]
          physical id: 5
          bus info: cpu@1
          version: AMD Opteron(tm) Processor 246
          slot: Socket 940
          size: 1GHz
          capacity: 3700MHz
          width: 64 bits
          clock: 200MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext x86-64 3dnowext 3dnow cpufreq
        *-cache:0
             description: L1 cache
             physical id: e
             slot: L1 Cache
             size: 128KB
             capacity: 128KB
             capabilities: synchronous internal write-back data
        *-cache:1
             description: L2 cache
             physical id: 10
             slot: L2 Cache
             size: 1MB
             capacity: 1MB
             capabilities: synchronous internal write-back unified
     *-memory:0
          description: System Memory
          physical id: 28
          slot: System board or motherboard
          size: 6GB
        *-bank:0
             description: DIMM
             product: None
             vendor: None
             physical id: 0
             serial: None
             slot: A0
             size: 1GB
             width: 64 bits
        *-bank:1
             description: DIMM
             product: None
             vendor: None
             physical id: 1
             serial: None
             slot: A1
             size: 1GB
             width: 64 bits
        *-bank:2
             description: DIMM
             product: None
             vendor: None
             physical id: 2
             serial: None
             slot: A2
             size: 1GB
             width: 64 bits
        *-bank:3
             description: DIMM
             product: None
             vendor: None
             physical id: 3
             serial: None
             slot: A3
             size: 1GB
             width: 64 bits
        *-bank:4
             description: DIMM
             product: None
             vendor: None
             physical id: 4
             serial: None
             slot: A4
             size: 1GB
             width: 64 bits
        *-bank:5
             description: DIMM
             product: None
             vendor: None
             physical id: 5
             serial: None
             slot: A5
             size: 1GB
             width: 64 bits
     *-memory:1 UNCLAIMED
          description: Memory controller
          product: CK804 Memory Controller
          vendor: nVidia Corporation
          physical id: 4
          bus info: pci@00:00.0
          version: a3
          width: 32 bits
          clock: 66MHz (15.1515ns)
          capabilities: bus_master cap_list
     *-isa UNCLAIMED
          description: ISA bridge
          product: CK804 ISA Bridge
          vendor: nVidia Corporation
          physical id: 1
          bus info: pci@00:01.0
          version: a3
          width: 32 bits
          clock: 66MHz
          capabilities: isa bus_master
     *-serial
          description: SMBus
          product: CK804 SMBus
          vendor: nVidia Corporation
          physical id: 1.1
          bus info: pci@00:01.1
          version: a2
          width: 32 bits
          clock: 66MHz
          capabilities: cap_list
          configuration: driver=nForce2_smbus
          resources: ioport:ff00-ff1f ioport:4c00-4c3f ioport:4c40-4c7f irq:3
     *-usb:0
          description: USB Controller
          product: CK804 USB Controller
          vendor: nVidia Corporation
          physical id: 2
          bus info: pci@00:02.0
          version: a2
          width: 32 bits
          clock: 66MHz
          capabilities: ohci bus_master cap_list
          configuration: driver=ohci_hcd
          resources: iomemory:feaff000-feafffff irq:5
        *-usbhost
             product: OHCI Host Controller
             vendor: Linux 2.6.12-git10 ohci_hcd
             physical id: 1
             bus info: usb@2
             logical name: usb2
             version: 2.06
             capabilities: usb-1.10
             configuration: driver=hub maxpower=0mA slots=10 speed=12.0MB/s
     *-usb:1
          description: USB Controller
          product: CK804 USB Controller
          vendor: nVidia Corporation
          physical id: 2.1
          bus info: pci@00:02.1
          version: a3
          width: 32 bits
          clock: 66MHz
          capabilities: ehci bus_master cap_list
          configuration: driver=ehci_hcd
          resources: iomemory:feb00000-feb000ff irq:11
        *-usbhost
             product: EHCI Host Controller
             vendor: Linux 2.6.12-git10 ehci_hcd
             physical id: 1
             bus info: usb@1
             logical name: usb1
             version: 2.06
             capabilities: usb-2.00
             configuration: driver=hub maxpower=0mA slots=10 speed=480.0MB/s
     *-multimedia
          description: Multimedia audio controller
          product: CK804 AC'97 Audio Controller
          vendor: nVidia Corporation
          physical id: a
          bus info: pci@00:04.0
          version: a2
          width: 32 bits
          clock: 66MHz
          capabilities: bus_master cap_list
          configuration: driver=Intel ICH
          resources: ioport:fc00-fcff ioport:fb00-fbff iomemory:feafd000-feafdfff irq:3
     *-ide:0
          description: IDE interface
          product: CK804 IDE
          vendor: nVidia Corporation
          physical id: 6
          bus info: pci@00:06.0
          version: f2
          width: 32 bits
          clock: 66MHz
          capabilities: ide bus_master cap_list
          configuration: driver=AMD_IDE
          resources: ioport:fa00-fa0f
        *-ide
             description: IDE Channel 1
             physical id: 1
             bus info: ide@1
             logical name: ide1
             clock: 66MHz
           *-cdrom:0
                description: DVD reader
                product: Pioneer DVD-ROM ATAPIModel DVD-105S 013
                vendor: Pioneer
                physical id: 0
                bus info: ide@1.0
                logical name: /dev/hdc
                version: E1.33
                capabilities: packet atapi cdrom removable nonmagnetic dma lba iordy pm audio dvd
                configuration: mode=udma2
           *-cdrom:1
                description: CD-R/CD-RW writer
                product: Polaroid BurnMAX48
                physical id: 1
                bus info: ide@1.1
                logical name: /dev/hdd
                version: VER 482E
                capabilities: packet atapi cdrom removable nonmagnetic dma lba iordy audio cd-r cd-rw
                configuration: mode=udma2
     *-ide:1
          description: IDE interface
          product: CK804 Serial ATA Controller
          vendor: nVidia Corporation
          physical id: 7
          bus info: pci@00:07.0
          version: f3
          width: 32 bits
          clock: 66MHz
          capabilities: ide bus_master cap_list
          configuration: driver=sata_nv
          resources: ioport:9f0-9f7 ioport:bf0-bf3 ioport:970-977 ioport:b70-b73 ioport:f500-f50f iomemory:feafc000-feafcfff irq:5
     *-ide:2
          description: IDE interface
          product: CK804 Serial ATA Controller
          vendor: nVidia Corporation
          physical id: 8
          bus info: pci@00:08.0
          version: f3
          width: 32 bits
          clock: 66MHz
          capabilities: ide bus_master cap_list
          configuration: driver=sata_nv
          resources: ioport:9e0-9e7 ioport:be0-be3 ioport:960-967 ioport:b60-b63 ioport:f000-f00f iomemory:feafb000-feafbfff irq:11
     *-pci:0
          description: PCI bridge
          product: CK804 PCI Bridge
          vendor: nVidia Corporation
          physical id: 9
          bus info: pci@00:09.0
          version: a2
          width: 32 bits
          clock: 66MHz
          capabilities: pci subtractive_decode bus_master
        *-network
             description: Ethernet interface
             product: 82557/8/9 [Ethernet Pro 100]
             vendor: Intel Corporation
             physical id: 6
             bus info: pci@01:06.0
             logical name: eth1
             version: 08
             serial: 00:03:47:96:ed:4e
             size: 100MB/s
             capacity: 100MB/s
             width: 32 bits
             clock: 33MHz
             capabilities: bus_master cap_list ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd autonegociation
             configuration: autonegociation=on broadcast=yes driver=e100 driverversion=3.4.8-k2-NAPI duplex=full firmware=N/A ip=192.168.0.102 link=yes multicast=yes port=MII speed=100MB/s
             resources: iomemory:fe8ff000-fe8fffff ioport:df00-df3f iomemory:fe700000-fe7fffff irq:225
        *-firewire
             description: FireWire (IEEE 1394)
             product: TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
             vendor: Texas Instruments
             physical id: 8
             bus info: pci@01:08.0
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: ohci bus_master cap_list
             configuration: driver=ohci1394
             resources: iomemory:fe8fe000-fe8fe7ff iomemory:fe8f8000-fe8fbfff irq:50
        *-storage
             description: RAID bus controller
             product: SiI 3114 [SATALink/SATARaid] Serial ATA Controller
             vendor: Silicon Image, Inc.
             physical id: 9
             bus info: pci@01:09.0
             logical name: scsi0
             logical name: scsi1
             version: 02
             width: 32 bits
             clock: 66MHz
             capabilities: storage bus_master cap_list emulated
             configuration: driver=sata_sil
             resources: ioport:de00-de07 ioport:dd00-dd03 ioport:dc00-dc07 ioport:db00-db03 ioport:da00-da0f iomemory:fe8fd000-fe8fd3ff irq:201
           *-disk:0
                description: SCSI Disk
                product: SAMSUNG SP1614C
                vendor: ATA
                physical id: 0
                bus info: scsi@0:0.0.0
                logical name: /dev/sda
                version: SW10
                size: 149GB
                configuration: ansiversion=5
           *-disk:1
                description: SCSI Disk
                product: SAMSUNG SP1614C
                vendor: ATA
                physical id: 1
                bus info: scsi@1:0.0.0
                logical name: /dev/sdb
                version: SW10
                size: 149GB
                configuration: ansiversion=5
     *-pci:1
          description: PCI bridge
          product: CK804 PCIE Bridge
          vendor: nVidia Corporation
          physical id: c
          bus info: pci@00:0c.0
          version: a3
          width: 32 bits
          clock: 33MHz
          capabilities: pci normal_decode bus_master cap_list
          configuration: driver=pcieport-driver
        *-network DISABLED
             description: Ethernet interface
             product: NetXtreme BCM5751 Gigabit Ethernet PCI Express
             vendor: Broadcom Corporation
             physical id: 0
             bus info: pci@02:00.0
             logical name: eth0
             version: 11
             serial: 00:11:d8:d3:08:05
             capacity: 1GB/s
             width: 64 bits
             clock: 33MHz
             capabilities: bus_master cap_list ethernet physical mii 10bt 10bt-fd 100bt 100bt-fd 1000bt 1000bt-fd autonegociation
             configuration: autonegociation=on broadcast=yes driver=tg3 driverversion=3.32 duplex=half link=no multicast=yes port=twisted pair
             resources: iomemory:fe5f0000-fe5fffff irq:5
     *-pci:2
          description: PCI bridge
          product: CK804 PCIE Bridge
          vendor: nVidia Corporation
          physical id: d
          bus info: pci@00:0d.0
          version: a3
          width: 32 bits
          clock: 33MHz
          capabilities: pci normal_decode bus_master cap_list
          configuration: driver=pcieport-driver
     *-pci:3
          description: PCI bridge
          product: CK804 PCIE Bridge
          vendor: nVidia Corporation
          physical id: e
          bus info: pci@00:0e.0
          version: a3
          width: 32 bits
          clock: 33MHz
          capabilities: pci normal_decode bus_master cap_list
          configuration: driver=pcieport-driver
        *-display
             description: VGA compatible controller
             product: NV44 [GeForce 6200 TurboCache]
             vendor: nVidia Corporation
             physical id: 0
             bus info: pci@04:00.0
             version: a1
             size: 256MB
             width: 64 bits
             clock: 33MHz
             capabilities: vga bus_master cap_list
             resources: iomemory:fb000000-fbffffff iomemory:d0000000-dfffffff iomemory:fc000000-fcffffff irq:11
     *-pci:4
          description: Host bridge
          product: K8 [Athlon64/Opteron] HyperTransport Technology Configuration
          vendor: Advanced Micro Devices [AMD]
          physical id: 100
          bus info: pci@00:18.0
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:5
          description: Host bridge
          product: K8 [Athlon64/Opteron] Address Map
          vendor: Advanced Micro Devices [AMD]
          physical id: 101
          bus info: pci@00:18.1
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:6
          description: Host bridge
          product: K8 [Athlon64/Opteron] DRAM Controller
          vendor: Advanced Micro Devices [AMD]
          physical id: 102
          bus info: pci@00:18.2
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:7
          description: Host bridge
          product: K8 [Athlon64/Opteron] Miscellaneous Control
          vendor: Advanced Micro Devices [AMD]
          physical id: 103
          bus info: pci@00:18.3
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:8
          description: Host bridge
          product: K8 [Athlon64/Opteron] HyperTransport Technology Configuration
          vendor: Advanced Micro Devices [AMD]
          physical id: 104
          bus info: pci@00:19.0
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:9
          description: Host bridge
          product: K8 [Athlon64/Opteron] Address Map
          vendor: Advanced Micro Devices [AMD]
          physical id: 105
          bus info: pci@00:19.1
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:10
          description: Host bridge
          product: K8 [Athlon64/Opteron] DRAM Controller
          vendor: Advanced Micro Devices [AMD]
          physical id: 106
          bus info: pci@00:19.2
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:11
          description: Host bridge
          product: K8 [Athlon64/Opteron] Miscellaneous Control
          vendor: Advanced Micro Devices [AMD]
          physical id: 107
          bus info: pci@00:19.3
          version: 00
          width: 32 bits
          clock: 33MHz

--=-IDJ8VQYL4ePzjTBTw1Sy--

