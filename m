Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263822AbTJEUer (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 16:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTJEUer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 16:34:47 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:42644 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S263822AbTJEUep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 16:34:45 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Rob Landley <rob@landley.net>,
       "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10310051303450.21746-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10310051303450.21746-100000@master.linux-ide.org>
Message-Id: <1065386079.3157.162.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Sun, 05 Oct 2003 21:34:40 +0100
X-SA-Exim-Mail-From: dwmw2@infradead.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-10-05 at 13:14 -0700, Andre Hedrick wrote:
> Regardless, nobody stopped him at that time and thus a right of way has
> been granted and can not be revoked.

Wrong. While Linus' statement does bar him from personally suing you, it
doesn't stop anyone else.

> See above, the boss changed the rules and nobody challanged it.

He did not have authority, by that time, to change the rules. Neither
was he unchallenged.

> Whatever happened to "World Domination" according to TUX ?
> Whatever happened to 'having a choice' ?

You do have a choice. You can use software under the terms of the
licence under which it's released, or you can choose not to use it.

> Lets assume you are correct, and the effect is a "Tar Baby".
> 
> Your claims that anything which loads into a kernel is automatically a
> derived work.  Thus the effect of an original work loading into a gpl work
> force the original work to be GPL.  This is a joke and will never see a
> second in any court.

You really aren't paying attention, are you? Your copyright (or lack of
it as a derivative work) on your own module is largely irrelevant to my
argument.

The GPL says you may use the kernel _itself_ but only with certain
restrictions.

My claim is that the GPL forbids you from loading a non-GPL'd module.
Not that if you do so, the non-GPL'd module becomes a derived work, but
that in doing do you are violating the licence under which you received
the _kernel_ and hence you must immediately cease using the _kernel_.

Just like if the GPL required you to bathe in creosote daily and one day
you forgot.

I repeat, for the hard of understanding:

I am not asserting that if you manage to produce a loadable module which
a court would rule is not a derivative work, you would not be allowed to
distribute that.

I am asserting that if you do so, you are disobeying the restrictions on
your use of the kernel itself, and hence you would not be able to use
the kernel. You could use your own module, but not the Linux kernel.

-- 
dwmw2


