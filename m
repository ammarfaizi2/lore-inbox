Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283716AbRK3R1v>; Fri, 30 Nov 2001 12:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283718AbRK3R1m>; Fri, 30 Nov 2001 12:27:42 -0500
Received: from bitmover.com ([192.132.92.2]:48053 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S283716AbRK3R1b>;
	Fri, 30 Nov 2001 12:27:31 -0500
Date: Fri, 30 Nov 2001 09:27:30 -0800
From: Larry McVoy <lm@bitmover.com>
To: Henning Schmiedehausen <hps@intermeta.de>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
Message-ID: <20011130092730.Q14710@work.bitmover.com>
Mail-Followup-To: Henning Schmiedehausen <hps@intermeta.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu> <20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de> <20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge> <3C07B820.4108246F@mandrakesoft.com> <1007140529.6655.37.camel@forge>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1007140529.6655.37.camel@forge>; from hps@intermeta.de on Fri, Nov 30, 2001 at 06:15:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 06:15:28PM +0100, Henning Schmiedehausen wrote:
> On Fri, 2001-11-30 at 17:47, Jeff Garzik wrote:
> > The security community has shown us time and again that public shaming
> > is often the only way to motivate vendors into fixing security
> > problems.  Yes, even BSD security guys do this :)
> > 
> > A "Top 10 ugliest Linux kernel drivers" list would probably provide
> > similar motivation.
> 
> A security issue is an universal accepted problem that most of the time
> has a reason and a solution.
> 
> And you really want to judge code just because someone likes to wrap
> code in preprocessor macros or use UPPERCASE variable names? 

Henning, in any long lived source base, coding style is crucial.  People
who think that coding style is personal are just wrong.  Let's compare,
shall we?

Professional: the coding style at this job looks like XYZ, ok, I will now
    make my code look like XYZ.

Amateur: my coding style is better than yours.

I think that if you ask around, you'll find that the pros use a coding 
style that isn't theirs, even when writing new code.  They have evolved
to use the prevailing style in their environment.  I know that's true for
me, my original style was 4 space tabs, curly braces on their own line,
etc.  I now code the way Bill Joy codes, fondly known as Bill Joy normal
form.

Anyway, if you think any coding style is better than another, you completely
miss the point.  The existing style, whatever it is, is the style you use.
I personally despise the GNU coding style but when I make changes there,
that's what I use because it is their source base, not mine.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
