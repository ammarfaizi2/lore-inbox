Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281876AbRKSBxq>; Sun, 18 Nov 2001 20:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281875AbRKSBxg>; Sun, 18 Nov 2001 20:53:36 -0500
Received: from [202.9.186.134] ([202.9.186.134]:2308 "EHLO jefspc.mss")
	by vger.kernel.org with ESMTP id <S281872AbRKSBxb>;
	Sun, 18 Nov 2001 20:53:31 -0500
From: Jeffrin <jeffrin@msservices.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15352.6424.786079.47914@jeffrin@msservices.org>
Date: Mon, 19 Nov 2001 01:54:56 +0530
To: linux-kernel@vger.kernel.org
Subject: Compilation related
X-Mailer: VM 6.97 under Emacs 21.0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I tried to do a typical compilation of 2.4.14 related kernel
but compilation stops.


drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0xa86f): undefined reference to
`deactivate_page'
drivers/block/block.o(.text+0xa8b9): undefined reference to
`deactivate_page'
make: *** [vmlinux] Error 1

 
-- 
Jeffrin Jose T.
www.MSServices.org
GPG:1024D/F5726A1B
