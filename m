Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUFQETh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUFQETh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 00:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266369AbUFQETh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 00:19:37 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:28620 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266366AbUFQEQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 00:16:34 -0400
Subject: Re: ld segfault at end of 2.6.6 compile
From: Geoff Mishkin <gmishkin@acs.bu.edu>
Reply-To: gmishkin@bu.edu
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-P51hGWPTrrwCYyGoc58x"
Message-Id: <1087445792.8675.50.camel@amsa>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 17 Jun 2004 00:16:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-P51hGWPTrrwCYyGoc58x
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've got some new information, this is the output of the ld command with
the -v option.  The original invocation is in my original post in this
topic.

--=-P51hGWPTrrwCYyGoc58x
Content-Disposition: attachment; filename=ld_output.txt
Content-Type: text/plain; name=ld_output.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

GNU ld version 2.14.90.0.8 20040114
  Supported emulations:
   elf_i386
   i386linux
   elf_i386_glibc21
opened script file arch/i386/kernel/vmlinux.lds.s
using external linker script:
==================================================
/* ld script to make i386 Linux kernel
 * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
 */





/* Kernel version magic *//* Kernel symbol table: Normal symbols *//* Kernel symbol table: GPL-only symbols *//* Kernel symbol table: Normal symbols *//* Kernel symbol table: GPL-only symbols *//* Kernel symbol table: strings */





/* thread_info.h: i386 low-level thread information
 *
 * Copyright (C) 2002  David Howells (dhowells@redhat.com)
 * - Incorporating suggestions made by Linus Torvalds and Dave Miller
 */









/*
 * Automatically generated C config: don't edit
 */






/*
 * Code maturity level options
 */





/*
 * General setup
 */




















/*
 * Loadable module support
 */







/*
 * Processor type and features
 */


























































/*
 * Firmware Drivers
 */










/*
 * Power management options (ACPI, APM)
 */





/*
 * ACPI (Advanced Configuration and Power Interface) Support
 */





















/*
 * APM (Advanced Power Management) BIOS Support
 */


/*
 * CPU Frequency scaling
 */










/*
 * CPUFreq processor drivers
 */













/*
 * Bus options (PCI, PCMCIA, EISA, MCA, ISA)
 */
















/*
 * PCMCIA/CardBus support
 */









/*
 * PCI Hotplug Support
 */


/*
 * Executable file formats
 */




/*
 * Device Drivers
 */

/*
 * Generic Driver Options
 */


/*
 * Memory Technology Devices (MTD)
 */


/*
 * Parallel port support
 */










/*
 * Plug and Play support
 */


/*
 * Block devices
 */
















/*
 * ATA/ATAPI/MFM/RLL support
 */



/*
 * Please see Documentation/ide.txt for help/info on IDE drives
 */












/*
 * IDE chipset support/bugfixes
 */










































/*
 * SCSI device support
 */



/*
 * SCSI support type (disk, tape, CD-ROM)
 */






/*
 * Some SCSI devices (e.g. CD jukebox) support multiple LUNs
 */





/*
 * SCSI Transport Attributes
 */



/*
 * SCSI low-level drivers
 */



















































/*
 * PCMCIA SCSI adapter support
 */





/*
 * Old CD-ROM drivers (not SCSI, not IDE)
 */


/*
 * Multi-device support (RAID and LVM)
 */


/*
 * Fusion MPT device support
 */


/*
 * IEEE 1394 (FireWire) support
 */


/*
 * I2O device support
 */


/*
 * Networking support
 */


/*
 * Networking options
 */


















/*
 * IP: Virtual Server Configuration
 */





/*
 * IP: Netfilter Configuration
 */
























































/*
 * SCTP Configuration (EXPERIMENTAL)
 */
















/*
 * QoS and/or fair queueing
 */


























/*
 * Network testing
 */













/*
 * ARCnet devices
 */


/*
 * Ethernet (10 or 100Mbit)
 */


/*
 * Ethernet (1000 Mbit)
 */











/*
 * Ethernet (10000 Mbit)
 */



/*
 * Token Ring devices
 */


/*
 * Wireless LAN (non-hamradio)
 */


