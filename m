Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSEUTDY>; Tue, 21 May 2002 15:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315443AbSEUTDX>; Tue, 21 May 2002 15:03:23 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:1502 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S315449AbSEUTDW>;
	Tue, 21 May 2002 15:03:22 -0400
Date: Tue, 21 May 2002 22:03:22 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.5.17: ide & ext2 unresolved symbols in modules
Message-ID: <Pine.GSO.4.43.0205212200500.19324-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in /lib/modules/2.5.17/kernel/drivers/ide/ide-disk.o
depmod: 	udma_tcq_enable
depmod: *** Unresolved symbols in /lib/modules/2.5.17/kernel/drivers/ide/ide-mod.o
depmod: 	blk_get_request
depmod: *** Unresolved symbols in /lib/modules/2.5.17/kernel/fs/ext2/ext2.o
depmod: 	write_mapping_buffers

ide and ext2 are modules, tcq enabled.

-- 
Meelis Roos (mroos@linux.ee)

