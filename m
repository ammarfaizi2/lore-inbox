Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290314AbSAPBK1>; Tue, 15 Jan 2002 20:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290316AbSAPBKR>; Tue, 15 Jan 2002 20:10:17 -0500
Received: from [203.94.130.164] ([203.94.130.164]:34578 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S290314AbSAPBKD>;
	Tue, 15 Jan 2002 20:10:03 -0500
Date: Wed, 16 Jan 2002 12:25:56 +1100 (EST)
From: brett@bad-sports.com
To: linux-kernel@vger.kernel.org
Subject: more unresolved symbols in 2.4.18-pre4
Message-ID: <Pine.LNX.4.40.0201161224250.21260-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

One was already reported, but have some more :)

depmod: *** Unresolved symbols in /lib/modules/2.4.18-pre4/kernel/drivers/char/drm/sis.o
depmod: 	sis_malloc_Ra3329ed5
depmod: 	sis_free_Rced25333
depmod: *** Unresolved symbols in /lib/modules/2.4.18-pre4/kernel/fs/minix/minix.o
depmod: 	waitfor_one_page
depmod: *** Unresolved symbols in /lib/modules/2.4.18-pre4/kernel/fs/sysv/sysv.o
depmod: 	waitfor_one_page

thanks,

	/ Brett

