Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262227AbSJFWOB>; Sun, 6 Oct 2002 18:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262230AbSJFWOB>; Sun, 6 Oct 2002 18:14:01 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:4876
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262227AbSJFWOA>; Sun, 6 Oct 2002 18:14:00 -0400
Subject: Re: New BK License Problem?
From: Robert Love <rml@tech9.net>
To: Larry McVoy <lm@bitmover.com>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20021006150554.T29486@work.bitmover.com>
References: <20021006075627.I9032@work.bitmover.com>
	<Pine.LNX.4.44.0210061718370.9062-100000@localhost.localdomain>
	<anqa2m$cr4$2@ncc1701.cistron.net> 
	<20021006150554.T29486@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 18:19:03 -0400
Message-Id: <1033942743.27093.24.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 18:05, Larry McVoy wrote:

> On Sun, Oct 06, 2002 at 09:31:02PM +0000, Miquel van Smoorenburg wrote:
>
> > And what if that versioning filesystem got accepted into mainline?
> > Every kernel developer would have to buy a BK license.
> > 
> > Either that or a versioning filesystem cannot get into mainline.
> > Sorry Hans, no reiser4 in the kernel.
> 
> If Hans decides to get into the version control space and compete directly
> against us, your position is that we should be obligated to give him free
> seats?  And that's reasonable in your mind?

I think the fear is more that via the license you could deny any kernel 
seats.

I.e., let's say I never intend to work on reiser4 but it is part of the
source tree I would be working on via BK.  Am I at risk?

Or, what if I do not directly work on reiser4 but I do post an ancillary
patch - perhaps to fix a compile issue or update reiser4 to some new
locking change.  Am I at risk now?

I agree 100% with your intentions.  You are under no obligation to help
your competitors for free - nor should you.  But BitKeeper is now in a
position where it is a main-stay in kernel development and it is crucial
to resolve issues like this.  I do not feel arguments like "you get what
you pay for" or "that is life" are valid, anymore: developers are
relying on BK and the choice is to resolve the issues or drop BK
altogether -- not just "live with it".

	Robert Love

