Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSEYSo2>; Sat, 25 May 2002 14:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315232AbSEYSo1>; Sat, 25 May 2002 14:44:27 -0400
Received: from bitmover.com ([192.132.92.2]:12499 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315218AbSEYSoZ>;
	Sat, 25 May 2002 14:44:25 -0400
Date: Sat, 25 May 2002 11:44:26 -0700
From: Larry McVoy <lm@bitmover.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525114426.B15969@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Wolfgang Denk <wd@denx.de>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020525110208.A15969@work.bitmover.com> <20020525182617.D627E11972@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 08:26:12PM +0200, Wolfgang Denk wrote:
> > "application" needs to use the RT/Linux patent in order to work, it
> > either has to buy a license or be GPLed.
> 
> But this is an ADDITIONAL restriction, which violates the GPL,  which
> is the base of the RTL code, or isn't it?

Don't mix the GPL and the patent rules, they are not the same thing.  
To the extent that RTL code is derived from GPLed code, it has to 
obey the GPL, that's true.  But the patent does not have to obey the
GPL, one are is copyright law (that's what covers the GPL) and the
other is patent law.

FSMlabs can make any rules they want for their license of their patent.
The fact that the GPL doesn't want additional restrictions has no bearing
on the patent law.

> > Maybe Victor should have used a different model: if no money changes hands,
> > then it's free to use the patent, if money changes hand, FSMlabs wants a 
> 
> Define  "if  money  changes  hand".  Let's  say  I  develop  a  smart
> controller  software for disk drives, and I give it (maybe for money,
> maybe for free, maybe under  GPL  or  not)  to  IBM  and  Maxtor  and
> Seagate.  The  disk manufacturers make modifications to the code, and
> embed it into their disk drives. Then they sell the  drives  to  Dell
> and HP and ... Those sell PCs to many, many vendors, who sell the PCs
> to you and men and ...

Definitely "money changed hands".

> > cut.  I think that was the intent, but as with all things, it's hard to 
> > state that clearly in a legal document.  If that was the intent, I support
> > it, I think it's perfectly reasonable.  
> 
> If that was the case, Victor should have been  able  to  explain  his
> intentions to anybody in public. Why did he never do that? But spread
> FUD instead?

Well, as someone who has been working in a somewhat similar manner, I can
say that there is a very unhealthy tendency for the free software community
to be fanatical and somewhat self destructive on these topics.  There are
piles of people who want to make money off of your work and have absolutely
no intention in sharing that money.  And they get pissed as hell when you
figure out a way to force them to share that money.  After a while, you
get pretty sick of people yelling at you and you just start to ignore them.
I've spoken with Victor about this topic a few times and while I will not
speak for him in specifics, I will say he's equally unthrilled with a lot
of what gones on.  It's tiresome.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
