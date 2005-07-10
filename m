Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVGJFxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVGJFxh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 01:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVGJFxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 01:53:36 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:26779 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261850AbVGJFxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 01:53:36 -0400
Message-Id: <200507100510.j6A5ATun010304@laptop11.inf.utfsm.cl>
To: Ed Cogburn <edcogburn@hotpop.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: reiser4 vs politics: linux misses out again 
In-Reply-To: Message from Ed Cogburn <edcogburn@hotpop.com> 
   of "Fri, 08 Jul 2005 23:25:39 -0400." <danen6$h3p$1@sea.gmane.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 10 Jul 2005 01:10:29 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Cogburn <edcogburn@hotpop.com> wrote:
> David Lang wrote:
> > On Fri, 8 Jul 2005, Ed Tomlinson wrote:

> >> No Flame from me.  One thing to remember is that Hans and friends
> >> _have_ supported R3 for years.

They let it fall into disrepair when they started work on 4.

> >>                                This is an undisputed fact.

Exactly.

> >>                                                            Second
> >> third parties have be able to add much function (like journaling)
> >> to R3 so the code must be sort of readable...

Why don't you check it? Wouldn't you much prefer if the original authors
(or somebody similarly initmate with the code) did mayor surgery on it?
Specially if it is something you depend on?

> >> With R4 they have created a new FS that is _fast_

Remains to be seen.

> >>                                                   and _can_ do things
> >> no other FS can

Mostly useless things...

> >>                  - I also expect they have written cleaner code...

Better check first.

> >> Why are we fighting about adding this sort of function to the kernel?

Because the filessytem experts in the kernel development crowd (and others)
have /serious/ problems with the ideas and the code?

> >> Yes it may not be the absolute best way to do things.  How many times
> >> has tcpip be rewritten for linux?  The answer is more than once.

So?

> >> Lets put R4 in, see how it works, generalize the ideas and if we have
> >> to rewrite and rethink part of it lets do so.

Why not: Let's keep it out, fix the problems that it has and evaluate it
for inclusion once the problems have been ironed out?  That has been the
policy for everything else as far as I can remember (and that is from
nearly the beginning...)

> > remember that Hans is on record (over a year ago) arguing that R3 should
> > not be fixed becouse R4 was replacing it.

> > This type of thing is one of the reasons that you see arguments that
> > aren't 'purely code-related' becouse the kernel folks realize that _they_
> > will have to maintain the code over time, Hans and company will go on and
> > develop R5 (R10, whatever) and consider R4 obsolete and stop maintaining
> > it.

> Maybe its because Hans and Co., having only a finite amount of dev time,
> would much prefer to spend that time on R4 rather than R3?

ext2 is still being maintained alongside ext3.
 
>                                                            Maybe if we
> were to let R4 into the kernel, it wouldn't be long after that R3 could be
> retired because everyone has moved to R4?

ext3 is several years old, and there are /still/ ext2 users around...

[...]

> Devs should be free to work on whatever they want, because most of them are
> doing this on their own time anyway, otherwise they might just decide to
> hack on some other OS, or a fork of Linux instead.

Nobody forces anybody to work on Linux, or even on the standard Linus
kernel. It is the ReiserFS crowd who are demanding something from the Linux
crowd, not the other way around.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
