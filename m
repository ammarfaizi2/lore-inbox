Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317540AbSG2Rnh>; Mon, 29 Jul 2002 13:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317567AbSG2Rnh>; Mon, 29 Jul 2002 13:43:37 -0400
Received: from [195.39.17.254] ([195.39.17.254]:11904 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317540AbSG2Rnf>;
	Mon, 29 Jul 2002 13:43:35 -0400
Date: Mon, 29 Jul 2002 17:47:34 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Rodland <arodland@noln.com>
Cc: "David D. Hagood" <wowbagger@sktc.net>, linux-kernel@vger.kernel.org
Subject: Re: Speaker twiddling [was: Re: Panicking in morse code]
Message-ID: <20020729174734.B38@toy.ucw.cz>
References: <20020727000005.54da5431.arodland@noln.com> <200207270526.g6R5Qw942780@saturn.cs.uml.edu> <20020727015703.21f47a37.arodland@noln.com> <3D4298C6.9080103@sktc.net> <20020727114509.0a1eee2a.arodland@noln.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020727114509.0a1eee2a.arodland@noln.com>; from arodland@noln.com on Sat, Jul 27, 2002 at 11:45:09AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I don't understand the direction this discussion is taking.
> > 
> > Either you are trying to output the panic information with minimal 
> > hardware, and in a form a human might be able to decode, in which case
> > the Morse option seems to me to be the best, or you are trying to
> > panic in a machine readable format - in which case just dump the data
> > out /dev/ttyS0 and be done with it!
> > 
> > To my way of thinking, the idea of the Morse option is that if an oops
> > 
> > happens when you are not expecting it, and you haven't set up any 
> > equipment to help you, you still have a shot at getting the data.
> 
> 
> To my way of thinking, this is still 'minimal' -- it's just a different
> minimum.
> 
> It's the 'minimum' way to get the panic message out digitally, in such
> a way that I might be able to recover it using a tape recorder or a
> telephone. Actually, morse is probably that, but morse loses data and
> doesn't have any redundancy.

You don't need redundancy. You should just repeat message over and over
and over and over and....

If you don't want morse to loose data, invent new codes for different
parenthesis etc.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

