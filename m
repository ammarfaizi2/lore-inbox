Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267974AbTBXEqL>; Sun, 23 Feb 2003 23:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267977AbTBXEqL>; Sun, 23 Feb 2003 23:46:11 -0500
Received: from bitmover.com ([192.132.92.2]:50112 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267974AbTBXEqK>;
	Sun, 23 Feb 2003 23:46:10 -0500
Date: Sun, 23 Feb 2003 20:56:16 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, Mark Hahn <hahn@physics.mcmaster.ca>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224045616.GB4215@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, Mark Hahn <hahn@physics.mcmaster.ca>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmaster.ca> <1510000.1045942974@[10.10.2.4]> <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3610000.1045957443@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Your position is that
> > there is no money in PC's only in big iron.  Last I checked, "big iron"
> > doesn't include $25K 4 way machines, now does it?  
> 
> I would call 4x a "big machine" which is what I originally said.

Nonsense.  You were talking about 16/32/64 way boxes, go read your own mail.
In fact, you said so in this message.

Furthermore, I can prove that isn't what you are talking about.  Show me
the performance gains you are getting on 4way systems from your changes.
Last I checked, things scaled pretty nicely on 4 ways.

> > You claimed that
> > Dell was making the majority of their profits from servers. 
> 
> I think that's probably true (nobody can be certain, as we don't have the
> numbers).

Yes, we do.  You just don't like what the numbers are saying.  You can
work backward from the size of the server market and the percentages
claimed by Sun, HP, IBM, etc.  If you do that, you'll see that even
if Dell was making 100% margins on every server they sold, that still
wouldn't be 51% of their profits.

It's not "probably true", it's not physically possible that it is true
and if you don't know that you are simply waving your hands and not 
doing any math.

> > To refresh
> > your memory: "I bet they still make more money on servers than desktops
> > and notebooks combined".  Are you still claiming that?  
> 
> Yup.

Well, you are flat out 100% wrong.

> > If so, please
> > provide some data to back it up because, as Mark and others have pointed
> > out, the bulk of their servers are headless desktop machines in tower
> > or rackmount cases. 
> 
> So what? they're still servers. I can no more provide data to back it up
> than you can to contradict it, because they don't release those figures. 

Read the mail I've posted on topic, the data is there.  Or better yet,
don't trust me, go work it out for yourself, it isn't hard.

> > I don't see that as wise.  You could prove me wrong.  
> > Here's how you do it: go get oprofile
> > or whatever that tool is which lets you run apps and count cache misses.
> > Start including before/after runs of each microbench in lmbench and 
> > some time sharing loads with and without your changes.  When you can do
> > that and you don't add any more bus traffic, you're a genius and 
> > I'll shut up.
> 
> I don't feel the need to do that to prove my point, but if you feel the
> need to do it to prove yours, go ahead.

Ahh, now we're getting somewhere.  As soon as we get anywhere near real
numbers, you don't want anything to do with it.  Why is that?

> You seem to think the maintainers are morons that we can just slide crap
> straight by ... give them a little more credit than that.

It happens all the time.

> > Come on, prove me wrong, show me the data.
> 
> I don't have to *prove* you wrong. I'm happy in my own personal knowledge
> that you're wrong, and things seem to be going along just fine, thanks.

Wow.  Compelling.  "It is so because I say it is so".  Jeez, forgive me 
if I'm not falling all over myself to have that sort of engineering being
the basis for scaling work.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
