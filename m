Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270171AbRHMMrQ>; Mon, 13 Aug 2001 08:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270173AbRHMMrG>; Mon, 13 Aug 2001 08:47:06 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:55547 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S270171AbRHMMqz>; Mon, 13 Aug 2001 08:46:55 -0400
Message-Id: <5.1.0.14.2.20010813133901.02884c90@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 13 Aug 2001 13:47:02 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live!
  heads-up
Cc: rui.p.m.sousa@clix.pt, alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), pgallen@randomlogic.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <E15WGwB-0007Iq-00@the-village.bc.nu>
In-Reply-To: <no.id>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:35 13/08/01, Alan Cox wrote:
> > > It hung my SMP box solid
> > > It spews white noise on my box with surround speakers
> >
> > Digital or analog speakers?
>
>Analogue four output - I didnt know you had digital out working

Digital output on my SB Live! has been working since before the original 
emu10k1 driver went into the kernel if my memory hasn't flipped a few bits (-;

And the old driver worked absolutely fine for that matter on my Dual 
Celeron workstation...

Haven't tried the new 2.4.8 emu10k1 addition yet, and considering you are 
reporting it hangs on smp it's probably a waste of time except to confirm 
the hangs...

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

