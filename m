Return-Path: <linux-kernel-owner+w=401wt.eu-S1753354AbWLPCzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbWLPCzX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 21:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbWLPCzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 21:55:23 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39459 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753354AbWLPCzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 21:55:22 -0500
Date: Fri, 15 Dec 2006 18:55:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: karderio <karderio@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <1166236356.12721.142.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org>
References: <1166226982.12721.78.camel@localhost> 
 <Pine.LNX.4.64.0612151615550.3849@woody.osdl.org> <1166236356.12721.142.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2006, karderio wrote:
> 
> As it stands, I believe the licence of the Linux kernel does impose
> certain restrictions and come with certain obligations

Absolutely. And they boil down to something very simple:

	"Derived works have to be under the same license"

where the rest is just really fluff.

But the point is, "derived work" is not what _you_ or _I_ define. It's 
what copyright law defines.

And trying to push that definition too far is a total disaster. If you 
push the definition of derived work to "anything that touches our work", 
you're going to end up in a very dark and unhappy place. One where the 
RIAA is your best buddy.

And the proposed "we make some technical measure whereby we draw our _own_ 
lines" is exactly that total disaster.

We don't draw our own lines. We accept that the lines are drawn for us by 
copyright law, and we actually _hope_ that the lines aren't too sharp and 
too clearcut. Because sharp edges on copyright is the worst possible 
situation we could ever be in.

The reason fair use is so important is exactly that it blunts/dulls the 
sharp knife that overly strong copyright protection could be. It would be 
a total disaster if you couldn't quote other peoples work, and if you 
couldn't make parodies on them, and if you couldn't legally use the 
knowledge you gained for them.

In other words, copyright MUST NOT be seen as some "we own this, and you 
have no rights AT ALL unless you play along with our rules". Copyright 
absolutely _has_ to allow others to have some rights to play according to 
their rules even without our permission, and even if we don't always agree 
with what they do.

And that is why it would be WRONG to think that we have the absolute right 
to say "that is illegal". It's simply not our place to make that 
judgement. When you start thinking that you have absolute control over the 
content or programs you produce, and that the rest of the worlds opinions 
doesn't matter, you're just _wrong_.

And no, "BECAUSE I'M GOOD" is _not_ an excuse. It's never an excuse to do 
something like that just because you believe you are "in the right". It 
doesn't matter _how_ much you believe in freedom, or anything else - 
everybody _always_ thinks that they are in the right.  The RIAA I'm sure 
is in a moral lather because they are protecting their own stronghold of 
morality against the infidels and barbarians at the gate.

So don't go talking about how we should twist peoples arms and force them 
to be open source of free software. Instead, BE HAPPY that people can take 
advantage of "loopholes" in copyright protections and can legally do 
things that you as the copyright owner might not like. Because those 
"loopholes" are in the end what protects YOU.

			Linus
