Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTLXCSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 21:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTLXCSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 21:18:07 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:1804 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263205AbTLXCSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 21:18:02 -0500
Date: Wed, 24 Dec 2003 10:21:20 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Rob Love <rml@ximian.com>
cc: Greg KH <greg@kroah.com>, <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DevFS vs. udev
In-Reply-To: <1072231437.3826.3.camel@fur>
Message-ID: <Pine.LNX.4.33.0312241012460.890-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.5, required 8, AWL,
	BAYES_10, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003, Rob Love wrote:

> On Tue, 2003-12-23 at 20:52, Ian Kent wrote:
>
> > It certainly seems like a good project for a someone, such as myself, that
> > is new to kernel development.
>
> Please take no offense to this, but it is an awful project for someone
> new to kernel development.  Plenty of knowledgeable/semi-knowledgeable
> kernel hackers looked at devfs and given up on it.  Despite what some
> people say about Richard, he is a good guy, and he did not succeed
> either.

None taken.

I understand your view but my point here (at this stage) is not
necessarily to revive devfs development but to provide some maintenance
only support for those that need it during the (what appears to be
inevitable) transition. In particular, keeping it around while people
still need it.

>
> devfs is hard to get right and, worse, you will be starting with a bad
> base of code that I would not want to touch with an 18.72 foot pole.
>
> Greg, via udev, has made it so easy to just back up, slowly, and walk
> away from devfs.  devfs is not going anywhere in 2.6, I do not think,
> but let sleeping piles of crap sleep and let's just jettison this thing
> as soon as we can.

Ohh! Nasty pastie.

>
> Just my two cents - I am warning you ;)

My mother always said I was deaf.

Ian


