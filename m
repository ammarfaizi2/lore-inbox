Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUANQFA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 11:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbUANQE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 11:04:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:64716 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261827AbUANQET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 11:04:19 -0500
Subject: Re: 2.6.1-mm3 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20040114014846.78e1a31b.akpm@osdl.org>
References: <20040114014846.78e1a31b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1074096253.24436.0.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 14 Jan 2004 08:04:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.1-mm3         0w/0e     0w/0e   151w/ 5e  10w/0e   3w/0e    177w/0e
2.6.1-mm2         0w/0e     0w/0e   143w/ 5e  12w/0e   3w/0e    171w/0e
2.6.1-mm1         0w/0e     0w/0e   146w/ 9e  12w/0e   6w/0e    171w/0e
2.6.1-rc2-mm1     0w/0e     0w/0e   149w/ 0e  12w/0e   6w/0e    171w/4e
2.6.1-rc1-mm2     0w/0e     0w/0e   157w/15e  12w/0e   3w/0e    185w/4e
2.6.1-rc1-mm1     0w/0e     0w/0e   156w/10e  12w/0e   3w/0e    184w/2e
2.6.0-mm2         0w/0e     0w/0e   161w/ 0e  12w/0e   3w/0e    189w/0e
2.6.0-mm1         0w/0e     0w/0e   173w/ 0e  12w/0e   3w/0e    212w/0e

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

Version information for host [ cherrypit.pdx.osdl.net ]
 gcc:    3.2.2
 patch:  2.5.4

Kernel version: 2.6.1-mm3
Kernel build: 
   Making bzImage (defconfig): 0 warnings, 0 errors
   Making modules (defconfig): 0 warnings, 0 errors
   Making bzImage (allnoconfig): 0 warnings, 0 errors
   Making bzImage (allyesconfig): 151 warnings, 5 errors
   Making modules (allyesconfig): 10 warnings, 0 errors
   Making bzImage (allmodconfig): 3 warnings, 0 errors
   Making modules (allmodconfig): 177 warnings, 0 errors

Building directories:
   Building fs/adfs: clean
   Building fs/affs: clean
   Building fs/afs: clean
   Building fs/autofs: clean
   Building fs/autofs4: clean
   Building fs/befs: clean
   Building fs/bfs: clean
   Building fs/cifs: clean
   Building fs/coda: clean
   Building fs/cramfs: clean
   Building fs/devfs: clean
   Building fs/devpts: clean
   Building fs/efs: clean
   Building fs/exportfs: clean
   Building fs/ext2: clean
   Building fs/ext3: clean
   Building fs/fat: clean
   Building fs/freevxfs: clean
   Building fs/hfs: clean
   Building fs/hpfs: clean
   Building fs/hugetlbfs: clean
   Building fs/intermezzo: clean
   Building fs/isofs: clean
   Building fs/jbd: clean
   Building fs/jffs: clean
   Building fs/jffs2: clean
   Building fs/jfs: clean
   Building fs/lockd: clean
   Building fs/minix: clean
   Building fs/msdos: clean
   Building fs/ncpfs: clean
   Building fs/nfs: clean
   Building fs/nfsd: clean
   Building fs/nls: clean
   Building fs/ntfs: clean
   Building fs/partitions: clean
   Building fs/proc: clean
   Building fs/qnx4: clean
   Building fs/ramfs: clean
   Building fs/reiserfs: clean
   Building fs/romfs: clean
   Building fs/smbfs: clean
   Building fs/sysfs: clean
   Building fs/sysv: clean
   Building fs/udf: clean
   Building fs/ufs: clean
   Building fs/vfat: clean
   Building fs/xfs: clean
   Building drivers/net: 8 warnings, 0 errors
   Building drivers/i2c: clean
   Building drivers/media: clean
   Building drivers/base: clean
   Building drivers/pci: clean
   Building drivers/eisa: clean
   Building drivers/isdn: clean
   Building drivers/char: 1 warnings, 0 errors
   Building drivers/acpi: clean
   Building drivers/serial: 1 warnings, 0 errors
   Building drivers/fc4: clean
   Building drivers/parport: clean
   Building drivers/usb: 9 warnings, 0 errors
   Building drivers/mtd: 23 warnings, 0 errors
   Building drivers/block: 1 warnings, 0 errors
   Building drivers/input: clean
   Building drivers/atm: clean
   Building drivers/ide: 30 warnings, 0 errors
   Building drivers/pnp: clean
   Building drivers/oprofile: clean
   Building drivers/ieee1394: clean
   Building drivers/cdrom: 3 warnings, 0 errors
   Building drivers/pcmcia: 4 warnings, 0 errors
   Building drivers/md: clean
   Building drivers/message: 1 warnings, 0 errors
   Building drivers/cpufreq: clean
   Building drivers/sbus: clean
   Building drivers/bluetooth: clean
   Building drivers/telephony: 5 warnings, 0 errors
   Building drivers/zorro: clean
   Building drivers/acorn: clean
   Building drivers/tc: clean
   Building drivers/mca: clean
   Building drivers/nubus: clean
   Building drivers/misc: clean
   Building drivers/dio: clean
   Building drivers/scsi/aacraid: clean
   Building drivers/scsi/aic7xxx: 0 warnings, 1 errors
   Building drivers/scsi/pcmcia: 4 warnings, 0 errors
   Building drivers/scsi/sym53c8xx_2: clean
   Building drivers/video/aty: 3 warnings, 0 errors
   Building drivers/video/console: 2 warnings, 0 errors
   Building drivers/video/i810: clean
   Building drivers/video/kyro: clean
   Building drivers/video/logo: clean
   Building drivers/video/matrox: 5 warnings, 0 errors
   Building drivers/video/riva: clean
   Building drivers/video/sis: 1 warnings, 0 errors
   Building sound/core: clean
   Building sound/drivers: clean
   Building sound/i2c: clean
   Building sound/isa: 3 warnings, 0 errors
   Building sound/oss: 33 warnings, 0 errors
   Building sound/pci: clean
   Building sound/pcmcia: clean
   Building sound/synth: clean
   Building sound/usb: clean
   Building arch/i386: clean
   Building crypto: clean
   Building lib: clean
   Building net: clean
   Building security: clean
   Building sound: clean
   Building usr: clean
   Building fs: clean
   Building drivers/video: 8 warnings, 0 errors
   Building drivers/scsi: 34 warnings, 0 errors
   Building drivers/net: 0 warnings, 1 errors