/*
 * Obsolete Wireless cards support (pre-802.11)
 */






/*
 * Wireless 802.11 Frequency Hopping cards support
 */


/*
 * Wireless 802.11b ISA/PCI cards support
 */




/*
 * Wireless 802.11b Pcmcia/Cardbus cards support
 */



/*
 * Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
 */



/*
 * PCMCIA network device support
 */


/*
 * Wan interfaces
 */


















/*
 * ISDN subsystem
 */


/*
 * Telephony Support
 */


/*
 * Input device support
 */


/*
 * Userland interfaces
 */









/*
 * Input I/O drivers
 */









/*
 * Input Device Drivers
 */



















/*
 * Character devices
 */





/*
 * Serial drivers
 */







/*
 * Non-8250 serial port support
 */









/*
 * IPMI
 */


/*
 * Watchdog Cards
 */









/*
 * Ftape, the floppy tape device driver
 */





















/*
 * PCMCIA character devices
 */





/*
 * I2C support
 */



/*
 * I2C Algorithms
 */



/*
 * I2C Hardware Bus support
 */























/*
 * Hardware Sensors Chip support
 */


















/*
 * Other I2C Chip support
 */








/*
 * Misc devices
 */


/*
 * Multimedia devices
 */


/*
 * Video For Linux
 */

/*
 * Video Adapters
 */

















/*
 * Radio Adapters
 */















/*
 * Digital Video Broadcasting Devices
 */


/*
 * Graphics support
 */
























/*
 * Console display driver support
 */





/*
 * Logo configuration
 */


/*
 * Sound
 */


/*
 * Advanced Linux Sound Architecture
 */














/*
 * Generic devices
 */







/*
 * ISA devices
 */























/*
 * PCI devices
 */




































/*
 * ALSA USB devices
 */


/*
 * PCMCIA devices
 */




/*
 * Open Sound System
 */


/*
 * USB support
 */



/*
 * Miscellaneous USB options
 */




/*
 * USB Host Controller Drivers
 */






/*
 * USB Device Class drivers
 */
















/*
 * USB Human Interface Devices (HID)
 */





/*
 * USB HID Boot Protocol drivers
 */










/*
 * USB Imaging devices
 */




/*
 * USB Multimedia devices
 */










/*
 * USB Network adaptors
 */






/*
 * USB port drivers
 */


/*
 * USB Serial Converter support
 */


/*
 * USB Miscellaneous drivers
 */











/*
 * USB Gadget Support
 */


/*
 * File systems
 */















/*
 * CD-ROM/DVD Filesystems
 */





/*
 * DOS/FAT/NT Filesystems
 */







/*
 * Pseudo filesystems
 */












/*
 * Miscellaneous filesystems
 */














/*
 * Network File Systems
 */





















/*
 * Partition Types
 */



/*
 * Native Language Support
 */








































/*
 * Profiling support
 */


/*
 * Kernel hacking
 */








/*
 * Security options
 */


/*
 * Cryptographic options
 */





















/*
 * Library routines
 */














/* PAGE_SHIFT determines the page size */








/* !__ASSEMBLY__ */

/* to align the pointer to the (next) page boundary */


/*
 * This handles the memory map.. We could make this a config
 * option, but too many people screw it up, and too few need
 * it.
 *
 * A __PAGE_OFFSET of 0xC0000000 means that the kernel has
 * a virtual address space of one gigabyte, which limits the
 * amount of physical memory you can use to about 950MB. 
 *
 * If you want more physical memory than this then see the CONFIG_HIGHMEM4G
 * and CONFIG_HIGHMEM64G options in the kernel configuration.
 */

/*
 * This much address space is reserved for vmalloc() and iomap()
 * as well as fixmap mappings.
 */


/* __ASSEMBLY__ */
















/* !CONFIG_DISCONTIGMEM */






/* __KERNEL__ */

/* _I386_PAGE_H */




/*
 * low level task data that entry.S needs immediate access to
 * - this struct should fit entirely inside of one cache line
 * - this struct shares the supervisor stack pages
 * - if the contents of this structure are changed, the assembly constants must also be changed
 */
/* !__ASSEMBLY__ */

