Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268278AbUIFQak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268278AbUIFQak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 12:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268285AbUIFQak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 12:30:40 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:5527 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S268278AbUIFQae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 12:30:34 -0400
Subject: Re: [Transmeta hardware] Update of the CMS under Linux ?
From: Emmanuel Fleury <fleury@cs.aau.dk>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: Linux Kernel Mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <chhs8o$rtd$1@sea.gmane.org>
References: <1093165082.11189.20.camel@aphrodite.olympus.net>
	 <ch8lop$m3t$1@sea.gmane.org> <1094457952.22441.34.camel@rade7.e.cs.auc.dk>
	 <chhs8o$rtd$1@sea.gmane.org>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1094487031.4125.30.camel@rade7.e.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 06 Sep 2004 18:10:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-06 at 16:29, Kalin KOZHUHAROV wrote:
> 
> > I have no idea if it is legal or not... it is not my concern now. 
> ... how legal is it?

I am not a lawyer... :)

Just an unsatisfied customer who try to use properly a piece of hardware
that I own because I paid for it... Am I a criminal because of this ???

> > I'm just seeking for solutions ! :)
> > I guess it depends if you are in the States or in Europe.
> or Japan.

Right. I forgot Japan, of course.

> I don't have X on this laptop, but I'll put tonight.

It would be very interesting to know if you encounter this bug.
This bug has never been reported on a Toshiba Libretto.

> Actually, I was given this laptop after a few major falls (and a hard kick!),
> so it is barely mobile, strapped/fixed to a metal board and used mainly via ssh.
> 
> I had some nasty bug appearing every couple of days without any trace left with linux-2.6.3
> (machine stays on, but no reaction to KBD, network, USB, etc; nothing in the logs, on hte screen, no beeps).
> But now with 2.6.8.1 I have 15d uptime :-)

This bug is know to appear more often on X, but it might appear in some
other places and not having being noticed yet... We don't know...

> If you get closer to a smaller (than X running) testcase, post it here, 
> so other people (and me) can try easily.

I will, but just right now I don't have much time to spend on it, but my
next goal is to identify a way to reproduce it (not an easy task I'm
afraid). So, I will keep people informed.

> I'd be happy to switch a few (fast) CPUs from SETI@Home to Transmeta@Home if not illegal :-)

Well, we should first find where is the bug. ;-)

But, we already have the assembly code of the CMS 4.4 thanks to the HP
tablet-PC update (see:
http://h18007.www1.hp.com/support/files/compaqtabletpc/us/download/18120.html).

So, if some people are interested by this project of
CrackingTransmeta@Home, be my guest. :-)

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.aau.dk

