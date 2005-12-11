Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbVLKGp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbVLKGp3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 01:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVLKGp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 01:45:28 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:4770 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932235AbVLKGp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 01:45:28 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Douglas McNaught <doug@mcnaught.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Sat, 10 Dec 2005 23:52:55 -0600
User-Agent: KMail/1.8
Cc: Bill Davidsen <davidsen@tmr.com>, Mark Lord <lkml@rtr.ca>,
       Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
References: <20051203135608.GJ31395@stusta.de> <439ADAF3.9040705@tmr.com> <m2r78khogb.fsf@Douglas-McNaughts-Powerbook.local>
In-Reply-To: <m2r78khogb.fsf@Douglas-McNaughts-Powerbook.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512102352.56508.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 December 2005 11:05, Douglas McNaught wrote:
> The kernel developers owe *nothing* to J. Random User.  They are
> either doing what they do for their own reasons (the "fun" of it), or
> being paid by an organization with specific objectives (even if, in
> Linus' case, the objective is just "make the best kernel possible,
> based on your judgement and that of people you trust").

That's not a good argument.  I don't think Bill has a good argument either, 
but this isn't one.

The kernel developers have very good reasons for what they're doing, and 
ultimately they believe that what they're doing is in the best long-term 
interests of the users.  Bill has objections based on the short-term 
interests of users.  The kernel developers are saying that looking after the 
short-term interests of the users is the distros' problems, while they focus 
on the long-term and the big picture.

Both are doing what they believe to be in the best interests of the users.  
Bill believes (and keeps uselessly repeating) that the kernel developers 
should pay more attention to short-term interests.  The whole "stable series" 
vs "continuous development" is about short-term interests vs long-term 
interests.

Overall, development of new technology (and adoption of new technology) goes 
faster when it's continuous than when you have large discontinuous jumps.  
You find problems faster, and you find them one at a time when it's easy to 
isolate what's wrong rather than receiving three years of development in one 
gulp and experiencing fifteen different failures all at once.  Problems are 
more frequent, but they're smaller and simpler and easier to diagnose and 
easier to fix.  User can _cope_ with a higher rate of change when it comes in 
smaller chunks.  The learning curve isn't a cliff.

> They don't owe you security fixes either.

Actually, they seem to think they do.  They're quite dilligent about providing 
security fixes.  But the security fixes they give are part of the ongoing 
development process.  Separating them out and backporting them to previous 
versions is your problem, and if you don't feel up to it they point you to 
distributions, which will do that for you.

So there are two different ways you can get the fixes.  (Upgrade, or use a 
distro maintained kernel.)  Some people think they're owed a third way, and 
want somebody else to provide it for them.

> Your "ivory tower" statement is really condescending.

*shrug*  This whole thread is basically people bitching about what other 
people should do, instead of banding together and giving it a try themselves.  
It started condescending.  In the absence of constructive suggestions or 
anyone actually doing real work rather than merely bitching about the state 
of the world, I think most of the developers have written off the whiners 
with a silent "sucks to be you" and moved on...

(I do hope we get the "buffer flush" dot-releases though.  That would be 
nice.)

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
