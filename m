Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270375AbTGWPdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 11:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270382AbTGWPdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 11:33:49 -0400
Received: from co239024-a.almel1.ov.home.nl ([217.120.226.100]:61057 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270375AbTGWPdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 11:33:45 -0400
Date: Wed, 23 Jul 2003 17:46:21 +0200 (CEST)
From: Aschwin Marsman <a.marsman@aYniK.com>
X-X-Sender: marsman@localhost.localdomain
To: John Bradford <john@grabjohn.com>
cc: root@mauve.demon.co.uk, <alan@lxorguk.ukuu.org.uk>, <davem@redhat.com>,
       <herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre7: are security issues solved?
In-Reply-To: <200307231408.h6NE8vCV000217@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0307231744480.1825-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003, John Bradford wrote:

> > > > > If I know your password is 7 characters I have a smaller
> > > > > space of passwords to search to just brute-force it.
> > > >
> > > > It's much smaller if you didn't know that it was at most 7 characters
> > > > long.  However, if you did know the upper bound, or you were just
> > > > brute forcing all passwords starting from 1 character, then the
> > > > difference is relatively minor.  This is because
> > <snip>
> > > One time passwords are much more secure.
> >
> > Nope.
> > Changing password to a password of similar complexity every 10 seconds
> > doesn't make it much less likely to be guessed than a static password.
> 
> For the attack in question, it does, as long as no two consecutive
> passwords have the same number of characters.
> 
> For example, if the list of OTPs is:
> 
> alpha
> beta
> epsilon
> 
> The user logs in using the first password, and somebody logs that it
> has five characters.  The next valid password, (the only valid one),
> has four.

And what if we forget using passwords and use a physical device, a smart
card e.g. like SUN is using to get acces to your desktop all over the
world? Is there support for Linux for an application like that?
 
> John.

Have fun,
 
Aschwin Marsman
 
--
aYniK Software Solutions         all You need is Knowledge
P.O. box 134                     NL-7600 AC Almelo - the Netherlands
a.marsman@aYniK.com              http://www.aYniK.com

