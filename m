Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269517AbUJTMgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269517AbUJTMgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270199AbUJTMeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:34:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:16349 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270105AbUJTMdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:33:35 -0400
Date: Wed, 20 Oct 2004 05:33:31 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200410201233.i9KCXVOB031073@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.9 - 2004-10-19.21.30) - 44 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** Warning: "i2o_msg_in_to_virt" [drivers/message/i2o/i2o_block.ko] undefined!
*** Warning: "i2o_msg_in_to_virt" [drivers/message/i2o/i2o_core.ko] undefined!
*** Warning: "i2o_msg_in_to_virt" [drivers/message/i2o/i2o_scsi.ko] undefined!
*** Warning: "i2o_msg_out_to_virt" [drivers/message/i2o/i2o_core.ko] undefined!
drivers/char/agp/backend.c:281: warning: `inter_module_register' is deprecated (declared at include/linux/module.h:579)
drivers/char/agp/backend.c:301: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:580)
drivers/char/drm/drm_agpsupport.h:431: warning: `inter_module_put' is deprecated (declared at include/linux/module.h:584)
drivers/char/drm/drm_stub.h:148: warning: `inter_module_put' is deprecated (declared at include/linux/module.h:584)
drivers/char/drm/drm_stub.h:150: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:580)
drivers/char/drm/drm_stub.h:206: warning: `inter_module_register' is deprecated (declared at include/linux/module.h:579)
drivers/char/drm/drm_stub.h:216: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:580)
drivers/isdn/hisax/hisax_fcpcipnp.c:1014: warning: label `out_unregister_isapnp' defined but not used
drivers/isdn/hisax/hisax_fcpcipnp.c:999: warning: unused variable `pci_nr_found'
drivers/message/i2o/exec-osm.c:332: warning: assignment makes pointer from integer without a cast
drivers/message/i2o/exec-osm.c:332: warning: implicit declaration of function `i2o_msg_in_to_virt'
drivers/message/i2o/i2o_block.c:434: warning: assignment makes pointer from integer without a cast
drivers/message/i2o/i2o_block.c:434: warning: implicit declaration of function `i2o_msg_in_to_virt'
drivers/message/i2o/i2o_scsi.c:308: warning: assignment makes pointer from integer without a cast
drivers/message/i2o/i2o_scsi.c:308: warning: implicit declaration of function `i2o_msg_in_to_virt'
drivers/message/i2o/pci.c:300: warning: assignment makes pointer from integer without a cast
drivers/message/i2o/pci.c:300: warning: implicit declaration of function `i2o_msg_out_to_virt'
drivers/mtd/chips/cfi_cmdset_0001.c:1836: warning: `inter_module_register' is deprecated (declared at include/linux/module.h:579)
drivers/mtd/chips/cfi_cmdset_0001.c:1837: warning: `inter_module_register' is deprecated (declared at include/linux/module.h:579)
drivers/mtd/chips/cfi_cmdset_0001.c:1843: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:580)
drivers/mtd/chips/cfi_cmdset_0001.c:1844: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:580)
drivers/mtd/chips/cfi_cmdset_0002.c:1737: warning: `inter_module_register' is deprecated (declared at include/linux/module.h:579)
drivers/mtd/chips/cfi_cmdset_0002.c:1744: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:580)
drivers/mtd/chips/cfi_cmdset_0020.c:1406: warning: `inter_module_register' is deprecated (declared at include/linux/module.h:579)
drivers/mtd/chips/cfi_cmdset_0020.c:1412: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:580)
drivers/mtd/chips/gen_probe.c:206: warning: `inter_module_put' is deprecated (declared at include/linux/module.h:584)
drivers/mtd/devices/doc2000.c:1295: warning: `inter_module_register' is deprecated (declared at include/linux/module.h:579)
drivers/mtd/devices/doc2000.c:1314: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:580)
drivers/mtd/devices/doc2001.c:861: warning: `inter_module_register' is deprecated (declared at include/linux/module.h:579)
drivers/mtd/devices/doc2001.c:880: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:580)
drivers/mtd/devices/doc2001plus.c:1127: warning: `inter_module_register' is deprecated (declared at include/linux/module.h:579)
drivers/mtd/devices/doc2001plus.c:1146: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:580)
drivers/mtd/devices/docprobe.c:315: warning: `inter_module_put' is deprecated (declared at include/linux/module.h:584)
drivers/video/i810/i810_main.c:1958: warning: `inter_module_put' is deprecated (declared at include/linux/module.h:584)
kernel/intermodule.c:179: warning: `inter_module_register' is deprecated (declared at kernel/intermodule.c:38)
kernel/intermodule.c:180: warning: `inter_module_unregister' is deprecated (declared at kernel/intermodule.c:79)
kernel/intermodule.c:183: warning: `inter_module_put' is deprecated (declared at kernel/intermodule.c:160)
lib/kobject_uevent.c:27: warning: `action_to_string' defined but not used
sound/oss/msnd.c:297: warning: implicit declaration of function `enable_irq'
sound/oss/msnd.c:326: warning: implicit declaration of function `disable_irq'
