Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbTJCWqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTJCWqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:46:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:54416 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261471AbTJCWqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:46:44 -0400
Date: Fri, 3 Oct 2003 15:46:40 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200310032246.h93Mker6018458@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 - 269 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/cpu/cpufreq/powernow-k8.c:38:2: warning: #warning this driver has not been tested on a preempt system
drivers/cdrom/aztcd.c:379: warning: `pa_ok' defined but not used
drivers/cdrom/isp16.c:124: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/cdrom/mcdx.h:180:2: warning: #warning You have not edited mcdx.h
drivers/cdrom/mcdx.h:181:2: warning: #warning Perhaps irq and i/o settings are wrong.
drivers/cdrom/sjcd.c:1699: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/char/applicom.c:260:2: warning: #warning "LEAK"
drivers/char/applicom.c:524:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"
drivers/char/applicom.c:67: warning: `applicom_pci_tbl' defined but not used
drivers/char/watchdog/alim1535_wdt.c:320: warning: `ali_pci_tbl' defined but not used
drivers/ide/ide.c:2480: warning: implicit declaration of function `pnpide_init'
drivers/ide/ide-probe.c:1326: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/ide-probe.c:1353: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/ide/ide-tape.c:6245: warning: duplicate `const'
drivers/ide/legacy/ide-cs.c:365: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/legacy/ide-cs.c:411: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/ide/pci/aec62xx.c:531: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/alim15x3.c:869: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/amd74xx.c:439: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/cmd64x.c:758: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/cs5520.c:294: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/cs5530.c:429: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/cy82c693.c:437: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/hpt34x.c:337: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/hpt366.c:1221: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/ns87415.c:233: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/opti621.c:369: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/pdc202xx_new.c:634: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/pdc202xx_old.c:923: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/piix.c:759: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/rz1000.c:65: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/sc1200.c:562: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/serverworks.c:797: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/siimage.c:1185: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/sis5513.c:959: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/slc90e66.c:379: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/triflex.c:227: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/trm290.c:378: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/ide/pci/trm290.c:406: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/pci/via82cxxx.c:637: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/input/gameport/ns558.c:121: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/input/gameport/ns558.c:80: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/media/video/hexium_orion.h:35: warning: `hexium_input_select' defined but not used
drivers/media/video/saa5249.c:217: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/media/video/saa5249.c:240: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/media/video/tuner-3036.c:138: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/media/video/tuner-3036.c:152: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/media/video/zoran_card.c:148: warning: `zr36067_pci_tbl' defined but not used
drivers/message/fusion/mptscsih.c:6922: warning: `mptscsih_setup' defined but not used
drivers/message/i2o/i2o_block.c:1507: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/mtd/chips/amd_flash.c:783: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/mtd/chips/cfi_cmdset_0001.c:381: warning: unsigned int format, different type arg (arg 2)
drivers/mtd/chips/cfi_cmdset_0001.c:965: warning: unsigned int format, different type arg (arg 2)
drivers/mtd/chips/cfi_cmdset_0002.c:1157: warning: unsigned int format, different type arg (arg 4)
drivers/mtd/chips/cfi_cmdset_0002.c:513: warning: unsigned int format, different type arg (arg 4)
drivers/mtd/chips/cfi_cmdset_0002.c:651: warning: unsigned int format, different type arg (arg 4)
drivers/mtd/chips/cfi_cmdset_0002.c:977: warning: unsigned int format, different type arg (arg 4)
drivers/mtd/chips/cfi_cmdset_0020.c:1139: warning: unsigned int format, different type arg (arg 3)
drivers/mtd/chips/cfi_cmdset_0020.c:1288: warning: unsigned int format, different type arg (arg 3)
drivers/mtd/chips/cfi_cmdset_0020.c:493: warning: unsigned int format, different type arg (arg 3)
drivers/mtd/chips/cfi_cmdset_0020.c:853: warning: unsigned int format, different type arg (arg 3)
drivers/mtd/chips/sharp.c:158: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/mtd/cmdlinepart.c:344: warning: `mtdpart_setup' defined but not used
drivers/mtd/devices/doc2000.c:567: warning: assignment from incompatible pointer type
drivers/mtd/devices/doc2000.c:568: warning: assignment from incompatible pointer type
drivers/mtd/devices/doc2001.c:376: warning: assignment from incompatible pointer type
drivers/mtd/devices/doc2001.c:377: warning: assignment from incompatible pointer type
drivers/mtd/inftlcore.c:761: warning: int format, long unsigned int arg (arg 3)
drivers/mtd/inftlcore.c:807: warning: int format, long unsigned int arg (arg 3)
drivers/mtd/nftlcore.c:354: warning: passing arg 7 of pointer to function makes pointer from integer without a cast
drivers/mtd/nftlcore.c:358: warning: passing arg 7 of pointer to function makes pointer from integer without a cast
drivers/mtd/nftlcore.c:363: warning: passing arg 7 of pointer to function makes pointer from integer without a cast
drivers/mtd/nftlcore.c:632: warning: passing arg 7 of pointer to function makes pointer from integer without a cast
drivers/mtd/nftlcore.c:696: warning: passing arg 7 of pointer to function makes pointer from integer without a cast
drivers/mtd/nftlmount.c:220: warning: passing arg 7 of pointer to function makes pointer from integer without a cast
drivers/net/3c515.c:529: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/net/acenic.c:135: warning: `acenic_pci_tbl' defined but not used
drivers/net/arcnet/com90xx.c:146: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/net/dgrs.c:124: warning: `dgrs_pci_tbl' defined but not used
drivers/net/eepro.c:575: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/net/ewrk3.c:1291: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/net/ewrk3.c:1335: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/net/hp100.c:288: warning: `hp100_pci_tbl' defined but not used
drivers/net/hp100.c:385: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/net/hp100.c:432: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/net/hp100.c:463: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/net/hp100.c:471: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/net/irda/act200l.c:116: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/irda/act200l.c:126: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/net/irda/actisys.c:132: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/irda/actisys.c:140: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/net/irda/esi.c:70: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/irda/esi.c:78: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/net/irda/girbil.c:89: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/irda/girbil.c:97: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/net/irda/litelink.c:74: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/irda/litelink.c:82: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/net/irda/ma600.c:119: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/irda/ma600.c:129: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/net/irda/mcp2120.c:66: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/irda/mcp2120.c:76: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/net/irda/old_belkin.c:102: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/irda/old_belkin.c:110: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/net/irda/tekram.c:73: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/irda/tekram.c:88: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/net/skfp/skfddi.c:185: warning: `skfddi_pci_tbl' defined but not used
drivers/net/tokenring/smctr.c:3494: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/tokenring/smctr.c:733: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/net/tulip/winbond-840.c:149: warning: `version' defined but not used
drivers/net/wan/cycx_drv.c:430: warning: long unsigned int format, u32 arg (arg 2)
drivers/net/wan/farsync.c:1316: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/wan/farsync.c:1329: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/net/wan/hostess_sv11.c:125: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/wan/hostess_sv11.c:157: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/net/wan/lmc/lmc_main.c:1063: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/net/wan/lmc/lmc_main.c:1184: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/wan/lmc/lmc_main.c:1355: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/net/wan/pc300_drv.c:3168: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/wan/pc300_drv.c:3204: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/net/wan/sbni.c:308: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/pcmcia/i82365.c:680: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/pcmcia/i82365.c:817: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/pcmcia/tcic.c:340: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/advansys.c:10006: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/advansys.c:4622: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/aha152x.c:396: warning: `id_table' defined but not used
drivers/scsi/aha152x.c:793: warning: `aha152x_setup' defined but not used
drivers/scsi/aha152x.c:852: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/aha152x.c:870: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/atp870u.c:2353: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/atp870u.c:2425: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/BusLogic.c:1003: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/BusLogic.c:1008: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/BusLogic.c:700: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/BusLogic.c:704: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/BusLogic.c:708: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/BusLogic.c:712: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/BusLogic.c:716: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/BusLogic.c:720: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/BusLogic.c:973: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/BusLogic.c:988: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/BusLogic.c:993: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/BusLogic.c:998: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/cpqfcTSinit.c:1583: warning: unused variable `timeout'
drivers/scsi/cpqfcTSinit.c:1584: warning: unused variable `retries'
drivers/scsi/cpqfcTSinit.c:1585: warning: unused variable `scsi_cdb'
drivers/scsi/cpqfcTSinit.c:471: warning: `my_ioctl_done' defined but not used
drivers/scsi/dtc.c:187: warning: `dtc_setup' defined but not used
drivers/scsi/eata_pio.c:596: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/fd_mcs.c:300: warning: `fd_mcs_setup' defined but not used
drivers/scsi/fd_mcs.c:311: warning: initialization from incompatible pointer type
drivers/scsi/fd_mcs.h:27: warning: `fd_mcs_command' declared `static' but never defined
drivers/scsi/fdomain.c:763: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/gdth.c:868: warning: `gdthtable' defined but not used
drivers/scsi/g_NCR5380.c:926: warning: `id_table' defined but not used
drivers/scsi/inia100.h:70: warning: `inia100_detect' declared `static' but never defined
drivers/scsi/inia100.h:71: warning: `inia100_release' declared `static' but never defined
drivers/scsi/inia100.h:72: warning: `inia100_queue' declared `static' but never defined
drivers/scsi/inia100.h:73: warning: `inia100_abort' declared `static' but never defined
drivers/scsi/inia100.h:74: warning: `inia100_device_reset' declared `static' but never defined
drivers/scsi/inia100.h:75: warning: `inia100_bus_reset' declared `static' but never defined
drivers/scsi/NCR5380.c:396: warning: `phases' defined but not used
drivers/scsi/NCR5380.c:699: warning: `NCR5380_probe_irq' defined but not used
drivers/scsi/NCR5380.c:756: warning: `NCR5380_print_options' defined but not used
drivers/scsi/NCR53c406a.c:611: warning: `NCR53c406a_setup' defined but not used
drivers/scsi/NCR53c406a.c:660: warning: initialization from incompatible pointer type
drivers/scsi/NCR53c406a.c:669: warning: `wait_intr' defined but not used
drivers/scsi/psi240i.c:713: warning: initialization from incompatible pointer type
drivers/scsi/psi240i.c:714: warning: initialization from incompatible pointer type
drivers/scsi/sym53c416.c:627: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/sym53c416.c:715: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/scsi/wd7000.c:1611: warning: `wd7000_abort' defined but not used
drivers/serial/8250.c:684: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/telephony/ixj.c:7737: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/telephony/ixj.c:7799: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/telephony/ixj.c:7835: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
drivers/telephony/ixj.h:41: warning: `ixj_h_rcsid' defined but not used
drivers/usb/class/usb-midi.h:150: warning: `usb_midi_ids' defined but not used
drivers/video/aty/aty128fb.c:2335: warning: `aty128fb_exit' defined but not used
drivers/video/aty/aty128fb.c:254: warning: `mode' defined but not used
drivers/video/aty/aty128fb.c:256: warning: `nomtrr' defined but not used
drivers/video/console/mdacon.c:374: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/video/console/mdacon.c:384: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
drivers/video/hgafb.c:452: warning: `hgafb_fillrect' defined but not used
drivers/video/hgafb.c:472: warning: `hgafb_copyarea' defined but not used
drivers/video/hgafb.c:502: warning: `hgafb_imageblit' defined but not used
drivers/video/imsttfb.c:1089: warning: `imsttfb_load_cursor_image' defined but not used
drivers/video/imsttfb.c:1159: warning: `imstt_set_cursor' defined but not used
drivers/video/matrox/matroxfb_base.c:1250: warning: `inverse' defined but not used
drivers/video/matrox/matroxfb_g450.c:129: warning: duplicate `const'
drivers/video/matrox/matroxfb_g450.c:130: warning: duplicate `const'
drivers/video/matrox/matroxfb_maven.c:347: warning: duplicate `const'
drivers/video/matrox/matroxfb_maven.c:348: warning: duplicate `const'
drivers/video/sis/sis_main.c:622: warning: unused variable `reg'
drivers/video/tdfxfb.c:1005: warning: `tdfxfb_cursor' defined but not used
drivers/video/tdfxfb.c:198: warning: `inverse' defined but not used
drivers/video/tdfxfb.c:199: warning: `mode_option' defined but not used
drivers/video/tridentfb.c:455: warning: `tridentfb_fillrect' defined but not used
drivers/video/tridentfb.c:473: warning: `tridentfb_copyarea' defined but not used
include/linux/ixjuser.h:45: warning: `ixjuser_h_rcsid' defined but not used
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
net/decnet/dn_nsp_in.c:805: warning: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1131)
net/decnet/dn_route.c:638: warning: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1131)
net/ipv4/ipcomp.c:189: warning: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1131)
net/ipv4/ipcomp.c:72: warning: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1131)
net/ipv4/ipvs/ip_vs_core.c:530: warning: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1131)
net/ipv4/ipvs/ip_vs_core.c:730: warning: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1131)
net/ipv4/ipvs/ip_vs_core.c:820: warning: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1131)
net/ipv4/ipvs/ip_vs_xmit.c:269: warning: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1131)
net/ipv6/ipcomp6.c:174: warning: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1131)
net/ipv6/ipcomp6.c:61: warning: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1131)
net/ipv6/netfilter/ip6table_mangle.c:162: warning: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1131)
net/ipv6/netfilter/ip6_tables.c:349: warning: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1131)
net/wanrouter/wanmain.c:729: warning: `dev_get' is deprecated (declared at include/linux/netdevice.h:508)
sound/isa/opti9xx/opti92x-ad1848.c:1670: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/isa/opti9xx/opti92x-ad1848.c:1686: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/isa/opti9xx/opti92x-ad1848.c:314: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/ac97_plugin_ad1980.c:90: warning: initialization from incompatible pointer type
sound/oss/ad1848.c:1580: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/ad1848.c:2530: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/ad1848.c:2967: warning: `id_table' defined but not used
sound/oss/ad1889.c:766: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
sound/oss/ad1889.c:773: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
sound/oss/ad1889.c:795: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
sound/oss/ad1889.c:801: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
sound/oss/cmpci.c:1465: warning: unused variable `s'
sound/oss/cmpci.c:2865: warning: `cmpci_pci_tbl' defined but not used
sound/oss/cs4232.c:141: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/cs4232.c:193: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/cs4281/cs4281m.c:2591: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
sound/oss/cs4281/cs4281m.c:2606: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
sound/oss/cs4281/cs4281m.c:3610: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
sound/oss/cs4281/cs4281m.c:3620: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
sound/oss/cs4281/cs4281m.c:3700: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
sound/oss/cs4281/cs4281m.c:3721: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
sound/oss/cs4281/cs4281m.c:4032: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
sound/oss/cs4281/cs4281m.c:4083: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
sound/oss/cs46xx.c:1893: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
sound/oss/cs46xx.c:1929: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
sound/oss/cs46xx.c:3373: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
sound/oss/cs46xx.c:3460: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
sound/oss/cs46xx.c:4108: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
sound/oss/cs46xx.c:4139: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
sound/oss/gus_card.c:76: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/gus_card.c:78: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/gus_card.c:93: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/gus_card.c:94: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/mad16.c:322: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/maui.c:307: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/mpu401.c:1217: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/opl3sa.c:114: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/opl3sa.c:122: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/pss.c:1004: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/pss.c:191: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/pss.c:640: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/pss.c:710: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/sb_common.c:1224: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/sb_common.c:523: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/sgalaxy.c:89: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/sgalaxy.c:97: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/sscape.c:1113: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/sscape.c:1132: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/sscape.c:1137: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/sscape.c:737: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/trix.c:147: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/trix.c:292: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/trix.c:85: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/wavfront.c:2426: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/wf_midi.c:788: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
