Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292464AbSBPRuW>; Sat, 16 Feb 2002 12:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292467AbSBPRuN>; Sat, 16 Feb 2002 12:50:13 -0500
Received: from bitmover.com ([192.132.92.2]:43159 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292464AbSBPRuB>;
	Sat, 16 Feb 2002 12:50:01 -0500
Date: Sat, 16 Feb 2002 09:50:01 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Possible breakthrough in the CML2 logjam?
Message-ID: <20020216095001.H9357@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1013810923.807.1055.camel@phantasy> <20020215232832.N27880@suse.de> <3C6DE87C.FA96D1D6@mandrakesoft.com> <20020216095202.M23546@thyrsus.com> <3C6E7C75.A6659D72@mandrakesoft.com> <20020216105219.A31001@thyrsus.com> <3C6E8A15.D5C209B1@mandrakesoft.com> <20020216115739.B32311@thyrsus.com> <20020216093727.F9357@work.bitmover.com> <20020216121634.A1582@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020216121634.A1582@thyrsus.com>; from esr@thyrsus.com on Sat, Feb 16, 2002 at 12:16:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2002 at 12:16:34PM -0500, Eric S. Raymond wrote:
> Larry McVoy <lm@bitmover.com>:
> > > I need you to tell Linus that your concerns have been met
> > > and sponsor CML2 to go in, so I can stop perpetually re-fighting old
> > > battles.
> > 
> > That's a fine thing for anyone and everyone to say *after* they have
> > used the system and like it.
> > 
> > If you are asking for a blessing in advance, which is how I read that,
> > I would think there is zero chance of that happening, it's not how work
> > is done on the kernel.
> 
> We're talking about design objections here.  Specific objections to actual
> CML2 bugs, including rulebase and UI bugs, are a different level.  What
> I am asking is if Jeff will bless the *architecture* provided the global-
> dependency issue is met.

See your quote above which contains "and sponsor CML2 to go in".  Code is 
what goes in.  Having the right architecture is great, we all agree, but
what goes in is code.  So your question above is basically "if I do this
will you pressure Linus to accept my *code*".  The answer to that should
always be "no".  You're trying to do an end run around the process.  The
process here is to let people see the changes, try the changes, refine 
the changes, and when they are ready, Linus accepts the changes.  Nowhere
in that process is any deal making.  What you are doing is a lot like the
skating judges, making deals.  Your code should go in evaluated on its
merits.  That's the beauty of the system.  It doesn't matter who *you*
are, the code is the only thing.  So you can be universally loved and
your code might not make it in.  You can be universally hated, and your
code can make it in.  That's a pretty cool system and I'd suggest that
you stop trying to work around it and just make your code be something 
that people want.  Then it will go in.  No deals necessary.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
