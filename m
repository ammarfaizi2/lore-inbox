Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbTBOTSR>; Sat, 15 Feb 2003 14:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbTBOTSR>; Sat, 15 Feb 2003 14:18:17 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:8967 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265099AbTBOTRS>; Sat, 15 Feb 2003 14:17:18 -0500
Subject: Re: PATCH: high pedantry in ARM spelling
From: Steven Cole <elenstev@mesatop.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E18k7f0-0007GS-00@the-village.bc.nu>
References: <E18k7f0-0007GS-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 15 Feb 2003 12:18:58 -0700
Message-Id: <1045336740.5611.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-15 at 12:07, Alan Cox wrote:
> One erratum
> Two errata
> 
> Alan
> --
>                 Dim rhyfel mewn ein enw ni
> 

Meanwhile, over in ppc-land:

Steven
Striving to reduce the size of the kernel source one byte at a time.

--- linux-2.5.61/arch/ppc/kernel/head.S.orig	Sat Feb 15 12:09:39 2003
+++ linux-2.5.61/arch/ppc/kernel/head.S	Sat Feb 15 12:10:22 2003
@@ -1337,7 +1337,7 @@
 	blr
 
 /* 7400 <= rev 2.7 and 7410 rev = 1.0 suffer from some
- * erratas we work around here.
+ * errata we work around here.
  * Moto MPC710CE.pdf describes them, those are errata
  * #3, #4 and #5
  * Note that we assume the firmware didn't choose to
 


