Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270519AbTGXOx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 10:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271156AbTGXOxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 10:53:55 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:55741 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S270519AbTGXOxy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 10:53:54 -0400
Date: Thu, 24 Jul 2003 08:08:41 -0700
From: Larry McVoy <lm@bitmover.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Diego Calleja Garc?a <diegocg@teleline.es>,
       Michael Bernstein <michael@seven-angels.net>, gmicsko@szintezis.hu,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: SCO offers UnixWare licenses for Linux
Message-ID: <20030724150841.GA12647@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Diego Calleja Garc?a <diegocg@teleline.es>,
	Michael Bernstein <michael@seven-angels.net>, gmicsko@szintezis.hu,
	LKML <linux-kernel@vger.kernel.org>
References: <1058807414.513.4.camel@sunshine> <141DFFFA-BBA4-11D7-A61F-000A95773C00@seven-angels.net> <20030721205940.7190f845.diegocg@teleline.es> <1059058329.957.11.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059058329.957.11.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 04:52:09PM +0200, Felipe Alfaro Solana wrote:
> On Mon, 2003-07-21 at 20:59, Diego Calleja Garc?a wrote:
> > El Mon, 21 Jul 2003 13:52:21 -0400 Michael Bernstein <michael@seven-angels.net> escribi?:
> > 
> > > To put it simply, just because they "may,"  - and I say may here simply 
> > > because we have no evidence to prove their claims but cannot flatly 
> > > deny them - own the rights to Sys V, does NOT mean they own the right 
> > 
> > So they want to sell us something that still hasn't proved....cool.
> 
> And can be rewritten from scratch if necessary... They're crazy!

There seems to be a prevailing opinion that if there is stolen code in
Linux that came from SCO owned code that all that needs to be done is
to remove it and everything is fine.  I don't think it works that way.
If code was stolen and the fact that it is in Linux helped destroy
SCO's business then SCO has the right to try and get damages.  I.e.,
Linux damaged SCO by using the code.

It's also not a simple case of rewriting.  _Assuming_ that there was
something significant in Linux which came from SCO, i.e., they can make
the case that the Linux community wouldn't have thought of it on their
own, then you don't get to rewrite it because now you know how whatever
"it" is works and you didn't before.

The business world takes their IP seriously.  If, and it is a big if,
there is code in Linux from SCO, that's going to be a nasty mess to
clean up and we had better all pray that IBM just buys them and puts
Unix into the public domain.  Otherwise I think SCO could force Linux
backwards to whereever it was before the tainted code came in.  If that
happens, I (and I suspect a lot of you) will work to make sure that 
things which couldn't possibly be tainted (like drivers) do make it 
forward.

If SCO prevails it won't be the end of the world.  A lot of that scalability
stuff is just a waste of time, IMO.  32 processor systems are dinosaurs that
are going away and I'm not the only one who thinks so, Dell and IDC agree:

	http://news.com.com/2100-1010_3-1027556.html

Don't get me wrong, there are some cool things in 2.5 that we all want but
if SCO puts a dent in the works Linux will recover and maybe be better.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
