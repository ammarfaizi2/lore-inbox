Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTJ3SmL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 13:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTJ3SmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 13:42:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:59840 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262750AbTJ3Sln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 13:41:43 -0500
Subject: Re: 2.6.0-test9-mm1 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20031030011810.633a8f5b.akpm@osdl.org>
References: <20031030011810.633a8f5b.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1067539298.2249.57.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 30 Oct 2003 10:41:39 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel              bzImage    bzImage  bzImage  modules  bzImage  
modules
                  (defconfig)  (allno)  (allyes) (allyes) (allmod)
(allmod)
---------------   -----------  -------- -------- -------- --------
---------
2.6.0-test9-mm1    0w/0e       0w/0e   179w/ 1e  12w/0e   3w/0e   
213w/1e
2.6.0-test8-mm1    0w/0e       0w/0e   183w/ 1e  13w/0e   3w/0e   
223w/1e
2.6.0-test7-mm1    0w/0e       1w/0e   176w/ 1e   9w/0e   3w/0e   
231w/1e
2.6.0-test6-mm4    0w/0e       1w/0e   179w/ 1e   9w/0e   3w/0e   
234w/1e
2.6.0-test6-mm3    0w/0e       1w/0e   178w/ 1e   9w/0e   3w/0e   
252w/2e
2.6.0-test6-mm2    0w/0e       1w/0e   179w/ 1e   9w/0e   3w/0e   
252w/2e
2.6.0-test6-mm1    0w/0e       1w/0e   179w/ 1e   9w/0e   3w/0e   
252w/2e

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

Kernel version: 2.6.0-test9-mm1
Kernel build: 
   Making bzImage (defconfig): 0 warnings, 0 errors
   Making modules (defconfig): 0 warnings, 0 errors
   Making bzImage (allnoconfig): 0 warnings, 0 errors
   Making bzImage (allyesconfig): 174 warnings, 0 errors
   Making modules (allyesconfig): 12 warnings, 0 errors
   Making bzImage (allmodconfig): 3 warnings, 0 errors
   Making modules (allmodconfig): 213 warnings, 0 errors

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
   Building drivers/i2c: clean
   Building drivers/net: 31 warnings, 0 errors
   Building drivers/media: 1 warnings, 0 errors
   Building drivers/base: clean
   Building drivers/pci: clean
   Building drivers/eisa: clean
   Building drivers/isdn: clean
   Building drivers/char: 1 warnings, 0 errors
   Building drivers/acpi: clean
   Building drivers/serial: 1 warnings, 0 errors
   Building drivers/fc4: clean
   Building drivers/parport: clean
   Building drivers/mtd: 23 warnings, 0 errors
   Building drivers/usb: clean
   Building drivers/block: 1 warnings, 0 errors
   Building drivers/pcmcia: 3 warnings, 0 errors
   Building drivers/input: clean
   Building drivers/atm: clean
   Building drivers/ide: 30 warnings, 0 errors
   Building drivers/pnp: clean
   Building drivers/oprofile: clean
   Building drivers/ieee1394: clean
   Building drivers/cdrom: 3 warnings, 0 errors
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
   Building drivers/scsi/aic7xxx: clean
   Building drivers/scsi/pcmcia: 4 warnings, 0 errors
   Building drivers/scsi/sym53c8xx_2: clean
   Building drivers/video/aty: 3 warnings, 0 errors
   Building drivers/video/console: 2 warnings, 0 errors
   Building drivers/video/i810: clean
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
   Building net: 9 warnings, 0 errors
   Building security: clean
   Building sound: clean
   Building usr: clean
   Building fs: clean
   Building drivers/video: 8 warnings, 0 errors
   Building drivers/scsi: 46 warnings, 0 errors
   Building drivers/net: 0 warnings, 1 errors


Error Summary (individual module builds):

   drivers/net: 0 warnings, 1 errors


Warning Summary (individual module builds):

   drivers/block: 1 warnings, 0 errors
   drivers/cdrom: 3 warnings, 0 errors
   drivers/char: 1 warnings, 0 errors
   drivers/ide: 30 warnings, 0 errors
   drivers/media: 1 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/mtd: 23 warnings, 0 errors
   drivers/net: 31 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi/pcmcia: 4 warnings, 0 errors
   drivers/scsi: 46 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 5 warnings, 0 errors
   drivers/video/aty: 3 warnings, 0 errors
   drivers/video/console: 2 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/sis: 1 warnings, 0 errors
   drivers/video: 8 warnings, 0 errors
   net: 9 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors
   sound/oss: 33 warnings, 0 errors


Error List:

make[1]: [arch/i386/boot/bzImage] Error 1 (ignored)
make[2]: [drivers/net/wan/wanxlfw.inc] Error 127 (ignored)


Warning List:

