Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279981AbRL0Uzt>; Thu, 27 Dec 2001 15:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281360AbRL0Uzj>; Thu, 27 Dec 2001 15:55:39 -0500
Received: from bitmover.com ([192.132.92.2]:27294 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S279981AbRL0Uz3>;
	Thu, 27 Dec 2001 15:55:29 -0500
Date: Thu, 27 Dec 2001 12:55:28 -0800
From: Larry McVoy <lm@bitmover.com>
To: Dana Lacoste <dana.lacoste@peregrine.com>
Cc: "'Larry McVoy'" <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011227125528.K25698@work.bitmover.com>
Mail-Followup-To: Dana Lacoste <dana.lacoste@peregrine.com>,
	'Larry McVoy' <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2A3A@ottonexc1.ottawa.loran.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2A3A@ottonexc1.ottawa.loran.com>; from dana.lacoste@peregrine.com on Thu, Dec 27, 2001 at 12:45:08PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 12:45:08PM -0800, Dana Lacoste wrote:
> why use the SCM if the features it gives are being supplied
> in a completely acceptable manner by the maintainer?
> If Linus is doing it on his own, and you're suggesting that
> he set the SCM up so that he does it all on his own in the
> end anyways, why should he add an extremely obtrusive step
> (SCM) to the mix?  Why should it be any harder on his day
> to day methodology that he's already comfortable with?

Merging is much easier.
Tracking of patches is much easier.
Access control is much easier.
Etc.

> (If, on the other hand, we allowed multiple committers
> and access-controlled maintainer lists, then SCM would
> be beautiful!  but this isn't FreeBSD :) :) :) :) :)

Actually, BK can definitely do that.  In fact, that's basically exactly what
we have on the hosting service for the PPC tree.  There are a list of people
who are administrators, a list of committers, as well as read only access.
The admins are also committers if they want to be, the admins also get to
control who is and is not a committer.

And you dream up as complicated an access control model as you want.  We
can do pretty much any model you can describe.  Try me, describe a work
flow that you think would be useful, I'll write up how to do it and stick
it on a web page and you can throw stones at it and see if it breaks.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
