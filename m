Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTLKV24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 16:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbTLKV24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 16:28:56 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:3596 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263178AbTLKV2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 16:28:54 -0500
Date: Thu, 11 Dec 2003 13:20:48 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Rob Landley <rob@landley.net>
cc: hzhong@cisco.com, "'Larry McVoy'" <lm@bitmover.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       "'Kendall Bennett'" <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <200312110237.42998.rob@landley.net>
Message-ID: <Pine.LNX.4.10.10312111318300.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rob,

Help me out?  Who is cloning what ?

I am talking about original works, to talking about talking somebody's
stuff out of the kernel, hacking it up and distributing the work as an
original (that is clearly a derived work).

So your arguement is bogus, try again.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Thu, 11 Dec 2003, Rob Landley wrote:

> On Thursday 11 December 2003 02:11, Hua Zhong wrote:
> > > For one thing, the plugin was made by someone without access
> > > to Netscape or IE's source code, using a documented interface
> > > that contained sufficient information to do the job without access
> > > to that source code.
> > >
> > > Yes, it matters.
> >
> > _What_ matters?
> >
> > Open source? (if you write a plugin for an opensource
> > kernel/application, you are not plugin anymore and you are derived
> > work.) I am sure you don't mean it.
> >
> > Documented interface? Hey, there are sources which are the best
> > documentation. :-)
> 
> If you write software by referring to documentation, the barrier for it being 
> a derivative work is higher than if you write it by looking at another 
> implementation.
> 
> > Seriously, even if I accept that there is never an intent to support a
> > stable ABI for kernel modules, some vendor can easily claim that "we
> > support a stable ABI, so write kernel modules for the kernel we
> > distribute".
> >
> > Anything can prevent that? I cannot see GPL disallow it.
> >
> > So OK, Linus and other kernel developers never intended to provide a
> > stable ABI, but someone else could. The original author's intent is
> > never relevant anymore. This is the goodness of opensource, isn't it?
> 
> Once upon a time, Compaq did a clean-room clone of IBM's BIOS.  Group 1 
> studied the original bios and wrote up a spec, and group 2 wrote a new bios 
> from that spec, and group 1 never spoke to group 2, and all of this was 
> extensively documented so that when IBM sued them they proved in court that 
> their BIOS wasn't derived from IBM's.  (Of course compaq used vigin 
> programmers fresh out of college who'd never seen a PC before, which was a 
> lot easier to do in 1983...)
> 
> I didn't make this up.  This was a really big deal 20 years ago.  It happened, 
> and it mattered, and people cared that they created a fresh implementation 
> without seeing the original code, entirely from a written specification that 
> was not a derivative work of the first implementation, so no matter how 
> similar the second implementation was (hand-coded assembly performing the 
> same functions on the same processor in the same amount of space), it could 
> not be considered a derivative work.
> 
> This was a strong enough defense to beat IBM's lawyers, who were trying to 
> claim that Compaq's new BIOS WAS a derivative work...
> 
> Rob
> 