/* offsets into the thread_info struct for assembly code access */

















/*
 * macros/functions for gaining access to the thread information structure
 *
 * preempt_count needs to be 1 initially, until the scheduler is functional.
 */
/* !__ASSEMBLY__ */

/* how to get the thread information struct from ASM */


/* use this one if reg already contains %esp */




/*
 * thread information flags
 * - these are process state flags that various assembly files may need to access
 * - pending work-to-be-done flags are in LSW
 * - other flags in MSW
 */


















/* work to do on interrupt/exception return */



/*
 * Thread-synchronous status.
 *
 * This is different from the flags in that nobody else
 * ever touches our thread-synchronous status, so we don't
 * have to worry about atomic accesses.
 */


/* __KERNEL__ */

/* _ASM_THREAD_INFO_H */


OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(startup_32)
jiffies = jiffies_64;
SECTIONS
{
  . = 0xC0000000 + 0x100000;
  /* read-only */
  _text = .;			/* Text and read-only data */
  .text : {
	*(.text)
	__scheduling_functions_start_here = .;	*(.sched.text)	__scheduling_functions_end_here = .;
	*(.fixup)
	*(.gnu.warning)
	} = 0x9090

  _etext = .;			/* End of text section */

  . = ALIGN(16);		/* Exception table */
  __start___ex_table = .;
  __ex_table : { *(__ex_table) }
  __stop___ex_table = .;

  .rodata           : AT(ADDR(.rodata) - 0) {	*(.rodata) *(.rodata.*)	*(__vermagic)			}	.rodata1          : AT(ADDR(.rodata1) - 0) {	*(.rodata1)	}		__ksymtab         : AT(ADDR(__ksymtab) - 0) {	__start___ksymtab = .;	*(__ksymtab)	__stop___ksymtab = .;	}		__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - 0) {	__start___ksymtab_gpl = .;	*(__ksymtab_gpl)	__stop___ksymtab_gpl = .;	}		__kcrctab         : AT(ADDR(__kcrctab) - 0) {	__start___kcrctab = .;	*(__kcrctab)	__stop___kcrctab = .;	}		__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - 0) {	__start___kcrctab_gpl = .;	*(__kcrctab_gpl)	__stop___kcrctab_gpl = .;	}		__ksymtab_strings : AT(ADDR(__ksymtab_strings) - 0) {	*(__ksymtab_strings)	}

  /* writeable */
  .data : {			/* Data */
	*(.data)
	CONSTRUCTORS
	}

  . = ALIGN(4096);
  __nosave_begin = .;
  .data_nosave : { *(.data.nosave) }
  . = ALIGN(4096);
  __nosave_end = .;

  . = ALIGN(4096);
  .data.page_aligned : { *(.data.idt) }

  . = ALIGN(32);
  .data.cacheline_aligned : { *(.data.cacheline_aligned) }

  _edata = .;			/* End of data section */

  . = ALIGN((8192));	/* init_task */
  .data.init_task : { *(.data.init_task) }

  /* will be freed after init */
  . = ALIGN(4096);		/* Init code and data */
  __init_begin = .;
  .init.text : { 
	_sinittext = .;
	*(.init.text)
	_einittext = .;
  }
  .init.data : { *(.init.data) }
  . = ALIGN(16);
  __setup_start = .;
  .init.setup : { *(.init.setup) }
  __setup_end = .;
  __start___param = .;
  __param : { *(__param) }
  __stop___param = .;
  __initcall_start = .;
  .initcall.init : {
	*(.initcall1.init) 
	*(.initcall2.init) 
	*(.initcall3.init) 
	*(.initcall4.init) 
	*(.initcall5.init) 
	*(.initcall6.init) 
	*(.initcall7.init)
  }
  __initcall_end = .;
  __con_initcall_start = .;
  .con_initcall.init : { *(.con_initcall.init) }
  __con_initcall_end = .;
  .security_initcall.init : {	__security_initcall_start = .;	*(.security_initcall.init) __security_initcall_end = .;	}
  . = ALIGN(4);
  __alt_instructions = .;
  .altinstructions : { *(.altinstructions) } 
  __alt_instructions_end = .; 
 .altinstr_replacement : { *(.altinstr_replacement) } 
  /* .exit.text is discard at runtime, not link time, to deal with references
     from .altinstructions and .eh_frame */
  .exit.text : { *(.exit.text) }
  .exit.data : { *(.exit.data) }
  . = ALIGN(4096);
  __initramfs_start = .;
  .init.ramfs : { *(.init.ramfs) }
  __initramfs_end = .;
  . = ALIGN(32);
  __per_cpu_start = .;
  .data.percpu  : { *(.data.percpu) }
  __per_cpu_end = .;
  . = ALIGN(4096);
  __init_end = .;
  /* freed after init ends here */
	
  __bss_start = .;		/* BSS */
  .bss : {
	*(.bss.page_aligned)
	*(.bss)
  }
  . = ALIGN(4);
  __bss_stop = .; 

  _end = . ;

  /* This is where the kernel creates the early boot page tables */
  . = ALIGN(4096);
  pg0 = .;

  /* Sections to be discarded */
  /DISCARD/ : {
	*(.exitcall.exit)
	}

  /* Stabs debugging sections.  */
  .stab 0 : { *(.stab) }
  .stabstr 0 : { *(.stabstr) }
  .stab.excl 0 : { *(.stab.excl) }
  .stab.exclstr 0 : { *(.stab.exclstr) }
  .stab.index 0 : { *(.stab.index) }
  .stab.indexstr 0 : { *(.stab.indexstr) }
  .comment 0 : { *(.comment) }
}

