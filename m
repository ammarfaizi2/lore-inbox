Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130348AbRBBWmB>; Fri, 2 Feb 2001 17:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130445AbRBBWlv>; Fri, 2 Feb 2001 17:41:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3593 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130348AbRBBWli>; Fri, 2 Feb 2001 17:41:38 -0500
Subject: Re: PROBLEM: 2.2.19pre7 opps on low mem machine
To: peter@runestig.com (Peter 'Luna' Runestig)
Date: Fri, 2 Feb 2001 22:42:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing list)
In-Reply-To: <003e01c08d68$fd5b53f0$0201010a@runestig.com> from "Peter 'Luna' Runestig" at Feb 02, 2001 11:39:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OouX-0007LG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, following the reiserfs/compiler thread, I can see now that my bug report
> may have been ignored since I was using a non-kosher compiler (although I
> have used it since late October -99 without any problems). Or, it might not
> have been ignored, just nobody told me he/she wasted some time on it. Since
> it seems to be hardware related; that oops wasn't the only one, and after
> some more strange behaviour, I moved the hard drive to another, almost
> identical, PC, with even less memory, 16 MB (but this one I have the chips
> to run 48 MB, but I wanted to stress it). And it's been running for a week
> now, like a clock.

Thanks for the info. I dont ignore gcc 2.95 stuff with 2.2 nowdays since Im
pretty sure 2.2 + gcc 2.95 is solid
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
