Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266346AbUBEQae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 11:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266361AbUBEQae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 11:30:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:45488 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266346AbUBEQac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 11:30:32 -0500
From: john cherry <cherry@osdl.org>
Date: Thu, 5 Feb 2004 08:30:30 -0800
Message-Id: <200402051630.i15GUUc32766@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.2 - 2004-02-04.17.30) - 34 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/ia64/ia32/elfcore32.h:13:1: warning: "USE_ELF_CORE_DUMP" redefined
arch/ia64/ia32/elfcore32.h:19:1: warning: "ELF_NGREG" redefined
arch/ia64/ia32/elfcore32.h:69:1: warning: "ELF_CORE_COPY_REGS" redefined
arch/ia64/ia32/ia32priv.h:288:1: warning: "elf_check_arch" redefined
arch/ia64/ia32/ia32priv.h:293:1: warning: "ELF_CLASS" redefined
arch/ia64/ia32/ia32priv.h:295:1: warning: "ELF_ARCH" redefined
arch/ia64/ia32/ia32priv.h:308:1: warning: "ELF_EXEC_PAGESIZE" redefined
arch/ia64/ia32/ia32priv.h:317:1: warning: "ELF_ET_DYN_BASE" redefined
arch/ia64/ia32/ia32priv.h:320:1: warning: "ELF_PLAT_INIT" redefined
arch/ia64/ia32/ia32priv.h:334:1: warning: "SET_PERSONALITY" redefined
arch/ia64/sn/io/machvec/pci_bus_cvlink.c:527: warning: cast to pointer from integer of different size
arch/ia64/sn/io/machvec/pci_bus_cvlink.c:527: warning: implicit declaration of function `pcibr_info_get'
arch/ia64/sn/io/sn2/module.c:222: warning: passing arg 2 of `hwgraph_debug' discards qualifiers from pointer target type
arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c:2513: warning: long unsigned int format, pointer arg (arg 2)
arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c:2613: warning: zero-length printf format string
drivers/net/sundance.c:1682: warning: long long unsigned int format, long unsigned int arg (arg 3)
drivers/net/sundance.c:995: warning: long long unsigned int format, long unsigned int arg (arg 3)
drivers/scsi/BusLogic.c:3556: warning: `BusLogic_AbortCommand' defined but not used
drivers/video/riva/fbdev.c:499: warning: cast from pointer to integer of different size
drivers/video/riva/fbdev.c:499: warning: cast to pointer from integer of different size
drivers/video/riva/fbdev.c:501: warning: cast from pointer to integer of different size
drivers/video/riva/fbdev.c:501: warning: cast to pointer from integer of different size
drivers/video/sis/sis_main.c:4960: warning: unsigned int format, different type arg (arg 2)
fs/binfmt_elf.c:185: warning: large integer implicitly truncated to unsigned type
include/asm/elf.h:140:1: warning: this is the location of the previous definition
include/asm/elf.h:154:1: warning: this is the location of the previous definition
include/asm/elf.h:169:1: warning: this is the location of the previous definition
include/asm/elf.h:190:1: warning: this is the location of the previous definition
include/asm/elf.h:19:1: warning: this is the location of the previous definition
include/asm/elf.h:24:1: warning: this is the location of the previous definition
include/asm/elf.h:26:1: warning: this is the location of the previous definition
include/asm/elf.h:28:1: warning: this is the location of the previous definition
include/asm/elf.h:34:1: warning: this is the location of the previous definition
include/asm/elf.h:43:1: warning: this is the location of the previous definition
