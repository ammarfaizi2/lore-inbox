Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbTHXBBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 21:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTHXBBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 21:01:16 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:58604 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263359AbTHXBBK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 21:01:10 -0400
Date: Sat, 23 Aug 2003 18:01:00 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: Larry McVoy <lm@bitmover.com>, Aaron Lehmann <aaronl@vitelus.com>,
       linux-kernel@vger.kernel.org
Subject: Re: *sigh* something is wrong with bkcvs again
Message-ID: <20030824010100.GB25535@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ken Moffat <ken@kenmoffat.uklinux.net>,
	Larry McVoy <lm@bitmover.com>, Aaron Lehmann <aaronl@vitelus.com>,
	linux-kernel@vger.kernel.org
References: <20030823012724.GC31894@vitelus.com> <20030823191458.GA25535@work.bitmover.com> <Pine.LNX.4.56.0308240110220.22919@ppg_penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0308240110220.22919@ppg_penguin>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's put this into context.  I got up this morning to find Aaron's
posting and I started looking into the problem.  It turned into a mess
and rather than spend Saturday with my wife and kids I sent them out of
the house so I could focus on this and fix it.  It took several hours
to track down the bug and the tree has been rebuilding since about 1pm.

I gave up half my weekend to fix this stuff.  I made my family get out of
the house for your benefit, my wife is pissed at me, my kids are pissed at
me, and people here are rude to me for giving them something for free that
they should have built themselves.  Hey, wrong answer and I'm the idiot
for putting up with it.  So I pointed out to the list that I don't like it
and I tried to make it clear by pointing out that you wouldn't put it with
that sort of bug report from me about the kernel.

Apparently I wasn't clear enough so here is try #2:

    - We don't owe you this service
    - You could have built this service
    - People are routinely rude about it when there are problems
    - Keep it up and the service goes away

We didn't get a nice message saying "please look at bk2cvs, it seems
broken", we got an annoyed message from some guy with an ax to grind.
Here's a quote from him talking about Pavel's oh-so-great BitKeeper clone:

    "It would be better if you stored it in BitKeeper just to piss Larry off."

    http://marc.theaimsgroup.com/?l=linux-kernel&m=104653836702419&w=2

The bk2cvs gateway is a free service, it costs us money to provide it.
People seem to think we are obligated to provide it and support it, and
they think it's OK to be rude.  Here's a feedback loop for you: every
time I get a rude mail about this service the gateway gets shut down.
First time is 1 day and it doubles every time after that.  That means
that you all as a community need to pass the word that it's not healthy
to be rude.  I'm sick of it, I've had it with that, I have absolutely
zero tolerance for it and no sense of humor about it.  

Some people have gotten the message, Ben Collins is a great example.
He's been polite and pleasant to deal with and as a result we host the
BK2SVN gateway next to the BK2CVS gateway.  If you're nice I'll bend
over backwards to help you but I've had it with rude people.  It doesn't
take any substantial effort to be polite and you as a community need to
require that politeness or give up the gateway.  It's that simple.
--
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
