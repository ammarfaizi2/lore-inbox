Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130746AbQK1EYY>; Mon, 27 Nov 2000 23:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130810AbQK1EYN>; Mon, 27 Nov 2000 23:24:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14354 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S130746AbQK1EYA>; Mon, 27 Nov 2000 23:24:00 -0500
Subject: Re: test12-pre2
To: neilb@cse.unsw.edu.au (Neil Brown)
Date: Tue, 28 Nov 2000 03:53:45 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <14883.10909.19147.677679@notabene.cse.unsw.edu.au> from "Neil Brown" at Nov 28, 2000 02:46:37 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140bpy-00041f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Due to the birth of my third daughter last week (yes, I got /.'ed), if you
> > sent me patches that aren't in pre2, you can pretty much consider them
> > lost.
> > 
> > 		Linus
> > 
> 
> What happens about the stuff that went in to 2.4.0test11-ac{1,2,3,4}?
> Are you going to "sync-up" with Alan, or should we send bits directly
> to you?

When Linus puts out pre3 I will start sending him stuff from my tree which
proves workable. Stuff that seems suspect and needs more work I'll keep in
the -ac tree and continue to release it against current Linus code. 

It doesnt cause me any problem if you send Linus a copy, I'll just drop it
from my patches as it appears in his tree.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
