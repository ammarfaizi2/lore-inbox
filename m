Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbTIOPgk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 11:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTIOPgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 11:36:40 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:48879 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S261437AbTIOPgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 11:36:37 -0400
Subject: RE: People, not GPL  [was: Re: Driver Model]
From: Martin Schlemmer <azarah@gentoo.org>
To: David Schwartz <davids@webmaster.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pascal Schmidt <der.eremit@email.de>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEGJGIAA.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKMEGJGIAA.davids@webmaster.com>
Content-Type: text/plain
Message-Id: <1063639582.3320.28.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 15 Sep 2003 17:26:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-09-14 at 00:30, David Schwartz wrote:

This is starting to get one of those threads that really
should have ended a _long_ time ago.

> 
> > > 	If it has legal value, then it's an additional restriction.
> 
> > If it has legal value in showing the work is derivative thats not an
> > additional restriction.
> 
> 	If the work would not have been restricted without it and is restricted
> with it and you can't remove it, it's an additional restriction. If not,
> what would an additional restriction be?
> 

Read further on - it in itself is not a legal issue as such.

> > Its merely showing the intent of the author.
> 
> 	The intent of the author has no bearing on whether or not a work is
> derived.
> 

If you read the ending part of Alan's message, you will see where
this fits into.  Removing it, once again do not have any real
legal value while still within GPL 'usage boundaries'.

If the party that is accused of breaching GPL however did also
remove the GPL_ONLY symbols, it does once again have no legal
implication, except maybe enforcing a case of 'look, his intent
was from day one to breach GPL'.  It is however not binding
legally, and its worth will depend on the country, legal system
and so on.

> > If
> > someone creates a work and its found to be derivative and they didnt
> > make it GPL compatible they get sued, thats also not an additional
> > restriction its what the GPL says anyway.
> 
> 	Show me where the GPL says you have to GPL derived works that you don't
> distribute. That restriction is found nowhere in the GPL and if you
> attempted to impose such a restriction, it would be an additional one.
> 

I do not see why point you want to make.  If you do _NOT_ distribute
modified versions of the kernel, or works based on it, wtf worry ?
If you however do (hello, driver derived from kernel source/examples,
etc), you are bound by GPL (section 2a) to also distribute it under
GPL, and thus also the sources, which is exactly what manufactures
doing binary only drivers do not do.

> > That is the whole point of EXPORT_SYMBOL_GPL, it doesn't enforce
> > anything and Linus was absolutely specific it should not do the
> > enforcing. Its a hint and a support filter.
> 
> 	If it doesn't enforce anything and isn't a license restriction, then it's
> perfectly legal and kosher to remove it.
> 

Yes, didn't Alan just say it does not enforce anything?

What it does though do, what the whole idea behind it is, is if
party A, say do a binary driver, and they changed EXPORT_SYMBOL_GPL
to EXPORT_SYMBOL, then the kernel devs will _not_ support party A,
as Alan said with 'Its a hint and a support filter.'.  Sure, you
are free to remove it, but if you do, do not expect any support.

The company I work for is a supplier of PC components.  We have
the same type of support 'safety system' build in - we do not have
the infrastructure to support the public masses, thus we sell at
low prices to vendors that have a much higher markup, and good
support.  If then somebody come to us, that is not a dealer, or
do not have an Invoice, sorry sir, go to who you bought it from.
Its basically the same thing if you think about it.

Can we now stop this, or could you continue this in private if
you still choose not to understand?


Thanks,

-- 
Martin Schlemmer


