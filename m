Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262075AbREPUCJ>; Wed, 16 May 2001 16:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262083AbREPUB7>; Wed, 16 May 2001 16:01:59 -0400
Received: from [136.159.55.21] ([136.159.55.21]:56991 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262063AbREPUBw>; Wed, 16 May 2001 16:01:52 -0400
Date: Wed, 16 May 2001 14:01:08 -0600
Message-Id: <200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B02D6AB.E381D317@transmeta.com>
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg>
	<200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca>
	<3B02D6AB.E381D317@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Richard Gooch wrote:
> > Argh! What I wrote in text is what I meant to say. The code didn't
> > match. No wonder people seemed to be missing the point. So the line of
> > code I actually meant was:
> >         if (strcmp (buffer + len - 3, "/cd") != 0) {
> 
> This is still a really bad idea.  You don't want to tie this kind of
> things to the name.

Why do you think it's a bad idea?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
