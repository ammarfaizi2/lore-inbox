Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbUBTRBM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 12:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbUBTRBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 12:01:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:20669 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261342AbUBTRA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 12:00:58 -0500
From: john cherry <cherry@osdl.org>
Date: Fri, 20 Feb 2004 09:00:57 -0800
Message-Id: <200402201700.i1KH0vj31781@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.3 - 2004-02-19.17.30) - 62 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/ia64/sn/io/machvec/pci_bus_cvlink.c:777: warning: `return' with no value, in function returning non-void
arch/ia64/sn/io/machvec/pci_bus_cvlink.c:808: warning: `return' with no value, in function returning non-void
drivers/isdn/capi/capidrv.c:1845: warning: cast from pointer to integer of different size
drivers/isdn/capi/capidrv.c:2111:10: warning: #warning FIXME: maybe a race condition the card should be removed here from global list /kkeil
drivers/isdn/hisax/avm_pci.c:817: warning: label `ready' defined but not used
drivers/isdn/hisax/config.c:1736: warning: cast from pointer to integer of different size
drivers/isdn/hisax/config.c:1740: warning: cast from pointer to integer of different size
drivers/isdn/hisax/config.c:1804: warning: cast to pointer from integer of different size
drivers/isdn/hisax/config.c:1889: warning: `hisax_pci_tbl' defined but not used
drivers/isdn/hisax/diva.c:1104: warning: label `ready' defined but not used
drivers/isdn/hisax/hfc_pci.c:1212: warning: cast from pointer to integer of different size
drivers/isdn/hisax/hfc_pci.c:1230: warning: cast from pointer to integer of different size
drivers/isdn/hisax/hfc_pci.c:1712: warning: cast from pointer to integer of different size
drivers/isdn/hisax/hfc_pci.c:1713: warning: cast from pointer to integer of different size
drivers/isdn/hisax/hfc_sx.c:974: warning: cast from pointer to integer of different size
drivers/isdn/hisax/hfc_sx.c:990: warning: cast from pointer to integer of different size
drivers/isdn/hisax/hfc_usb.c:1060: warning: cast from pointer to integer of different size
drivers/isdn/hisax/hfc_usb.c:743: warning: cast to pointer from integer of different size
drivers/isdn/hisax/hisax_fcpcipnp.c:1029: warning: label `out_unregister_pci' defined but not used
drivers/isdn/hisax/hisax_fcpcipnp.c:551: warning: cast to pointer from integer of different size
drivers/isdn/hisax/hisax_fcpcipnp.c:642: warning: cast from pointer to integer of different size
drivers/isdn/hisax/netjet.c:741: warning: cast from pointer to integer of different size
drivers/isdn/hisax/netjet.c:970: warning: cast from pointer to integer of different size
drivers/isdn/hisax/netjet.c:971: warning: cast from pointer to integer of different size
drivers/isdn/hisax/netjet.c:984: warning: cast from pointer to integer of different size
drivers/isdn/hisax/netjet.c:985: warning: cast from pointer to integer of different size
drivers/isdn/hisax/sedlbauer.c:681: warning: label `ready' defined but not used
drivers/isdn/hisax/st5481_b.c:356: warning: cast from pointer to integer of different size
drivers/isdn/hisax/st5481_b.c:89: warning: cast to pointer from integer of different size
drivers/isdn/hisax/st5481_d.c:397: warning: cast to pointer from integer of different size
drivers/isdn/hisax/st5481_d.c:545: warning: cast from pointer to integer of different size
drivers/isdn/i4l/isdn_ppp.c:1543: warning: large integer implicitly truncated to unsigned type
drivers/isdn/tpam/tpam_commands.c:123: warning: cast to pointer from integer of different size
drivers/isdn/tpam/tpam_commands.c:133: warning: cast to pointer from integer of different size
drivers/isdn/tpam/tpam_commands.c:134: warning: cast to pointer from integer of different size
drivers/isdn/tpam/tpam_commands.c:153: warning: cast to pointer from integer of different size
drivers/isdn/tpam/tpam_commands.c:161: warning: cast to pointer from integer of different size
drivers/isdn/tpam/tpam_commands.c:162: warning: cast to pointer from integer of different size
drivers/isdn/tpam/tpam_commands.c:534: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_commands.c:541: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_commands.c:551: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_commands.c:557: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_commands.c:868: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_commands.c:872: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_memory.c:100: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_memory.c:101: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_memory.c:151: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_memory.c:160: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_memory.c:191: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_memory.c:206: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_memory.c:33: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_memory.c:52: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_memory.c:53: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_memory.c:62: warning: passing arg 2 of `__ia64_memcpy_toio' discards qualifiers from pointer target type
drivers/isdn/tpam/tpam_memory.c:82: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_memory.c:85: warning: cast from pointer to integer of different size
drivers/isdn/tpam/tpam_queues.c:110: warning: cast to pointer from integer of different size
drivers/isdn/tpam/tpam_queues.c:134: warning: cast to pointer from integer of different size
drivers/isdn/tpam/tpam_queues.c:140: warning: cast to pointer from integer of different size
drivers/isdn/tpam/tpam_queues.c:369: warning: cast to pointer from integer of different size
drivers/isdn/tpam/tpam_queues.c:373: warning: cast to pointer from integer of different size
fs/smbfs/file.c:273: warning: int format, different type arg (arg 5)
