Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVKUTYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVKUTYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVKUTYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:24:42 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6556 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932078AbVKUTYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:24:42 -0500
Date: Mon, 21 Nov 2005 20:24:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Message-ID: <20051121192431.GJ29518@elf.ucw.cz>
References: <200511170629.42389.rob@landley.net> <200511211150.17271.rob@landley.net> <20051121182800.GE29518@elf.ucw.cz> <200511211253.40212.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511211253.40212.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > How is it supposed to work with cross-compiling.
> > >
> > > That's why I gave the User Mode Linux example in the documentation, which
> > > specifies an architecture.  (And in take 2, I added an example of running
> > > the makemini.sh script for UML, where you have to specify ARCH=um as an
> > > environment variable.)
> > >
> > > If there's more to cross-compiling than that, please tell me and I'll
> > > work it in.  (I know you have to specify a cross toolchain, but I didn't
> > > think that affected the configure step...)
> >
> > I probably miss-patched my kernel, sorry. Not sure what you have to do
> > to change permissions, probably mail it to akpm and ask him to add +x
> >
> > :-).
> 
> I'm hoping to get an ack from the kconfig guys first, hence the cc:
> 
> But does it work ok for you?

I was not even able to patch it properly :-(. Version against current
-git would be handy.
								Pavel
-- 
Thanks, Sharp!
