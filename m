Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269421AbRHLUbu>; Sun, 12 Aug 2001 16:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269423AbRHLUbl>; Sun, 12 Aug 2001 16:31:41 -0400
Received: from srvr2.telecom.lt ([212.59.0.1]:47119 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S269421AbRHLUbg>;
	Sun, 12 Aug 2001 16:31:36 -0400
Message-Id: <200108122031.WAA1566356@mail.takas.lt>
Date: Sun, 12 Aug 2001 22:30:39 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rui Sousa <rui.p.m.sousa@clix.pt>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <E15W1eR-000691-00@the-village.bc.nu>
In-Reply-To: <E15W1eR-000691-00@the-village.bc.nu>
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.4.7 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AC> Yep. So far the new driver that Linus took from a non maintaier breaks
AC> 
AC>         SMP
AC>         Some mixers
AC>         Uniprocessor with some cards
AC>         Surround sound (spews noise on cards)
AC> 
AC> so I think Linus should do the only sane thing - back it out. I'm backing
AC> it out of -ac. Of my three boxes, one spews noise, one locks up smp and
AC> one works.

But later there was a patch from maintainer (Rui Sousa). Besides, there were no
updates from maintainers for over a year, so I think "non maintainer" did a good
thing - at least maintainers started to send patches finally. Instead of backing out
I suggest for maintainers to send more patches...

Regards,
Nerijus


