Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129279AbRBHCpQ>; Wed, 7 Feb 2001 21:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129578AbRBHCo4>; Wed, 7 Feb 2001 21:44:56 -0500
Received: from 24.68.117.103.on.wave.home.com ([24.68.117.103]:8576 "EHLO
	cs865114-a.amp.dhs.org") by vger.kernel.org with ESMTP
	id <S129279AbRBHCos>; Wed, 7 Feb 2001 21:44:48 -0500
Date: Wed, 7 Feb 2001 21:44:35 -0500 (EST)
From: Arthur Pedyczak <arthur-p@home.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Oopses in 2.4.1  (lots of them)
In-Reply-To: <E14QZRU-0000xJ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0102072138170.1255-100000@cs865114-a.amp.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, Alan Cox wrote:

> > am not sure how to eliminate or confirm this. Recently I added some RAM
> > (256->384) and decided to get rid of swap. This seemed to have destabilized
> > the system, although nothing is obvious. I can try to stress the system by
>
> Get a copy of memtest86, its a standalone memory tester.
>
Alan, Linus,

Thanks for your help. I ran memtest86 for 6 hrs. RAM looks
O.K.. I added swap back (just in case). Now I will be eliminating
suspicious kernel modules one by one.
Will post results in few days.
Cheers!

Arthur

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
