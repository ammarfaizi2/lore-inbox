Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbRL0UpZ>; Thu, 27 Dec 2001 15:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286646AbRL0UpQ>; Thu, 27 Dec 2001 15:45:16 -0500
Received: from [198.17.35.35] ([198.17.35.35]:13270 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S286649AbRL0UpB>;
	Thu, 27 Dec 2001 15:45:01 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2A3A@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Larry McVoy'" <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: The direction linux is taking
Date: Thu, 27 Dec 2001 12:45:08 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But this didn't answer my question at all.  My question was 
> why is this a 
> problem related to a source management system?  I can see how 
> to exactly
> mimic what described Al doing in BK so if that is the 
> definition of goodness,
> the addition (or absence) of a SCM doesn't seem to change the answer.

> I _think_ what you are saying is that an SCM where your 
> repository is a 
> wide open black hole with no quality control is a problem, but that's 
> not the SCM's fault.  You are the filter, the SCM is simply 
> an accounting/
> filing system.

<deletia>

> but your typical SCM has the end user doing the merges, not 
> the maintainer.
> If you had an SCM system which allowed the maintainer to do 
> all or some of
> the merging, would that help?

i think the problem becomes one of usability : is there any
way that the SCM system can be easy enough to use?

or, put another way :
why use the SCM if the features it gives are being supplied
in a completely acceptable manner by the maintainer?
If Linus is doing it on his own, and you're suggesting that
he set the SCM up so that he does it all on his own in the
end anyways, why should he add an extremely obtrusive step
(SCM) to the mix?  Why should it be any harder on his day
to day methodology that he's already comfortable with?

If SCM is just a distribution mechanism, then it's not
something that's particularly interesting.  If SCM is
only allowing a single user to apply patches, then it's
not particularly useful in reducing the workload of that
person (if they've got the organizational skills to manage
the whole thing, then adding another layer to work through
isn't going to help!)

Don't get me wrong, I'm all for SCM, I just don't think
that applying SCM is going to relieve any patch-confusion
and it's not going to add any real benefit either....

(If, on the other hand, we allowed multiple committers
and access-controlled maintainer lists, then SCM would
be beautiful!  but this isn't FreeBSD :) :) :) :) :)

/me ducks for that last comment

Dana Lacoste
Ottawa, Canada