Error Summary (individual module builds):

   drivers/net: 0 warnings, 1 errors
   drivers/scsi/aic7xxx: 0 warnings, 1 errors  
      (needs parallel build patch)


Warning Summary (individual module builds):

   drivers/block: 1 warnings, 0 errors
   drivers/cdrom: 3 warnings, 0 errors
   drivers/char: 1 warnings, 0 errors
   drivers/ide: 30 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/mtd: 23 warnings, 0 errors
   drivers/net: 8 warnings, 0 errors
   drivers/pcmcia: 4 warnings, 0 errors
   drivers/scsi/pcmcia: 4 warnings, 0 errors
   drivers/scsi: 34 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 5 warnings, 0 errors
   drivers/usb: 9 warnings, 0 errors
   drivers/video/aty: 3 warnings, 0 errors
   drivers/video/console: 2 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/sis: 1 warnings, 0 errors
   drivers/video: 8 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors
   sound/oss: 33 warnings, 0 errors


Error List:

make: [.tmp_vmlinux1] Error 1 (ignored)
make: [.tmp_vmlinux2] Error 1 (ignored)
make: [vmlinux] Error 1 (ignored)
make[1]: [arch/i386/boot/bzImage] Error 1 (ignored)
make[1]: [arch/i386/boot/compressed/vmlinux] Error 2 (ignored)
make[1]: [arch/i386/boot/vmlinux.bin] Error 1 (ignored)
make[2]: [aicasm_gram.c] Error 1 (ignored)
make[2]: [drivers/net/wan/wanxlfw.inc] Error 127 (ignored)


Warning List:

