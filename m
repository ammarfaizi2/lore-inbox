Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLWLtx>; Sat, 23 Dec 2000 06:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbQLWLtm>; Sat, 23 Dec 2000 06:49:42 -0500
Received: from [203.36.158.121] ([203.36.158.121]:14721 "HELO kabuki.eyep.net")
	by vger.kernel.org with SMTP id <S129406AbQLWLtj>;
	Sat, 23 Dec 2000 06:49:39 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: test13-pre4-ac2 - part of diff fails 
In-Reply-To: Your message of "Sat, 23 Dec 2000 10:25:46 BST."
             <E149ls4-0005x3-00@the-village.bc.nu> 
In-Reply-To: <E149ls4-0005x3-00@the-village.bc.nu> 
Date: Sat, 23 Dec 2000 22:21:29 +1100
From: Daniel Stone <daniel@kabuki.eyep.net>
Message-Id: <20001223114939Z129406-439+5852@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > patching file arch/i386/kernel/smp.c
> > Reversed (or previously applied) patch detected!  Assume -R? [n] 
> > Apply anyway? [n] y
> > Hunk #1 FAILED at 278.
> > Hunk #2 succeeded at 511 (offset 9 lines).
> > 1 out of 2 hunks FAILED -- saving rejects to file arch/i386/kernel/smp.c.rej
> > 
> > Works fine if I reverse it and then put it back in. ?
> 
> Its a bug in my patch - get 13pre4ac2 ..

Um.
Subject: Re: test13-pre4-ac2 - part of diff fails
It's _IN_ 13-4ac2.
d
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