arch/i386/kernel/cpu/cpufreq/powernow-k8.c:38:2: warning: #warning this
driver has not been tested on a preempt system
arch/i386/kernel/cpu/cpufreq/powernow-k8.c:938:2: warning: #warning
pol->policy is in undefined state here
drivers/cdrom/aztcd.c:379: warning: `pa_ok' defined but not used
drivers/cdrom/isp16.c:124: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/cdrom/mcdx.h:180:2: warning: #warning You have not edited mcdx.h
drivers/cdrom/mcdx.h:181:2: warning: #warning Perhaps irq and i/o
settings are wrong.
drivers/cdrom/sjcd.c:1700: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/char/applicom.c:522:2: warning: #warning "Je suis stupide. DW. -
copy*user in cli"
drivers/char/applicom.c:67: warning: `applicom_pci_tbl' defined but not
used
drivers/char/watchdog/alim1535_wdt.c:320: warning: `ali_pci_tbl' defined
but not used
drivers/ide/ide-probe.c:1326: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
drivers/ide/ide-probe.c:1353: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:494)
drivers/ide/ide-tape.c:6245: warning: duplicate `const'
drivers/ide/ide.c:2470: warning: implicit declaration of function
`pnpide_init'
drivers/ide/legacy/ide-cs.c:365: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/legacy/ide-cs.c:411: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:494)
drivers/ide/pci/aec62xx.c:533: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/alim15x3.c:869: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/amd74xx.c:422: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/cmd64x.c:755: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
drivers/ide/pci/cs5520.c:294: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
drivers/ide/pci/cs5530.c:416: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
drivers/ide/pci/cy82c693.c:437: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/hpt34x.c:334: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
drivers/ide/pci/hpt366.c:1223: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/ns87415.c:228: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/opti621.c:364: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/pdc202xx_new.c:631: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/pdc202xx_old.c:925: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/piix.c:746: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
drivers/ide/pci/rz1000.c:65: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
drivers/ide/pci/sc1200.c:557: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
drivers/ide/pci/serverworks.c:804: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/siimage.c:1174: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/sis5513.c:956: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/slc90e66.c:376: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/triflex.c:227: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/trm290.c:378: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/ide/pci/trm290.c:406: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
drivers/ide/pci/via82cxxx.c:618: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/input/gameport/ns558.c:121: warning: `check_region' is
deprecated (declared at include/linux/ioport.h:119)
drivers/input/gameport/ns558.c:80: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/media/common/saa7146_vbi.c:6: warning: `vbi_workaround' defined
but not used
drivers/media/video/zoran_card.c:149: warning: `zr36067_pci_tbl' defined
but not used
drivers/message/fusion/mptscsih.c:6922: warning: `mptscsih_setup'
defined but not used
drivers/message/i2o/i2o_block.c:1506: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:494)
drivers/mtd/chips/amd_flash.c:783: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
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
deprecated (declared at include/linux/module.h:482)
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
drivers/net/3c515.c:529: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
drivers/net/acenic.c:135: warning: `acenic_pci_tbl' defined but not used
drivers/net/arcnet/arc-rimi.c:319: warning: `dev_alloc' is deprecated
(declared at include/linux/netdevice.h:524)
drivers/net/arcnet/com20020-isa.c:152: warning: `dev_alloc' is
deprecated (declared at include/linux/netdevice.h:524)
drivers/net/arcnet/com20020-pci.c:71: warning: `dev_alloc' is deprecated
(declared at include/linux/netdevice.h:524)
drivers/net/arcnet/com90io.c:385: warning: `dev_alloc' is deprecated
(declared at include/linux/netdevice.h:524)
drivers/net/arcnet/com90xx.c:146: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/net/arcnet/com90xx.c:412: warning: `dev_alloc' is deprecated
(declared at include/linux/netdevice.h:524)
drivers/net/arcnet/com90xx.c:609: warning: `dev_alloc' is deprecated
(declared at include/linux/netdevice.h:524)
drivers/net/dgrs.c:124: warning: `dgrs_pci_tbl' defined but not used
drivers/net/eepro.c:575: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
drivers/net/ewrk3.c:1291: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/net/ewrk3.c:1335: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/net/hp100.c:288: warning: `hp100_pci_tbl' defined but not used
drivers/net/hp100.c:385: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
drivers/net/hp100.c:432: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
drivers/net/hp100.c:463: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
drivers/net/hp100.c:471: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:119)
drivers/net/sk98lin/skaddr.c:1092: warning: `ReturnCode' might be used
uninitialized in this function
drivers/net/sk98lin/skaddr.c:1624: warning: `ReturnCode' might be used
uninitialized in this function
drivers/net/skfp/skfddi.c:185: warning: `skfddi_pci_tbl' defined but not
used
drivers/net/tokenring/smctr.c:3494: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/net/tokenring/smctr.c:733: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:494)
drivers/net/tulip/winbond-840.c:149: warning: `version' defined but not
used
drivers/net/wan/cycx_drv.c:430: warning: long unsigned int format, u32
arg (arg 2)
drivers/net/wan/farsync.c:1316: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/net/wan/farsync.c:1329: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:494)
drivers/net/wan/hostess_sv11.c:125: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/net/wan/hostess_sv11.c:157: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:494)
drivers/net/wan/lmc/lmc_main.c:1063: warning: `check_region' is
deprecated (declared at include/linux/ioport.h:119)
drivers/net/wan/lmc/lmc_main.c:1184: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/net/wan/lmc/lmc_main.c:1355: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:494)
drivers/net/wan/pc300_drv.c:3168: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/net/wan/pc300_drv.c:3204: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:494)
drivers/net/wan/sbni.c:308: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/pcmcia/i82365.c:680: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/pcmcia/i82365.c:817: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
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
drivers/scsi/aha152x.c:396: warning: `id_table' defined but not used
drivers/scsi/aha152x.c:793: warning: `aha152x_setup' defined but not
used
drivers/scsi/aha152x.c:852: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/aha152x.c:870: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/atp870u.c:2350: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/atp870u.c:2422: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:119)
drivers/scsi/cpqfcTSinit.c:1583: warning: unused variable `timeout'
drivers/scsi/cpqfcTSinit.c:1584: warning: unused variable `retries'
drivers/scsi/cpqfcTSinit.c:1585: warning: unused variable `scsi_cdb'
drivers/scsi/cpqfcTSinit.c:471: warning: `my_ioctl_done' defined but not
used
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
drivers/scsi/inia100.h:70: warning: `inia100_detect' declared `static'
but never defined
drivers/scsi/inia100.h:71: warning: `inia100_release' declared `static'
but never defined
drivers/scsi/inia100.h:72: warning: `inia100_queue' declared `static'
but never defined
drivers/scsi/inia100.h:73: warning: `inia100_abort' declared `static'
but never defined
drivers/scsi/inia100.h:74: warning: `inia100_device_reset' declared
`static' but never defined
drivers/scsi/inia100.h:75: warning: `inia100_bus_reset' declared
`static' but never defined
drivers/scsi/libata-core.c:2122: warning: `ata_qc_push' defined but not
used
drivers/scsi/psi240i.c:713: warning: initialization from incompatible
pointer type
drivers/scsi/psi240i.c:714: warning: initialization from incompatible
pointer type
drivers/scsi/sata_promise.c:293: warning: `pdc_prep_lba28' defined but
not used
drivers/scsi/sata_promise.c:323: warning: `pdc_prep_lba48' defined but
not used
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
drivers/usb/class/usb-midi.h:150: warning: `usb_midi_ids' defined but
not used
drivers/video/aty/aty128fb.c:2335: warning: `aty128fb_exit' defined but
not used
drivers/video/aty/aty128fb.c:254: warning: `mode' defined but not used
drivers/video/aty/aty128fb.c:256: warning: `nomtrr' defined but not used
drivers/video/console/mdacon.c:374: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/video/console/mdacon.c:384: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:494)
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
net/decnet/dn_nsp_in.c:805: warning: `skb_linearize' is deprecated
(declared at include/linux/skbuff.h:1136)
net/decnet/dn_route.c:638: warning: `skb_linearize' is deprecated
(declared at include/linux/skbuff.h:1136)
net/ipv4/ipcomp.c:189: warning: `skb_linearize' is deprecated (declared
at include/linux/skbuff.h:1136)
net/ipv4/ipcomp.c:72: warning: `skb_linearize' is deprecated (declared
at include/linux/skbuff.h:1136)
net/ipv6/ipcomp6.c:174: warning: `skb_linearize' is deprecated (declared
at include/linux/skbuff.h:1136)
net/ipv6/ipcomp6.c:61: warning: `skb_linearize' is deprecated (declared
at include/linux/skbuff.h:1136)
net/ipv6/netfilter/ip6_tables.c:349: warning: `skb_linearize' is
deprecated (declared at include/linux/skbuff.h:1136)
net/ipv6/netfilter/ip6table_mangle.c:162: warning: `skb_linearize' is
deprecated (declared at include/linux/skbuff.h:1136)
net/wanrouter/wanmain.c:729: warning: `dev_get' is deprecated (declared
at include/linux/netdevice.h:513)
sound/isa/opti9xx/opti92x-ad1848.c:1670: warning: `check_region' is
deprecated (declared at include/linux/ioport.h:119)
sound/isa/opti9xx/opti92x-ad1848.c:1686: warning: `check_region' is
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
(declared at include/linux/module.h:482)
sound/oss/msnd.c:95: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:494)
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


