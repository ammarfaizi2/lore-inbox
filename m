Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTLDGWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 01:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTLDGWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 01:22:42 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:5386 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262750AbTLDGWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 01:22:40 -0500
Date: Thu, 4 Dec 2003 14:24:41 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Matthias Andree <matthias.andree@gmx.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 future
In-Reply-To: <20031203150001.GA11687@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.33.0312041421140.12549-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.6, required 8, AWL,
	BAYES_10, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003, Matthias Andree wrote:

> On Wed, 03 Dec 2003, Ian Kent wrote:
>
> > > It's fragile currently, and if there are changes that make the beast
> > > solid, I'm all for it, and the whole discussion can be killed right here
> > > because it's a "bugfix" in that case. After all, autofs4 is a
> > > pre-something stuff and going "gold" is certainly a fix.
> >
> > And that would be 4.1.0-beta3 you are talking about right?
> > Perhaps you could tell me about your problems and I'll put them on my
> > growing todo list for 4.1.1.
>
> I'd need to find and evaluate your 4.1.0-beta works first. Oops, I've
> got it, I should look into
> http://www.de.kernel.org/pub/linux/daemons/autofs/v4/ :-)
>
> Being used to a different directory layout, I looked into the testing
> directories and didn't notice there was an actual 4.0.0 version. Wee.

The 4.0.0 release has only a few bug fixes and is not greatly different
from 4.0.0pre10.

Please use 4.1.0-beta3 unless it's 4.1.0 by the time you get it.

And we should end this off topic thread now I guess.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

