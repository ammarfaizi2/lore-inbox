Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263724AbUDGQDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 12:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbUDGQDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 12:03:23 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:21128 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S263724AbUDGQDF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 12:03:05 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: 2.6.5-mc2
Date: 07 Apr 2004 18:06:26 +0200
Organization: SuSE Labs, Berlin
Message-ID: <87wu4rdb7h.fsf@bytesex.org>
References: <20040406221744.2bd7c7e4.akpm@osdl.org>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1081353986 20708 127.0.0.1 (7 Apr 2004 16:06:26 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc2/
> 
> This tree is the accumulation of things which will be sent to Linus next
> week.

Doesn't boot my machine.

  Gerd

Bootdata ok (command line is BOOT_IMAGE=2.6.5-mc2 root=303 console=ttyS0,115200n8 console=tty0 ramdisk_size=16384 root=/dev/ram0 init=/linuxrc rw)
Linux version 2.6.5-mc2 (kraxel@eskarina) (gcc version 3.3.3 (SuSE Linux)) #1 SMP Wed Apr 7 15:06:26 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
No mptable found.
No mptable found.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 AMD-K8                                    ) @ 0x00000000000f7680
ACPI: RSDT (v001 AMD-K8 AWRDACPI 0x42302e31 AMD  0x00000001) @ 0x000000001fff3000
ACPI: FADT (v001 AMD-K8 AWRDACPI 0x42302e31 AMD  0x00000001) @ 0x000000001fff3040
ACPI: SSDT (v001 AMD-K8 000Dummy 0x42302e31 AMD  0x00000001) @ 0x000000001fff7440
ACPI: SSDT (v001 AMD-K8 100Dummy 0x42302e31 AMD  0x00000001) @ 0x000000001fff7500
ACPI: MADT (v001 AMD-K8 AWRDACPI 0x42302e31 AMD  0x00000001) @ 0x000000001fff7480
ACPI: DSDT (v001 AMD-K8 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x0000000000000000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ 40000000 size 1024 MB
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.5-mc2 root=303 console=ttyS0,115200n8 console=tty0 ramdisk_size=16384 root=/dev/ram0 init=/linuxrc rw
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1595.476 MHz processor.
Console: colour dummy device 80x25
Memory: 511876k/524224k available (1861k kernel code, 11604k reserved, 853k data, 164k init)
Calibrating delay loop... 3137.53 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
POSIX conformance testing by UNIFIX
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Athlon(tm) 64 Processor 2800+ stepping 00
per-CPU timeslice cutoff: 1024.25 usecs.
task migration cache decay timeout: 2 msecs.
Only one processor found.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
Detected 12.464 MHz APIC timer.
time.c: Using PIT/TSC based timekeeping.
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
    ACPI-0100: *** Warning: Zero-length AML block in table [SSDT]
    ACPI-0100: *** Warning: Zero-length AML block in table [SSDT]
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: Power Resource [FN10] (on)
testing the IO APIC.......................

.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
agpgart: Detected AMD 8151 AGP Bridge rev B0
agpgart: Correcting AGP revision (reports 3.5, is really 3.0)
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 1024M @ 0x40000000
PCI-DMA: Disabling IOMMU.
vesafb: framebuffer at 0xa0000000, mapped to 0xffffff0000212000, size 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=41
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
ikconfig 0.7 with /proc/config*
Initializing Cryptographic API
Console: switching to colour frame buffer device 128x48
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
tg3.c:v2.9 (March 8, 2004)
eth0: Tigon3 [partno(3C996B-T) rev 0105 PHY(5701)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:04:76:f1:0a:7c
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L080AVVA07-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
ACPI: (supports S0 S1 S3 S4 S5)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (romfs filesystem) readonly.
Freeing unused kernel memory: 164k freed
input: PC Speaker
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
Adding 2104504k swap on /dev/hda2.  Priority:42 extents:1
EXT3 FS on hda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
intel8x0_measure_ac97_clock: measured 49142 usecs
intel8x0: clocking to 48000
blk: queue 000001001fade728, I/O limit 4095Mb (mask 0xffffffff)
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Bridge firewalling registered
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff80371c40(lo)
IPv6 over IPv4 tunneling driver
device hw0 entered promiscuous mode
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
device uml0 entered promiscuous mode
tg3: hw0: Link is up at 100 Mbps, full duplex.
tg3: hw0: Flow control is on for TX and on for RX.
SCSI subsystem initialized
st: Version 20040318, fixed bufsize 32768, s/g segs 256
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci_hcd 0000:02:00.0: Advanced Micro Devices [AMD] AMD-8111 USB
ohci_hcd 0000:02:00.0: irq 19, pci mem ffffff0001330000
ohci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:02:00.1: Advanced Micro Devices [AMD] AMD-8111 USB (#2)
ohci_hcd 0000:02:00.1: irq 19, pci mem ffffff0001332000
ohci_hcd 0000:02:00.1: new USB bus registered, assigned bus number 2
general protection fault: 0000 [1] PREEMPT SMP 
CPU 0 
Pid: 1669, comm: sleep Not tainted 2.6.5-mc2
RIP: 0010:[<ffffffff8010f106>] <ffffffff8010f106>{__switch_to+86}
RSP: 0018:000001001cd6fe90  EFLAGS: 00010002
RAX: 000001001cd28000 RBX: 000001001ceddac0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000001001cedd630 RDI: 000001001cd70e78
RBP: 000001001cd71308 R08: 0000000000000000 R09: 0000000000000007
R10: 00000000ffffffff R11: dead4ead00000001 R12: 000001001d166628
R13: 000001001cedd630 R14: 000001001cd70e78 R15: ffffffff803d9a40
FS:  0000002a95c02880(0000) GS:ffffffff803ddbc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000002a9595ae30 CR3: 0000000000101000 CR4: 00000000000006e0
Process sleep (pid: 1669, stackpage=1001cd71e78)
Stack: ffffffff8014e472 0000000000000000 000001001cedd630 000001001d166628 
       000001000170b420 000001001cedd630 0000000947c6ee09 ffffffff802cd630 
       000001001cd6ff70 0000000000000002 
Call Trace:<ffffffff8014e472>{attach_pid+34} <ffffffff802cd630>{thread_return+0} 
       <ffffffff8010efe9>{sys_clone+41} <ffffffff80110828>{sysret_careful+13} 
       

Code: 0f ae 87 10 05 00 00 db e2 83 60 14 fe 0f 20 c0 48 83 c8 08 
RIP <ffffffff8010f106>{__switch_to+86} RSP <000001001cd6fe90>
 <6>note: sleep[1669] exited with preempt_count 2
bad: scheduling while atomic!

Call Trace:<ffffffff802ccf5e>{schedule+94} <ffffffff80176785>{page_remove_rmap+389} 
      NMI Watchdog detected LOCKUP on CPU0, registers:
CPU 0 
Pid: 1669, comm: sleep Not tainted 2.6.5-mc2
RIP: 0010:[<ffffffff802ce408>] <ffffffff802ce408>{.text.lock.sched+26}
RSP: 0018:ffffffff803e1a78  EFLAGS: 00000086
RAX: 000001001cd29fd8 RBX: 000001000170b420 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 000001000170b420
RBP: ffffffff803e1a98 R08: 000001000170b420 R09: 0000000000000002
R10: 00000000ffffffff R11: 0000000000000103 R12: 0000000000000000
R13: 000001000170b420 R14: ffffffff803e1ab8 R15: 0000000000000000
FS:  0000002a95c02880(0000) GS:ffffffff803ddbc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000002a9595ae30 CR3: 0000000000101000 CR4: 00000000000006e0
Process sleep (pid: 1669, stackpage=1001cd71e78)
Stack: 000001001deea240 0000000024000001 ffffffff8040b4c0 000001001fe610f0 
       ffffffff803e1ae8 ffffffff801338bb 0000000000000003 0000000000000011 
       0000000000000092 0000000000000000 
Call Trace:<IRQ> <ffffffff801338bb>{try_to_wake_up+107} <ffffffff80132970>{__wake_up_common+64} 
       <ffffffff80135724>{__wake_up+116} <ffffffff802542d0>{cursor_timer_handler+0} 
       <ffffffff8014d9c9>{__queue_work+137} <ffffffff8014daa5>{queue_work+85} 
       <ffffffff802542e0>{cursor_timer_handler+16} <ffffffff80143426>{run_timer_softirq+486} 
       <ffffffff801182be>{timer_interrupt+1422} <ffffffff8011443f>{handle_IRQ_event+47} 
       <ffffffff8013f553>{__do_softirq+83} <ffffffff8013f5e5>{do_softirq+53} 
       <ffffffff8011e603>{smp_apic_timer_interrupt+115} <ffffffff80111033>{apic_timer_interrupt+99} 
        <EOI> <ffffffff80139eec>{__call_console_drivers+76} 
       <ffffffff801d5379>{__delay+9} <ffffffff8021dea2>{serial8250_console_write+146} 
       <ffffffff80139eec>{__call_console_drivers+76} <ffffffff8013a62a>{release_console_sem+490} 
       <ffffffff8013a3c5>{printk+725} <ffffffff8011204c>{printk_address+140} 
       <ffffffff80176785>{page_remove_rmap+389} <ffffffff8011222f>{show_trace+463} 
       <ffffffff8011225c>{dump_stack+12} <ffffffff802ccf5e>{schedule+94} 
       <ffffffff80176785>{page_remove_rmap+389} <ffffffff8016ecbf>{unmap_page_range+687} 
       <ffffffff8016efcf>{unmap_vmas+527} <ffffffff80172b0e>{exit_mmap+318} 
       <ffffffff801375f5>{mmput+181} <ffffffff8013d38c>{do_exit+636} 
       <ffffffff80111e2c>{oops_end+124} <ffffffff80112795>{die+69} 
       <ffffffff801128a7>{do_general_protection+263} <ffffffff80111185>{error_exit+0} 
       <ffffffff8010f106>{__switch_to+86} <ffffffff8014e472>{attach_pid+34} 
       <ffffffff802cd630>{thread_return+0} <ffffffff8010efe9>{sys_clone+41} 
       <ffffffff80110828>{sysret_careful+13} 

Code: 80 3b 00 7e f9 e9 bb f5 ff ff f3 90 80 3b 00 7e f9 e9 c3 f6 
console shuts up ...
  
