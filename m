Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbTIRGXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 02:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbTIRGXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 02:23:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:6822 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262987AbTIRGXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 02:23:04 -0400
Date: Wed, 17 Sep 2003 23:23:03 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200309180623.h8I6N3F4007504@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 - 27 New warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/cdrom/mcdx.h:180:2: warning: #warning You have not edited mcdx.h
drivers/cdrom/mcdx.h:181:2: warning: #warning Perhaps irq and i/o settings are wrong.
drivers/char/applicom.c:67: warning: `applicom_pci_tbl' defined but not used
drivers/char/watchdog/alim1535_wdt.c:320: warning: `ali_pci_tbl' defined but not used
drivers/ide/legacy/dtc2278.c:138: warning: `dtc2278_release' defined but not used
drivers/ide/legacy/pdc4030.c:307: warning: `return' with no value, in function returning non-void
drivers/ide/legacy/pdc4030.c:323: warning: control reaches end of non-void function
drivers/ide/legacy/umc8672.c:164: warning: `umc8672_release' defined but not used
drivers/media/video/zoran_card.c:148: warning: `zr36067_pci_tbl' defined but not used
drivers/message/fusion/mptscsih.c:6922: warning: `mptscsih_setup' defined but not used
drivers/net/acenic.c:135: warning: `acenic_pci_tbl' defined but not used
drivers/net/dgrs.c:123: warning: `dgrs_pci_tbl' defined but not used
drivers/net/hp100.c:287: warning: `hp100_pci_tbl' defined but not used
drivers/net/skfp/skfddi.c:185: warning: `skfddi_pci_tbl' defined but not used
drivers/net/tulip/winbond-840.c:149: warning: `version' defined but not used
drivers/net/wireless/arlan.c:26: warning: `probe' defined but not used
drivers/scsi/NCR53c406a.c:660: warning: initialization from incompatible pointer type
drivers/scsi/aha152x.c:397: warning: `id_table' defined but not used
drivers/scsi/dtc.c:187: warning: `dtc_setup' defined but not used
drivers/scsi/fd_mcs.c:311: warning: initialization from incompatible pointer type
drivers/scsi/g_NCR5380.c:925: warning: `id_table' defined but not used
drivers/scsi/gdth.c:868: warning: `gdthtable' defined but not used
drivers/usb/class/usb-midi.h:150: warning: `usb_midi_ids' defined but not used
sound/oss/ad1848.c:2967: warning: `id_table' defined but not used
sound/oss/cmpci.c:1465: warning: unused variable `s'
sound/oss/cmpci.c:2865: warning: `cmpci_pci_tbl' defined but not used
sound/oss/sb_common.c:523: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
