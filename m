Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265885AbUGPLyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265885AbUGPLyc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 07:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbUGPLyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 07:54:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:32700 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265885AbUGPLya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 07:54:30 -0400
Date: Fri, 16 Jul 2004 04:54:29 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200407161154.i6GBsTgA007225@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.8-rc1 - 2004-07-15.22.30) - 23 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** Warning: "map_read32" [drivers/mtd/chips/sharp.ko] undefined!
*** Warning: "map_write32" [drivers/mtd/chips/sharp.ko] undefined!
drivers/mtd/chips/amd_flash.c:144: warning: implicit declaration of function `map_read8'
drivers/mtd/chips/amd_flash.c:146: warning: implicit declaration of function `map_read16'
drivers/mtd/chips/amd_flash.c:148: warning: implicit declaration of function `map_read32'
drivers/mtd/chips/amd_flash.c:157: warning: implicit declaration of function `map_write8'
drivers/mtd/chips/amd_flash.c:159: warning: implicit declaration of function `map_write16'
drivers/mtd/chips/amd_flash.c:161: warning: implicit declaration of function `map_write32'
drivers/mtd/chips/jedec.c:409: warning: implicit declaration of function `map_read8'
drivers/mtd/chips/jedec.c:414: warning: implicit declaration of function `map_write8'
drivers/mtd/chips/jedec.c:469: warning: implicit declaration of function `map_read32'
drivers/mtd/chips/jedec.c:474: warning: implicit declaration of function `map_write32'
drivers/mtd/chips/jedec.c:700: warning: implicit declaration of function `map_read16'
drivers/mtd/chips/sharp.c:169: warning: implicit declaration of function `map_read32'
drivers/mtd/chips/sharp.c:171: warning: implicit declaration of function `map_write32'
drivers/mtd/devices/doc2000.c:603: warning: assignment from incompatible pointer type
drivers/mtd/devices/doc2001.c:377: warning: assignment from incompatible pointer type
drivers/mtd/devices/doc2001.c:378: warning: assignment from incompatible pointer type
drivers/mtd/maps/ichxrom.c:290: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/mtd/nand/diskonchip.c:657: warning: comparison of distinct pointer types lacks a cast
drivers/mtd/nand/diskonchip.c:717: warning: comparison of distinct pointer types lacks a cast
drivers/mtd/nand/diskonchip.c:744: warning: comparison of distinct pointer types lacks a cast
drivers/mtd/nftlmount.c:44: warning: unused variable `oob'
