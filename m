Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTFTPf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 11:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTFTPf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 11:35:29 -0400
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:54539 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id S263179AbTFTPfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 11:35:21 -0400
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: Larry McVoy <lm@bitmover.com>
Subject: Re: [OT] Re: Troll Tech [was Re: Sco vs. IBM]
Date: Fri, 20 Jun 2003 10:49:19 -0500
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <063301c32c47$ddc792d0$3f00a8c0@witbe> <200306200944.05937.nleroy@cs.wisc.edu> <20030620151750.GA17563@work.bitmover.com>
In-Reply-To: <20030620151750.GA17563@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306201049.19675.nleroy@cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 June 2003 10:17 am, Larry McVoy wrote:
> On Fri, Jun 20, 2003 at 09:44:05AM -0500, Nick LeRoy wrote:

> I think the most profound new things in Linux are Linus himself, he's a
> unique leader IMO, and even moreso the process by which it is developed.
> The *process* is new, at least new to the commercial world.  It's too
> bad that the community couldn't patent the development process :)  Most
> commercial folks who come in contact with the Linux development process
> just don't get it, they want to impose "control" and "release process"
> and all sorts of stuff that makes sense in a commercial environment but
> would ruin what's going on with Linux.  The BSD folks are much closer to
> commercial people in mentality, they want that feeling of control and
> Linux is developed in a sort of zen like free for all that is different
> and works well.

Yup.  I know that you feel that way.  I think that we're all in agreement 
here.

> > Sendmail, very much open source, was certainly ground-breaking.  The X
> > window system.  Nethack, adventure, etc. -- the whole concept of computer
> > gaming derives from the open source world (granted the is all from long
> > before the term "open source" existsed).
>
> The stuff you are describing is 20 years old.  The problem I'm describing
> is current.
>
> Maybe this is a way to see the point:  Red Hat, which is a company I like
> and I have friends there so I'm not trying to beat up on them OK?, has been
> around for quite a while.  They are an open source company.  I'm not sure
> how old they are but it has to be more than 5 years, right?  Wouldn't it
> be interesting to go compare what Red Hat has done in terms of new stuff
> to say, Sun, in the same first N years of their history?  I'd have to go
> look at the timelines but Sun brought us mmap(), the VFS layer, NFS, RPC,
> yp, etc.  And wrote nice thoughtful papers about it all so that others
> could learn from their efforts.

Not sure how much to snip here....

Right now, I'm reading a book by Stephen Hawking named "On the Shoulders of 
Giants", and somehow it all seems so relevant.  My point is that most, if not 
_all_, innovation the CS world, originated in the open source world.  Unix 
would, in all likelyhood, have died an early death had Bell Labs not release 
the source code to universities (esp Berkley) which grew it into a real 
product.

Sun, that you sight above, never could have given us NFS, etc. had it not been 
for the TCP, UDP & IP socket stuff that Berkley created.  I'm not dissing Sun 
here; they've done some wonderful things, but they've only been able to do it 
as part of a community.  It's the giants who make their work available to be 
built upon, like the science community, that drives true forward progress.  
Imagine what our world would be like if true science were driven by profit, 
and locked up it's work?  Where would the quantum physics upon which our 
computers are based be?  Would we be able to fly if Newton's laws of 
gravitation had been kept a deep secret?  Gee, I'm starting to feel like ESR 
here.  :-)

Sun is, I contend, the exception, not the rule, unfortunately.  Corporations 
are driven by profit, not the good of the world, the good of the users, or 
anything like that.  That's why you see monsters like M$, who would bat an 
eyelash about destroying the world if it'd make they're shareholders another 
$.  It's just sick.

Larry, I know that you've done the LK community a lot of good with BitKeeper, 
and many of us do appreciate your contribution both the kernel directly, and 
through your offering of BK services.  But, even you didn't invent the source 
control idea.  It's all been built on the shoulders of giants.  :-)

Ok, time to get off my soapbox, and back to work.

-Nick

