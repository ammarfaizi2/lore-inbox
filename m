Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbVGIA3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbVGIA3M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbVGIA1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:27:25 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:50410 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S263024AbVGIA0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:26:50 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Ed Cogburn <edcogburn@hotpop.com>
Subject: Re: reiser4 vs politics: linux misses out again
Date: Fri, 8 Jul 2005 20:26:48 -0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507040211.j642BL6f005488@laptop11.inf.utfsm.cl> <028601c581a0$cb1f3e20$2800000a@pc365dualp2> <dan077$n4t$1@sea.gmane.org>
In-Reply-To: <dan077$n4t$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507082026.49404.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 July 2005 18:59, Ed Cogburn wrote:
> cutaway@bellsouth.net wrote:
> >
> > In reality is it doesn't count.  Users don't care what level of pain is
> > involved in producing the products they use.
> > 
> > Development efforts and results for OS's are always just taken for
> > granted.
> > 
> > BTDT - if you're very lucky, a (very) few non-programming users might
> > notice something nice and mention that they noticed a difference.  The 
> > majority are still struggling to find the power switch ;->
> 
> 
> You no longer have to be a kernel dev to see that there is more to the
> resistance to R4 than objective technical issues, anyone with an
> understanding of English whose been reading the R4
> debates-that-quickly-turn-into-flame-wars the last couple of years here can
> see that.  For you guys to continue to suggest otherwise only makes you out
> to be the fools, not the "lusers" (which you obviously define as anyone who
> isn't a kernel dev).
> 
> So be my guest, ignore the message and attack the messenger, I didn't
> respond to start yet another flamewar, nor did I really expect much
> objectivity anyway, as that's been thrown out the window even in
> discussions between developers, e.g. the R4 plugins thread.
> 
> If its a fork of the kernel that you really want, so be it.  When it
> happens, and given the increasing divergence going on between the
> commercial distros and the vanilla kernel, maybe it's already begun, I'll
> use the one that isn't afraid of giving new ideas a chance.
> 
> Flame away, I'm done.

No Flame from me.  One thing to remember is that Hans and friends _have_ supported
R3 for years.  This is an undisputed fact.  Second third parties have be able to add much
function (like journaling) to R3 so the code must be sort of readable...  With R4 they have
created a new FS that is _fast_ and _can_ do things no other FS can - I also expect they have
written cleaner code...  Why are we fighting about adding this sort of function to the kernel?  
Yes it may not be the absolute best way to do things.  How many times has tcpip be rewritten 
for linux?  The answer is more than once.  Lets put R4 in, see how it works, generalize the ideas 
and if we have to rewrite and rethink part of it lets do so.  

Please do add R4 to the kernel!

Thanks,

Ed Tomlinson 
