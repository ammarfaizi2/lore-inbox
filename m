Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSEFC2C>; Sun, 5 May 2002 22:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSEFC2B>; Sun, 5 May 2002 22:28:01 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:61188 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S314068AbSEFC2A>;
	Sun, 5 May 2002 22:28:00 -0400
Message-Id: <200205060132.g461WK0M005770@sleipnir.valparaiso.cl>
To: Chris Rankin <cj.rankin@ntlworld.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18 floppy driver EATS floppies 
In-Reply-To: Your message of "Sun, 05 May 2002 15:47:06 BST."
             <200205051447.g45El62s000615@twopit.underworld> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sun, 05 May 2002 21:32:20 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Rankin <cj.rankin@ntlworld.com> said:
> "Sebastian Szonyi" at May 05, 2002 04:58:50 PM
> > I buyed once (a long time ago) a box with 10 floppies.
> > Two died in the first day of use. From the others i still have some today.
> > 
> > I think the quality of the floppies (and other products) today isn't so
> > high :-(
> 
> Well, that's one explanation. Curiously, I've just managed to salvage
> my floppy disk. My initial attempt to run either "mkfs -t vfat" or "dd
> if=mini.ima of=/dev/fd0" failed, so I ran "mkfs -t ext2" instead. Once
> that ran successfully, I was able to dd the image again, and this time
> it worked.

That cleaned the heads, and now it works. Happened to me too on the (little
used) fd of my notebook.
--
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
