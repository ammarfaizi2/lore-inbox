Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWIYCpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWIYCpI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 22:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWIYCpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 22:45:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59848 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030192AbWIYCpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 22:45:05 -0400
Date: Sun, 24 Sep 2006 19:44:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: An Ode to GPLv2 (was Re: GPLv3 Position Statement)
In-Reply-To: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
Message-ID: <Pine.LNX.4.64.0609241917520.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One of the reasons I didn't end up signing the GPLv3 position statement 
that James posted (and others had signed up for), was that a few weeks ago 
I had signed up for writing another kind of statement entirely: not so 
much about why I dislike the GPLv3, but why I think the GPLv2 is so great.

(There were other reasons too, but never mind that.)

I didn't get my fat arse off the ground on that, partly exactly because 
the developer poll of "which is better" which was related to that issue 
distracted me, but mostly because I just seldom write that kind of text - 
one thing the kernel work has conditioned me for is that I write _replies_ 
to email, I seldom start threads myself (I suspect most of my emails on 
linux-kernel that aren't replies are just release announcements).

However, since there was a sub-thread on groklaw about the kernel 
developers opinions on the GPLv3, and since I did try to explain it there 
(as a reply to postings by PJ and others), and since some of those 
explanations ended up being exactly the "why the GPLv2 is so insanely 
great" that I never wrote otherwise, I thought I'd just repost that 
explanation as an alternative view.

So this post is kind of another way to look at the whole GPLv3 issues: not 
caring so much about why the GPLv3 is worse, but a much more positive "Why 
the GPLv2 is _better_". I suspect some people may have an easier time 
seeing and reading that argument, since it's not as contentious.

A lot of people seem to think that the GPLv2 is showing its age, but I 
would argue otherwise. Yes, the GPLv2 is "old" for being a copyright 
license, but it's not even that you don't want to mess with something that 
works - it's that it very fundamentally is such a good license that 
there's not a whole lot of room for fixing aside from pure wording issues.

So without further ado, here's my personal "reply" to the the GPLv3 
position statement. It's obviously not meant to repudiate James' text in 
any way, it's just an alternate view on the same questions..

I made other posts in the same thread on Groklaw thread, not as positive, 
and not perhaps as worthy and quotable. This one may be a bit out of 
context, but I do think it stands on its own, and you can see the full 
thread in the "GPL Upheld in Germany Against D-Link" discussions on 
Groklaw. The particular sub-thread was on what happens since we can't 
easily change update the license, called "So What is the Future Then?"

(I'd like to point to the groklaw posts, but there doesn't seem to be any 
way to point to a particular comment without getting "The URL from Hell", 
so it's easier to just duplicate it here).

		Linus

---

And thus spake PJ in response:
   "GPLv2 is not compatible with the Apache license.  It doesn't cover
    Bitstream.  It is ambiguous about web downloads.  It allows Tivo to
    forbid modification.  It has no patent protection clause.  It isn't
    internationally useful everywhere, due to not matching the terms of
    art used elsewhere.  It has no DMCA workaround or solution.  It is
    silent about DRM."

Exactly!

That's why the GPLv2 is so great.  Exactly because it doesn't bother or
talk about anything else than the very generic issue of "tit-for-tat". 

You see it as a failure.  I see it as a huge advantage.  The GPLv2 covers 
the only thing that really matters, and the only thing that everybody can 
agree on ("tit-for-tat" is really something everybody understands, and 
sees the same way - it's totally independent of any moral judgement and 
any philosophical, cultural or economic background).

The thing is, exactly because the GPLv2 is not talking about the details, 
but instead talks entirely about just a very simple issue, people can get 
together around it.  You don't have to believe in the FSF or the tooth 
fairy to see the point of the GPLv2.  It doesn't matter if you're black or 
white, commercial or non-commercial, man or woman, an individual or a 
corporation - you understand tit-or-tat.

And that's also why legal details don't matter.  Changes in law won't 
change the notion of "same for same".  A change of language doesn't change 
"Quid pro quo".  We can still say "quid pro quo" two thousand years later, 
in a language that has been dead for centuries, and the saying is still 
known by any half-educated person in the world.

And that's exactly because the concept is so universal, and so 
fundamental, and so basic.

And that is why the GPLv2 is a great license.

I can't stress that enough.  Sure, other licenses can say the same thing, 
but what the GPLv2 did was to be the first open-source license that made 
that "tit-for-tat" a legal license that was widely deployed. That's 
something that the FSF and rms should be proud of, rather than trying to 
ruin by adding all these totally unnecessary things that are ephemeral, 
and depend on some random worry of the day.

That's also why I ended up changing the kernel license to the GPLv2. The 
original Linux source license said basically: "Give all source back, and 
never charge any money".  It took me a few months, but I realized that the 
"never charge any money" part was just asinine.  It wasn't the point.  
The point was always "give back in kind".

Btw, on a personal note, I can even tell you where that "never charge any 
money" requirement came from.  It came from my own frustrations with Minix 
as a poor student, where the cost of getting the system ($169 USD back 
then) was just absolutely prohibitive.  I really disliked having to spend 
a huge amount of money (to me) for something that I just needed to make my 
machine useful.

In other words, my original license very much had a "fear and loathing" 
component to it.  It was exactly that "never charge any money" part. But I 
realized that in the end, it was never really about the money, and that 
what I really looked for in a license was the "fairness" thing.

And that's what the GPLv2 is.  It's "fair".  It asks everybody - 
regardless of circumstance - for the same thing.  It asks for the effort 
that was put into improving the software to be given back to the common 
good.  You can use the end result any way you want (and if you want to use 
it for "bad" things, be my guest), but we ask the same exact thing of 
everybody - give your modifications back.

That's true grace.  Realizing that the petty concerns don't matter, 
whether they are money or DRM, or patents, or anything else.

And that's why I chose the GPLv2.  I did it back when the $169 I paid for 
Minix still stung me, because I just decided that that wasn't what it was 
all about.

And I look at the additions to the GPLv3, and I still say: "That's not 
what it's all about".

My original license was petty and into details.  I don't need to go back 
to those days.  I found a better license.  And it's the GPLv2.

			Linus
