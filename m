Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262357AbSKCV6b>; Sun, 3 Nov 2002 16:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262363AbSKCV6b>; Sun, 3 Nov 2002 16:58:31 -0500
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:40455 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S262357AbSKCV63>; Sun, 3 Nov 2002 16:58:29 -0500
Message-Id: <200211032204.gA3M4vI24773@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
To: Jos Hulzink <josh@stack.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Petition against kernel configuration options madness...
Date: Sun, 3 Nov 2002 16:04:56 -0600
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200211031809.45079.josh@stack.nl> <20021103200704.A8377@ucw.cz> <200211032239.10843.josh@stack.nl>
In-Reply-To: <200211032239.10843.josh@stack.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 November 2002 03:39 pm, Jos Hulzink wrote:
> On Sunday 03 November 2002 20:07, Vojtech Pavlik wrote:
> > On Sun, Nov 03, 2002 at 12:52:48PM -0500, Jeff Garzik wrote:
> > > Unfortunately I don't have any concrete suggestions for Vojtech (input
> > > subsystem maintainer), just a request that it becomes easier and more
> > > obvious how to configure the keyboard and mouse that is found on > 90%
> > > of all Linux users computers [IMO]...
> >
> > Too bad you don't have any suggestions. I completely agree this should
> > be simplified, while I wouldn't be happy to lose the possibility of not
> > compiling AT keyboard support in.
>
> Something I have been thinking about for a while is a quick-config option
> (that sets some defaults that hold for 90% of the systems), or an expert
> mode that shows extra options. Though I understand that this is hard to do,
> and much hardware differs, I think it can be done for some basics like
> keyboard, mouse, USB and stuff.

I like this idea!

> Yes, this will cause your kernel to be bigger than optimal, for some
> drivers will be compiled in that are not used on your system. But if you
> want you can optimize things away after clicking <set defaults for standard
> IBM PC>.

How about running the "quick config", which I can then use a base to 
customize?

> If this idea is not blown away immediately, I'm willing to work this idea
> out a little, though I can understand that people call me an idiot...

Not at all!

-Nick
