Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269036AbTGZTIb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 15:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269131AbTGZTIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 15:08:31 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:54704 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S269036AbTGZTI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 15:08:29 -0400
Date: Sat, 26 Jul 2003 12:23:22 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@redhat.com>
Cc: Larry McVoy <lm@bitmover.com>,
       Leandro Guimar?es Faria Corsetti Dutra 
	<lgcdutra@terra.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Switching to the OSL License, in a dual way.
Message-ID: <20030726192322.GA24865@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@redhat.com>, Larry McVoy <lm@bitmover.com>,
	Leandro Guimar?es Faria Corsetti Dutra <lgcdutra@terra.com.br>,
	linux-kernel@vger.kernel.org
References: <20030724215744.GA7777@work.bitmover.com> <Pine.LNX.4.44.0307261508400.10872-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307261508400.10872-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 03:10:28PM -0400, Rik van Riel wrote:
> On Thu, 24 Jul 2003, Larry McVoy wrote:
> 
> > A clone is illegal because you'd have to reverse engineer to do the
> > clone and reverse engineering is allowed for the purpose of
> > interoperability, not for the purpose of making a clone.
> 
> This is a good point to remember, especially since you
> contradict it later on in your own mail.
> 
> Making a program to extract data from a bitkeeper
> repository is fine. It is covered by this interoperability
> clause.
> 
> What is arguably (not) fine is making a program that does
> everything bitkeeper does and does it in the same way, ie.
> creating a bitkeeper clone.
> 
> However, that has nothing to do with a program that can
> extract data from a bitkeeper repository but quite clearly
> isn't a bitkeeper clone...

I can't tell if we are in agreement or not.  As far as I've been
able to tell disallowing reverse engineering is not allowed in some
countries if and only if the application does not provide documented
ways to interoperate with the application.  People have tried to claim
otherwise but every time we've dug into we've found the laws to be pretty
reasonable and balanced.  They tend to have the view "if you are being
a jerk and locking people into your application with no way to get at
their data, then of course reverse engineering is allowed, how else are
people to get at their data?  On the other hand, if you are being nice
and you provide documented ways for people to get at their data then
reverse engineering is not allowed".  Which seems to make sense, right?
If corporations aren't trying to lock you into their products then they
ought to be able to enjoy some fruits from their labors without people
coping their work.  On the other hand, if corporations are abusing their
position then that protection goes away.

So far, nobody has come forward with a substantable claim that in their
country you can reverse engineer anything you want for any reason you
want with impunity.  

Maybe there is one but I haven't seen it yet.

Furthermore, this is all a moot point.  We're constantly evolving the
product -- for technical reasons -- and any clone is just going to be
stuck in a catchup game, much like clones of Word are stuck.  If a 
bunch of people think they can do better than us, more power to them,
as long as they do it legally.  I know that if I were on the other side
of the fence, I'd look at the problems BK was solving and try very hard
to not look at how BK is solving them - in fact, this is exactly what we
do with our competitors.  We compete primarily with ClearCase and I have
never run ClearCase, not even once.  There is too much of a chance that
they have a patent on something, or a patent coming, and we don't want
to take the same path they did so we are more likely to avoid the patent
problems.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
