Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbTCLWxv>; Wed, 12 Mar 2003 17:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262083AbTCLWwH>; Wed, 12 Mar 2003 17:52:07 -0500
Received: from [195.39.17.254] ([195.39.17.254]:19204 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262084AbTCLWvE>;
	Wed, 12 Mar 2003 17:51:04 -0500
Date: Wed, 12 Mar 2003 18:27:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
Message-ID: <20030312172706.GA5489@zaurus.ucw.cz>
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv> <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com> <20030307233916.Q17492@flint.arm.linux.org.uk> <3E692EE4.9020905@zytor.com> <Pine.LNX.4.44.0303080116500.32518-100000@serv> <3E693D65.8060308@zytor.com> <Pine.LNX.4.44.0303080208340.32518-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303080208340.32518-100000@serv>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > b) I will personally go batty if I ever have to create yet another
> > implementation of printf() and the few other things in klibc that is
> > anything other than a thin shim over the kernel interface.  The bottom
> > line is that klibc is so Linux-specific, that the only way someone would
> > "steal" code from it is because they want a specific subroutine
> > somewhere, and as far as I'm concerned, they can have it, and I don't
> > care in the slightest for what project.
> 
> Why do you make this decision for everyone?
> If I wanted to use *BSD I would use it. The point of using Linux and 
> the GPL is that we at least attempt to protect the source to keep it free 
> and any contribution should be given the same respect. You insist on using 

I believe HPA wants klibc to stay small,
and BSD license will act as contribution-
stopper, therefore keeping it small...

				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

