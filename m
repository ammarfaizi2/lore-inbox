Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKDRpa>; Sat, 4 Nov 2000 12:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129095AbQKDRpK>; Sat, 4 Nov 2000 12:45:10 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:47885 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129057AbQKDRpE>; Sat, 4 Nov 2000 12:45:04 -0500
Date: 04 Nov 2000 13:37:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7pChuFhmw-B@khms.westfalen.de>
In-Reply-To: <E13rRk1-0001ut-00@the-village.bc.nu>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3A01D6D1.44BD66FE@Rikers.org> <E13rRk1-0001ut-00@the-village.bc.nu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk (Alan Cox)  wrote on 02.11.00 in <E13rRk1-0001ut-00@the-village.bc.nu>:

> > How can I insure that the largest possible amount of my efforts benefit
> > the community at large? Hopefully this will make it easier to move to
> > C99 or any other future compiler porting project.
>
> The asm I dont know - its a hard problem.

Anyone interested in looking at the asm problem, the Free Pascal Compiler  
(GPL) seems to be able to read several different Pascal inline asm  
variants and translate them into several different output asm variants,  
but only for Intel code. That should at least give some hints about the  
problem.

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
