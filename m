Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316250AbSGATTX>; Mon, 1 Jul 2002 15:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSGATTW>; Mon, 1 Jul 2002 15:19:22 -0400
Received: from quake.mweb.co.za ([196.2.45.76]:2734 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id <S316250AbSGATTU>;
	Mon, 1 Jul 2002 15:19:20 -0400
Subject: EXT3 errors
From: Bongani <bonganilinux@mweb.co.za>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-1mdk 
Date: 01 Jul 2002 21:24:15 +0200
Message-Id: <1025551456.1587.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Does anyone what cause's these message. I have a 41M messages file
because of the.


Jul  1 04:02:14 localhost kernel: EXT3-fs error (device ide0(3,70)):
ext3_new_block: Allocating block in system zone - block = 32802
Jul  1 04:02:14 localhost kernel: EXT3-fs error (device ide0(3,70)):
ext3_new_block: Allocating block in system zone - block = 32803
Jul  1 04:02:14 localhost kernel: EXT3-fs error (device ide0(3,70)):
ext3_new_block: Allocating block in system zone - block = 32804
Jul  1 04:02:15 localhost kernel: EXT3-fs error (device ide0(3,70)):
ext3_free_blocks: Freeing blocks in system zones - Block = 32802, count
= 3
Jul  1 04:06:02 localhost kernel: attempt to access beyond end of device
Jul  1 04:06:02 localhost kernel: 03:46: rw=0, want=1025837100,
limit=6345643
Jul  1 04:06:02 localhost kernel: EXT3-fs error (device ide0(3,70)):
ext3_readdir: directory #17205 contains a hole at offset 0
Jul  1 04:06:02 localhost kernel: attempt to access beyond end of device
Jul  1 04:06:02 localhost kernel: 03:46: rw=0, want=226335104,
limit=6345643
Jul  1 04:06:02 localhost kernel: EXT3-fs error (device ide0(3,70)):
ext3_readdir: directory #17205 contains a hole at offset 4096
Jul  1 04:06:02 localhost kernel: attempt to access beyond end of device
Jul  1 04:06:02 localhost kernel: 03:46: rw=0, want=362922408,
limit=6345643
Jul  1 04:06:02 localhost kernel: EXT3-fs error (device ide0(3,70)):
ext3_readdir: directory #17205 contains a hole at offset 8192

I was using linux-2.4.19-pre10-aa when I found these messages this
morning.

Thanx
	
   -- Bongani

