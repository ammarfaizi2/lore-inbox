Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310373AbSBRKGs>; Mon, 18 Feb 2002 05:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310380AbSBRKGi>; Mon, 18 Feb 2002 05:06:38 -0500
Received: from 89dyn216.com21.casema.net ([62.234.20.216]:27032 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S310373AbSBRKGa>; Mon, 18 Feb 2002 05:06:30 -0500
Message-Id: <200202181006.LAA00913@cave.bitwizard.nl>
Subject: Re: Possible breakthrough in the CML2 logjam?
In-Reply-To: <20020216095001.H9357@work.bitmover.com> from Larry McVoy at "Feb
 16, 2002 09:50:01 am"
To: Larry McVoy <lm@bitmover.com>
Date: Mon, 18 Feb 2002 11:06:24 +0100 (MET)
CC: "Eric S. Raymond" <esr@thyrsus.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Sat, Feb 16, 2002 at 12:16:34PM -0500, Eric S. Raymond wrote:
> > Larry McVoy <lm@bitmover.com>:
> > > > I need you to tell Linus that your concerns have been met
> > > > and sponsor CML2 to go in, so I can stop perpetually re-fighting old
> > > > battles.
> > > 
> > > That's a fine thing for anyone and everyone to say *after* they have
> > > used the system and like it.
> > > 
> > > If you are asking for a blessing in advance, which is how I read that,
> > > I would think there is zero chance of that happening, it's not how work
> > > is done on the kernel.
> > 
> > We're talking about design objections here.  Specific objections to actual
> > CML2 bugs, including rulebase and UI bugs, are a different level.  What
> > I am asking is if Jeff will bless the *architecture* provided the global-
> > dependency issue is met.
> 
> See your quote above which contains "and sponsor CML2 to go in".  Code is 
> what goes in.  Having the right architecture is great, we all agree, but
> what goes in is code.  So your question above is basically "if I do this
> will you pressure Linus to accept my *code*".  The answer to that should
> always be "no". 

Sometimes I'm willing to vouch for the quality of the *code*, and I
want a "go ahead and do it" from the kernel crowd.

Writing the code without consensus on the architecture can make you
have to go back to architecting when people have architectural
objections. 

Part of the problem is that in a company the manager is in the end
responsible for the salary of the guy doing the work. So he'll work
along an try to make a good architecture before doing the actual
coding.

For Linus it costs just one Email to say: "Hmm. Maybe. Show me the
code!", and reject the code later on. 


	Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
