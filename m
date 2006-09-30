Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWI3Q7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWI3Q7b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 12:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWI3Q7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 12:59:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2751 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751297AbWI3Q7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 12:59:30 -0400
Date: Sat, 30 Sep 2006 09:59:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: tridge@samba.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <20060930153241.GC6955@opteron.random>
Message-ID: <Pine.LNX.4.64.0609300941060.3952@g5.osdl.org>
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
 <17692.41932.957298.877577@cse.unsw.edu.au> <1159512998.3880.50.camel@mulgrave.il.steeleye.com>
 <17692.53185.564741.502063@samba.org> <20060930153241.GC6955@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Sep 2006, Andrea Arcangeli wrote:
> 
> If there's something to work on for GPLv3 it is _not_ about
> restricting usage. It's about forcing _more_ sharing even behind the
> corporate firewall!

In many ways, I agree. The FSF seems to be barking up the wrong tree, the 
real problem is not things like Tivo (who already _do_ give source back), 
but the whole "we don't give source back because we're just exporting the 
results", aka the "ASP problem".

>		 In the ideal world that should be the only
> priority in FSF minds and I think they're still in time to change
> their focus on what really matters.

While I agree with you, I think one of the reasons that the FSF hasn't 
gone that way is that while in many cases it would make sense, it's 
actually even more controversial. The "Tivo" issue is a populist issue, 
and trying to solve the "ASP problem" is actually seriously more 
problematic.

First off, the ASP issue, while not in any way limiting "use" (you could 
still _use_ things as you see fit, you just have to give sources out: I 
think that's much more "in the spirit" than the current GPLv3 ever is), 
would actually require that in order to enforce it, such a license would 
clearly have to be a _contract_. If it's not distributed, it's not a 
matter of copyright any more, it's very obviously a matter of mutual 
agreement: "we give you source, you give us source back".

Secondly, a lot of people use GPL code privately, with private 
modifications, and you would see a lot more screaming than about the 
current GPLv3 draft. So I think the FSF (correctly) decided that they 
simply cannot do it.

In fact, it's one of the very traditional ways of making money for some 
Free Software projects: the whole way Cygnus supported itself was largely 
to make "private" branches of GCC for various commercial vendors, and 
while the vendors had the _right_ to distribute the sources, they also had 
the right not to (and since they didn't want to, they wouldn't be 
distributed).

Does that sound against the spirit of "give back source"? Sure does. But 
it's one of those things that the FSF has always supported, so they don't 
see it as a huge problem, and since they don't want to limit _that_ kind 
of usage, they automatically also cannot limit the ASP kind of usage which 
really is exactly the same thing.

So I actually think that an ASP clause would be totally unacceptable to a 
lot of people, even more so than the stupid anti-Tivo clauses. And I think 
the FSF realized that, and didn't even push it, even though they have been 
talking about the "ASP hole" when they don't like it.

So it really does boil down to a very simple end result (which is the 
exact same deal that I think the whole anti-DRM problem has been about):

 - Not everybody agrees about the current GPLv2

 - But trying to extend the reach of it just causes more (fundamental) 
   problems than the problems such extensions would try to fix.

So I'd like to repeat: the reason the GPLv2 is wonderful is exactly the 
fact that it's so widely applicable, and useful for such a wide audience. 
That _does_ mean that it will inevitably have to accept a certain level of 
bad behaviour by selfish people, but since you can't distribute the 
derived work without distributing the source code, you're guaranteed that 
the bad behaviour cannot "procreate". 

In other words: if you think of open source development as a kind of 
"sexual reproduction" (it really does have a lot of analogies - it's a 
"memetic recombination and survival of the fittest"), any "bad use" by 
definition is a dead end. You can be bad, but a bad use is always a 
eunuch, and as such doesn't matter in the long run. The only way you can 
actually make a _difference_ is by participating constructively.

In other words: I do agree that the "ASP hole" is a hole, but exactly as 
with all the Tivo issues, it's a hole that needs to be there simply 
because trying to plug it would cause disaster.

			Linus
