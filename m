Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbTLFROs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 12:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbTLFROs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 12:14:48 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:6613 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S265212AbTLFROr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 12:14:47 -0500
Date: Sat, 6 Dec 2003 09:14:38 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031206171438.GC28765@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Erik Andersen <andersen@codepoet.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Paul Adams <padamsdev@yahoo.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com> <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com> <20031205010349.GA9745@codepoet.org> <20031205012124.GB15799@work.bitmover.com> <Pine.LNX.4.58.0312041750270.6638@home.osdl.org> <20031206030037.GB28765@work.bitmover.com> <Pine.LNX.4.58.0312051949210.2092@home.osdl.org> <20031206051433.GA25766@work.bitmover.com> <Pine.LNX.4.58.0312052119050.2092@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312052119050.2092@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 09:48:56PM -0800, Linus Torvalds wrote:
> But I never introduced the notion of being a licensee. I have at all times
> only talked about outright ownership. Sorry if I have been unclear (I
> didn't think I had been, but hey, few people find _themselves_ unclear ;)

Point taken.  You didn't, or at least I don't remember you doing it.
I was thinking about contract law being mixed with copyright law,
specifically the GPL (copyright) and the Unix license (which I believe
to be a contract and as such having nastier viral possibilities).

> Maybe you were confused by the IBM thing, and thinking that when I
> referred to IBM I referred to a licensee. But the fact is, IBM is _not_ a
> licensor of the JFS code etc. They own it outright. Even SCO has
> acknowledged that fact long ago.

Yes but that doesn't mean that SCO doesn't have a contract with IBM
(by way of ATT/Bell Labs) that gives SCO some rights over that code.

That said, I get your point about copyright and ownership.  It's a
good point and should probably be remade each time GPL fud comes up.
The prevailing view amongst manager types is not what you said, over and
over I have seen (as has everyone else) statements that if you combine
your code with GPLed code then your code becomes GPLed.  Period.  But
that's not true, as you pointed out.  If someone wants to keep combining
their code with the GPLed code then they have to offer their code under
the GPL (at the least).  The point that management types will like to hear
is that if someone screws up and puts something out there in binary form
that they shouldn't have, management has a choice.  They can cease and
desist or they have to offer up source under the GPL.

To management, that is a lot less scary than "combine this code and your
code is GPL".  Choice is good.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
