Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbUJ0VIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbUJ0VIG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbUJ0VH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:07:26 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:207 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262729AbUJ0U5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:57:09 -0400
Date: Wed, 27 Oct 2004 22:56:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrea Arcangeli <andrea@novell.com>, Larry McVoy <lm@work.bitmover.com>,
       Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0410272049040.877@scrub.home>
References: <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>
 <20041023161253.GA17537@work.bitmover.com> <4d8e3fd304102403241e5a69a5@mail.gmail.com>
 <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com>
 <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random>
 <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random>
 <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random>
 <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org>
 <Pine.LNX.4.61.0410252350240.17266@scrub.home> <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org>
 <Pine.LNX.4.61.0410270223080.877@scrub.home> <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 26 Oct 2004, Linus Torvalds wrote:

> > Linus, what disturbs me here is that I don't see that you don't even try 
> > to acknowledge that the bk license might be part of problem
> 
> Why?

To answer that you should have quoted a bit more: "the annoying part are 
the business practices of its owner".

> What's the problem? You don't like it, you don't use it. It's literally 
> that simple.

Unfortunately it's not that easy, because you're still missing the point.
I don't care what software you use, I don't care what license Larry uses 
for its products. I absolutely don't care.
The problem is that you support a license which limits everyones ability 
on how to access the kernel source and gives Larry full control over it. 
Give me a good reason, why he can deny me that rather simple request to 
get some data out of the repository. On the one hand you blame Andrea for 
not developing an alternative, on the other hand we don't have access to 
the data to actually help other projects. The kernel source is the data 
that we care most about, why can Larry limit the ways we can make use of 
it?
Linus, what happened to the early promises, that the data wouldn't be 
locked into bk? Is the massively reduced data set in the cvs repository 
really all we ever get out of it again?

bye, Roman