==================================================
attempt to open arch/i386/kernel/head.o succeeded
arch/i386/kernel/head.o
attempt to open arch/i386/kernel/init_task.o succeeded
arch/i386/kernel/init_task.o
attempt to open init/built-in.o succeeded
init/built-in.o
attempt to open usr/built-in.o succeeded
usr/built-in.o
attempt to open arch/i386/kernel/built-in.o succeeded
arch/i386/kernel/built-in.o
attempt to open arch/i386/mm/built-in.o succeeded
arch/i386/mm/built-in.o
attempt to open arch/i386/mach-default/built-in.o succeeded
arch/i386/mach-default/built-in.o
attempt to open kernel/built-in.o succeeded
kernel/built-in.o
attempt to open mm/built-in.o succeeded
mm/built-in.o
attempt to open fs/built-in.o succeeded
fs/built-in.o
attempt to open ipc/built-in.o succeeded
ipc/built-in.o
attempt to open security/built-in.o succeeded
security/built-in.o
attempt to open crypto/built-in.o succeeded
crypto/built-in.o
attempt to open lib/lib.a succeeded
(lib/lib.a)bitmap.o
(lib/lib.a)cmdline.o
(lib/lib.a)ctype.o
(lib/lib.a)errno.o
(lib/lib.a)extable.o
(lib/lib.a)idr.o
(lib/lib.a)int_sqrt.o
(lib/lib.a)kobject.o
(lib/lib.a)parser.o
(lib/lib.a)radix-tree.o
(lib/lib.a)rbtree.o
(lib/lib.a)rwsem.o
(lib/lib.a)string.o
(lib/lib.a)vsprintf.o
attempt to open arch/i386/lib/lib.a succeeded
(arch/i386/lib/lib.a)checksum.o
(arch/i386/lib/lib.a)dec_and_lock.o
(arch/i386/lib/lib.a)delay.o
(arch/i386/lib/lib.a)getuser.o
(arch/i386/lib/lib.a)memcpy.o
(arch/i386/lib/lib.a)strstr.o
(arch/i386/lib/lib.a)usercopy.o
attempt to open lib/built-in.o succeeded
lib/built-in.o
attempt to open arch/i386/lib/built-in.o succeeded
attempt to open drivers/built-in.o succeeded
drivers/built-in.o
attempt to open sound/built-in.o succeeded
attempt to open arch/i386/pci/built-in.o succeeded
arch/i386/pci/built-in.o
attempt to open arch/i386/power/built-in.o succeeded
arch/i386/power/built-in.o
attempt to open net/built-in.o succeeded
net/built-in.o

--=-P51hGWPTrrwCYyGoc58x--

