Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282867AbRLVWas>; Sat, 22 Dec 2001 17:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282862AbRLVWai>; Sat, 22 Dec 2001 17:30:38 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:29969 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S282914AbRLVWa2>;
	Sat, 22 Dec 2001 17:30:28 -0500
Date: Sat, 22 Dec 2001 19:36:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Frank Mehnert <fm3@os.inf.tu-dresden.de>, linux-kernel@vger.kernel.org
Subject: Re: Asynchronous Video =?iso-8859-1?Q?Cons?=
	=?iso-8859-1?Q?ole_f=FCr?= Linux?
Message-ID: <20011222193646.A227@elf.ucw.cz>
In-Reply-To: <20011218010300.B37@toy.ucw.cz> <E16HZuu-00025K-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16HZuu-00025K-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > are there exist any projects for connecting video consoles to the Linux
> > > kernel asynchronous? We would like to write a Linux video console for a
> > > (comparatively) slow device which is able to run simple console 
> > > applications upto the fbdev X-server.
> > > 
> > > Please cc your answer to me.
> > 
> > 	I do not know about any such project and yes it would be nice.
> > 
> > Its bad to see find / limited by vesafb speed...
> 
> There is no fundamental reason you cannot do this. For the kernel side the
> console driver in text mode already gives you the 80x25 + attributes image
> that you can use to do asynchronous video updates however your hardware
> works.

I never said it was hard to write... And it would make sun4 usable as
terminal, and would greatly help on vesafb machines.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
