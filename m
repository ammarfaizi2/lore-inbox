Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbQKKQMY>; Sat, 11 Nov 2000 11:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131182AbQKKQMO>; Sat, 11 Nov 2000 11:12:14 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:61707 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131158AbQKKQMB>; Sat, 11 Nov 2000 11:12:01 -0500
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200011111605.RAA01615@kufel.dom>
Subject: Re: bzImage ~ 900K with i386 test11-pre2
To: kufel!transmeta.com!hpa@green.mif.pg.gda.pl (H. Peter Anvin)
Date: Sat, 11 Nov 2000 17:05:10 +0100 (CET)
Cc: kufel!bigfoot.com!maxinux@green.mif.pg.gda.pl (Max Inux),
        kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl
In-Reply-To: <3A0CB6FD.D4CCE09F@transmeta.com> from "H. Peter Anvin" at lis 10, 2000 07:03:25 
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Max Inux wrote:
> > On x86 machines there is a size limitation on booting.  Though I thought
> > it was 1024K as the max, 900K should be fine.
> 
> No, there isn't.  There used to be, but it has been fixed.
> 
> 	-hpa

Except the simple boot loader. You cannot boot kernel >=1024KB directly
from floppy...

Andrzej
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