arch/i386/kernel/cpu/cpufreq/powernow-k8.c:38:2: warning: #warning this
driver has not been tested on a preempt system
drivers/cdrom/aztcd.c:379: warning: `pa_ok' defined but not used
drivers/cdrom/isp16.c:124: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/cdrom/mcdx.h:180:2: warning: #warning You have not edited mcdx.h
drivers/cdrom/mcdx.h:181:2: warning: #warning Perhaps irq and i/o
settings are wrong.
drivers/cdrom/sjcd.c:1703: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/char/applicom.c:522:2: warning: #warning "Je suis stupide. DW. -
copy*user in cli"
drivers/char/applicom.c:67: warning: `applicom_pci_tbl' defined but not
used
drivers/char/watchdog/alim1535_wdt.c:320: warning: `ali_pci_tbl' defined
but not used
drivers/ide/ide-probe.c:1326: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:485)
drivers/ide/ide-probe.c:1355: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:497)
drivers/ide/ide-tape.c:6301: warning: duplicate `const'
drivers/ide/ide.c:2470: warning: implicit declaration of function
`pnpide_init'
drivers/ide/legacy/ide-cs.c:364: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/legacy/ide-cs.c:410: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:497)
drivers/ide/pci/aec62xx.c:533: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/pci/alim15x3.c:871: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/pci/amd74xx.c:451: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/pci/cmd64x.c:755: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:485)
drivers/ide/pci/cs5520.c:294: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:485)
drivers/ide/pci/cs5530.c:416: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:485)
drivers/ide/pci/cy82c693.c:437: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/pci/hpt34x.c:334: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:485)
drivers/ide/pci/hpt366.c:1223: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/pci/ns87415.c:228: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/pci/opti621.c:364: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/pci/pdc202xx_new.c:591: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/pci/pdc202xx_old.c:916: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/pci/piix.c:746: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:485)
drivers/ide/pci/rz1000.c:65: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:485)
drivers/ide/pci/sc1200.c:557: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:485)
drivers/ide/pci/serverworks.c:804: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/pci/siimage.c:1196: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/pci/sis5513.c:956: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/pci/slc90e66.c:376: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/pci/triflex.c:227: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/ide/pci/trm290.c:378: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/ide/pci/trm290.c:406: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:485)
drivers/ide/pci/via82cxxx.c:618: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/input/gameport/ns558.c:121: warning: `check_region' is
deprecated (declared at include/linux/ioport.h:119)
drivers/input/gameport/ns558.c:80: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/media/video/zoran_card.c:149: warning: `zr36067_pci_tbl' defined
but not used
drivers/message/fusion/mptscsih.c:7061: warning: `mptscsih_setup'
defined but not used
drivers/message/i2o/i2o_block.c:1507: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:497)
drivers/mtd/chips/amd_flash.c:783: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/mtd/chips/cfi_cmdset_0001.c:381: warning: unsigned int format,
different type arg (arg 2)
drivers/mtd/chips/cfi_cmdset_0001.c:965: warning: unsigned int format,
different type arg (arg 2)
drivers/mtd/chips/cfi_cmdset_0002.c:1157: warning: unsigned int format,
different type arg (arg 4)
drivers/mtd/chips/cfi_cmdset_0002.c:513: warning: unsigned int format,
different type arg (arg 4)
drivers/mtd/chips/cfi_cmdset_0002.c:651: warning: unsigned int format,
different type arg (arg 4)
drivers/mtd/chips/cfi_cmdset_0002.c:977: warning: unsigned int format,
different type arg (arg 4)
drivers/mtd/chips/cfi_cmdset_0020.c:1139: warning: unsigned int format,
different type arg (arg 3)
drivers/mtd/chips/cfi_cmdset_0020.c:1288: warning: unsigned int format,
different type arg (arg 3)
drivers/mtd/chips/cfi_cmdset_0020.c:493: warning: unsigned int format,
different type arg (arg 3)
drivers/mtd/chips/cfi_cmdset_0020.c:853: warning: unsigned int format,
different type arg (arg 3)
drivers/mtd/chips/sharp.c:157: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/mtd/cmdlinepart.c:344: warning: `mtdpart_setup' defined but not
used
drivers/mtd/devices/doc2000.c:567: warning: assignment from incompatible
pointer type
drivers/mtd/devices/doc2000.c:568: warning: assignment from incompatible
pointer type
drivers/mtd/devices/doc2001.c:376: warning: assignment from incompatible
pointer type
drivers/mtd/devices/doc2001.c:377: warning: assignment from incompatible
pointer type
drivers/mtd/nftlcore.c:354: warning: passing arg 7 of pointer to
function makes pointer from integer without a cast
drivers/mtd/nftlcore.c:358: warning: passing arg 7 of pointer to
function makes pointer from integer without a cast
drivers/mtd/nftlcore.c:363: warning: passing arg 7 of pointer to
function makes pointer from integer without a cast
drivers/mtd/nftlcore.c:632: warning: passing arg 7 of pointer to
function makes pointer from integer without a cast
drivers/mtd/nftlcore.c:696: warning: passing arg 7 of pointer to
function makes pointer from integer without a cast
drivers/mtd/nftlmount.c:220: warning: passing arg 7 of pointer to
function makes pointer from integer without a cast
drivers/net/acenic.c:135: warning: `acenic_pci_tbl' defined but not used
drivers/net/arcnet/com20020-isa.c:188: warning: unused variable `dev'
drivers/net/arcnet/com20020-isa.c:189: warning: unused variable `lp'
drivers/net/dgrs.c:1463: warning: `dev' might be used uninitialized in
this function
drivers/net/ibmlana.c:910: warning: `ibmlana_probe' defined but not used
drivers/net/ne.c:168: warning: unused variable `irq'
drivers/net/netconsole.c:99: warning: initialization from incompatible
pointer type
drivers/net/sk98lin/skaddr.c:1092: warning: `ReturnCode' might be used
uninitialized in this function
drivers/net/sk98lin/skaddr.c:1624: warning: `ReturnCode' might be used
uninitialized in this function
drivers/net/sk98lin/skge.c:713: warning: unused variable
`proc_root_initialized'
drivers/net/tulip/winbond-840.c:149: warning: `version' defined but not
used
drivers/net/wan/cycx_drv.c:430: warning: unsigned int format, long
unsigned int arg (arg 3)
drivers/net/wan/pc300_tty.c:584:2: warning: #warning This is broken. See
comments.
drivers/pcmcia/i82365.c:665: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/pcmcia/i82365.c:799: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/pcmcia/pcmcia_compat.c:158: warning: `CardServices' is
deprecated (declared at drivers/pcmcia/pcmcia_compat.c:35)
drivers/pcmcia/tcic.c:340: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:1003: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:1008: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:700: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:704: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:708: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:712: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:716: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:720: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:973: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:988: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:993: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:998: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/NCR5380.c:396: warning: `phases' defined but not used
drivers/scsi/NCR5380.c:699: warning: `NCR5380_probe_irq' defined but not
used
drivers/scsi/NCR5380.c:756: warning: `NCR5380_print_options' defined but
not used
drivers/scsi/NCR53c406a.c:611: warning: `NCR53c406a_setup' defined but
not used
drivers/scsi/NCR53c406a.c:660: warning: initialization from incompatible
pointer type
drivers/scsi/NCR53c406a.c:669: warning: `wait_intr' defined but not used
drivers/scsi/advansys.c:10006: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/advansys.c:4622: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/aha152x.c:404: warning: `id_table' defined but not used
drivers/scsi/aha152x.c:804: warning: `aha152x_setup' defined but not
used
drivers/scsi/aha152x.c:863: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/aha152x.c:881: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/atp870u.c:2350: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/atp870u.c:2422: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/dtc.c:187: warning: `dtc_setup' defined but not used
drivers/scsi/eata_pio.c:596: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/fd_mcs.c:300: warning: `fd_mcs_setup' defined but not used
drivers/scsi/fd_mcs.c:311: warning: initialization from incompatible
pointer type
drivers/scsi/fd_mcs.h:27: warning: `fd_mcs_command' declared `static'
but never defined
drivers/scsi/fdomain.c:763: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/g_NCR5380.c:926: warning: `id_table' defined but not used
drivers/scsi/gdth.c:881: warning: `gdthtable' defined but not used
drivers/scsi/libata-core.c:2141: warning: `ata_qc_push' defined but not
used
drivers/scsi/psi240i.c:713: warning: initialization from incompatible
pointer type
drivers/scsi/psi240i.c:714: warning: initialization from incompatible
pointer type
drivers/scsi/sym53c416.c:627: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/sym53c416.c:715: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/wd7000.c:1611: warning: `wd7000_abort' defined but not used
drivers/serial/8250.c:693: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/telephony/ixj.c:7737: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/telephony/ixj.c:7799: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/telephony/ixj.c:7835: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/telephony/ixj.h:41: warning: `ixj_h_rcsid' defined but not used
drivers/usb/class/usb-midi.h:144: warning: `usb_midi_ids' defined but
not used
drivers/usb/media/pwc-if.c:1124: warning: control reaches end of
non-void function
drivers/usb/media/pwc-if.c:1855: warning: assignment from incompatible
pointer type
drivers/usb/serial/ftdi_sio.c:1874: warning: unused variable `serial'
drivers/usb/serial/ftdi_sio.c:1875: warning: unused variable `priv'
drivers/usb/serial/ftdi_sio.c:1900: warning: unused variable `serial'
drivers/usb/serial/ftdi_sio.c:1903: warning: unused variable `urb_value'
drivers/usb/serial/ftdi_sio.c:1904: warning: unused variable `buf'
drivers/usb/serial/ftdi_sio.c:1905: warning: unused variable `mask'
drivers/usb/serial/ftdi_sio.c:1905: warning: unused variable `ret'
drivers/video/aty/aty128fb.c:2336: warning: `aty128fb_exit' defined but
not used
drivers/video/aty/aty128fb.c:254: warning: `mode' defined but not used
drivers/video/aty/aty128fb.c:256: warning: `nomtrr' defined but not used
drivers/video/console/mdacon.c:374: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:485)
drivers/video/console/mdacon.c:384: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:497)
drivers/video/hgafb.c:452: warning: `hgafb_fillrect' defined but not
used
drivers/video/hgafb.c:472: warning: `hgafb_copyarea' defined but not
used
drivers/video/hgafb.c:502: warning: `hgafb_imageblit' defined but not
used
drivers/video/imsttfb.c:1089: warning: `imsttfb_load_cursor_image'
defined but not used
drivers/video/imsttfb.c:1159: warning: `imstt_set_cursor' defined but
not used
drivers/video/matrox/matroxfb_base.c:1250: warning: `inverse' defined
but not used
drivers/video/matrox/matroxfb_g450.c:129: warning: duplicate `const'
drivers/video/matrox/matroxfb_g450.c:130: warning: duplicate `const'
drivers/video/matrox/matroxfb_maven.c:347: warning: duplicate `const'
drivers/video/matrox/matroxfb_maven.c:348: warning: duplicate `const'
drivers/video/sis/sis_main.c:622: warning: unused variable `reg'
drivers/video/tdfxfb.c:1005: warning: `tdfxfb_cursor' defined but not
used
drivers/video/tdfxfb.c:198: warning: `inverse' defined but not used
drivers/video/tdfxfb.c:199: warning: `mode_option' defined but not used
drivers/video/tridentfb.c:455: warning: `tridentfb_fillrect' defined but
not used
drivers/video/tridentfb.c:473: warning: `tridentfb_copyarea' defined but
not used
include/linux/ixjuser.h:45: warning: `ixjuser_h_rcsid' defined but not
used
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please
move your driver to the new sysfs api"
sound/isa/opti9xx/opti92x-ad1848.c:1671: warning: `check_region' is
deprecated (declared at include/linux/ioport.h:119)
sound/isa/opti9xx/opti92x-ad1848.c:1687: warning: `check_region' is
deprecated (declared at include/linux/ioport.h:119)
sound/isa/opti9xx/opti92x-ad1848.c:314: warning: `check_region' is
deprecated (declared at include/linux/ioport.h:119)
sound/oss/ad1848.c:1580: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/ad1848.c:2530: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/ad1848.c:2967: warning: `id_table' defined but not used
sound/oss/cmpci.c:1465: warning: unused variable `s'
sound/oss/cmpci.c:2865: warning: `cmpci_pci_tbl' defined but not used
sound/oss/cs4232.c:141: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/cs4232.c:193: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/gus_card.c:76: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/gus_card.c:78: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/gus_card.c:93: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/gus_card.c:94: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/mad16.c:322: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/maui.c:307: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:119)
sound/oss/mpu401.c:1217: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/msnd.c:74: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:485)
sound/oss/msnd.c:95: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:497)
sound/oss/msnd_pinnacle.c:1123: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
sound/oss/msnd_pinnacle.c:1811: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
sound/oss/opl3sa.c:114: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/opl3sa.c:122: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/pss.c:1004: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:119)
sound/oss/pss.c:191: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:119)
sound/oss/pss.c:640: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:119)
sound/oss/pss.c:710: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:119)
sound/oss/sb_common.c:1224: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
sound/oss/sb_common.c:523: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
sound/oss/sgalaxy.c:89: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/sgalaxy.c:97: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/sscape.c:1113: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/sscape.c:1132: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/sscape.c:1137: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/sscape.c:737: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
sound/oss/trix.c:147: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:119)
sound/oss/trix.c:292: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:119)
sound/oss/trix.c:85: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:119)
sound/oss/wavfront.c:2426: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
sound/oss/wf_midi.c:788: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)

John



