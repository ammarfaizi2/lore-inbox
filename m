Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTD2E4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 00:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTD2E4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 00:56:49 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:46804 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261953AbTD2E4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 00:56:47 -0400
Date: Mon, 28 Apr 2003 22:08:56 -0700
From: Larry McVoy <lm@bitmover.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matthias Schniedermeyer <ms@citd.de>,
       Ross Vandegrift <ross@willow.seitz.com>,
       Chris Adams <cmadams@hiwaay.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why DRM exists [was Re: Flame Linus to a crisp!]
Message-ID: <20030429050856.GC23581@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Dax Kelson <dax@gurulabs.com>, Larry McVoy <lm@bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Matthias Schniedermeyer <ms@citd.de>,
	Ross Vandegrift <ross@willow.seitz.com>,
	Chris Adams <cmadams@hiwaay.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030429000904.GA9653@work.bitmover.com> <Pine.LNX.4.44.0304282144200.22872-100000@mooru.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304282144200.22872-100000@mooru.gurulabs.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=1.3, required 4.5,
	DATE_IN_PAST_06_12, ITS_LEGAL)
X-MailScanner-SpamScore: s
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your complaint/observation about cloning/re-implementation is recognized.  
> 
> The counter claims are:
> 
> 1. Unless patents are involved, it is perfectly LEGAL.
> 2. Virtually nothing is original to begin with.
> 3. The practice is hardly unique to Open Source developers.

Me:  Action A is leading to reaction B which you don't want.
You: Action A is perfectly legal, etc., etc.
Me:  It's not about whether it is legal or not, it's about reaction B.
You: Action A is perfectly legal, etc., etc.
Me:  Reaction B is what you don't want, it's behaviour A which is the cause.
You: Action A is perfectly legal, etc., etc.
Me:  You keep missing the point about the reaction B.
You: Action A is perfectly legal, etc., etc.
Me:  Err, umm, how many times do I have to tell you it is the reaction that
     is what you want to avoid?
You: Action A is perfectly legal, etc., etc.
Me:  Sigh.


I think the point that you are missing is that if the corporations are 
threatened by your actions they will take steps to remove that threat.
The various IP protection changes which we are seeing are those steps.
People keep telling me how I don't understand the legality of the threats
and I keep telling them that the world evolves, we're in a world which 
is moving more and more towards a place where much of the economy is
based on IP, not physical goods.  As that happens the laws will be
evolved to protect the owners of the IP, technology will evolve to 
protect that IP, everything becomes about the IP.

To the extent that the corporations view your actions as a threat,
they will react.  Consider at Microsoft Word, if you don't talk Word
you don't do business.  So if Microsoft gets really nervous about
their office monopoly what is to prevent them from encrypting the data?
You can build all the Word compatible programs you want and it won't do a
bit of good if you can't read the data.  It's the data, not the program,
which is valuable.  He who owns the data wins.  Office is more than proof.

It's my belief that the more you chase the leaders, the more the leaders
will lock up what gives them that lead.  Various people on this list have
said that the lockup will fail, it will be too inconvenient.  I don't buy
it for a second.  If only the Word binaries can read Word documents, that
doesn't cause the users any headaches, they can still get their job done.

So how do you win?  Create a *better* answer.  Chasing is a waste of your
time, all that happens is that the people being chased will do a little
work to make it impossible to get at the data produced by their tools.
You win by being a leader, not following a leader.

It's not that hard to lead, you just need to decide to do it.  Look at Word.
What's wrong with it?  Well, it's a binary file format, you can't version
control it in a meaningful way, there is no way to merge diverged docs,
so development on any doc is single threaded.  Suppose you made an
ascii file format (me being the geek I am, I'd use troff as the back
end but that's just me), add version control (RCS would be good enough),
made a 3 way merge tool, TADA, you have just parallelized documentation
(never mind that we had this in the 70's and Microsoft screwed it up).
There is a huge, huge market for this sort of thing.

Instead of actually making real progress, people work on reimplementation
of the same thing.  Doomed, the leader changes a few things, you're
incompatible, you lose because noone can open their files in your tool.

The problem, in my not so respected opinion, is that the open source
community is good at chasing and hasn't figured out how to lead.
Linux is a hell of a success story but it's still Unix.  It's a nice
Unix, I much prefer it over any other but I could just as easily live
on MacOS X if I had to, the processors are fast enough for what I do.
But Linux isn't really the issue, the OS has never been the issue, it's
always been the applications.  And there, again, we see reimplementation
of proprietary apps and infrastructure.  When Microsoft is following
Mono rather than the other way around, then the tide will have changed.
As long as you chase them, you're bound to lose.

We may now return to our regularly scheduled thread of how I don't get
that reimplementation is perfectly legal and I'll go do some real work...
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
