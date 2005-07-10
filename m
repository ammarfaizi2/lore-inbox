Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVGJMsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVGJMsN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 08:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVGJMsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 08:48:13 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:59334 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261926AbVGJMsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 08:48:11 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Horst von Brand <vonbrand@inf.utfsm.cl>, Hans Reiser <reiser@namesys.com>
Subject: Re: reiser4 vs politics: linux misses out again
Date: Sun, 10 Jul 2005 08:48:04 -0400
User-Agent: KMail/1.8.1
Cc: Ed Cogburn <edcogburn@hotpop.com>, linux-kernel@vger.kernel.org
References: <200507100510.j6A5ATun010304@laptop11.inf.utfsm.cl>
In-Reply-To: <200507100510.j6A5ATun010304@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507100848.05090.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 July 2005 01:10, Horst von Brand wrote:
> Ed Cogburn <edcogburn@hotpop.com> wrote:
> > David Lang wrote:
> > > On Fri, 8 Jul 2005, Ed Tomlinson wrote:
> 
> > >> No Flame from me.  One thing to remember is that Hans and friends
> > >> _have_ supported R3 for years.
> 
> They let it fall into disrepair when they started work on 4.
> 
> > >>                                This is an undisputed fact.
> 
> Exactly.

This is FUD.  Hans do you have figures on how many fixes for R3 have
been added in the last year or so?

> > >>                                                            Second
> > >> third parties have be able to add much function (like journaling)
> > >> to R3 so the code must be sort of readable...
> 
> Why don't you check it? Wouldn't you much prefer if the original authors
> (or somebody similarly initmate with the code) did mayor surgery on it?
> Specially if it is something you depend on?
> 
> > >> With R4 they have created a new FS that is _fast_
> 
> Remains to be seen.
> 
> > >>                                                   and _can_ do things
> > >> no other FS can
> 
> Mostly useless things...

Just because you do not see how to use a new feature does not mean its useless...
 
> > >>                  - I also expect they have written cleaner code...
> 
> Better check first.
> 
> > >> Why are we fighting about adding this sort of function to the kernel?
> 
> Because the filessytem experts in the kernel development crowd (and others)
> have /serious/ problems with the ideas and the code?
> 
> > >> Yes it may not be the absolute best way to do things.  How many times
> > >> has tcpip be rewritten for linux?  The answer is more than once.
> 
> So?
> 
> > >> Lets put R4 in, see how it works, generalize the ideas and if we have
> > >> to rewrite and rethink part of it lets do so.
> 
> Why not: Let's keep it out, fix the problems that it has and evaluate it
> for inclusion once the problems have been ironed out?  That has been the
> policy for everything else as far as I can remember (and that is from
> nearly the beginning...)

When you are exploring new stuff its almost impossible to see the best way to
do things.  Once R4 (and other FSes) use these new features (or not) it will become more
obvious how they should be coded.  As it is not its a bit like trying to decide your
new baby will be a doctor when he/she grows up - its not something you can
predict.

> > > remember that Hans is on record (over a year ago) arguing that R3 should
> > > not be fixed becouse R4 was replacing it.
> 
> > > This type of thing is one of the reasons that you see arguments that
> > > aren't 'purely code-related' becouse the kernel folks realize that _they_
> > > will have to maintain the code over time, Hans and company will go on and
> > > develop R5 (R10, whatever) and consider R4 obsolete and stop maintaining
> > > it.
> 
> > Maybe its because Hans and Co., having only a finite amount of dev time,
> > would much prefer to spend that time on R4 rather than R3?
> 
> ext2 is still being maintained alongside ext3.

And so is R3 - just no new features are being added...
 
> >                                                            Maybe if we
> > were to let R4 into the kernel, it wouldn't be long after that R3 could be
> > retired because everyone has moved to R4?
> 
> ext3 is several years old, and there are /still/ ext2 users around...
> 
See above - this should presend NO problems.

> > Devs should be free to work on whatever they want, because most of them are
> > doing this on their own time anyway, otherwise they might just decide to
> > hack on some other OS, or a fork of Linux instead.
> 
> Nobody forces anybody to work on Linux, or even on the standard Linus
> kernel. It is the ReiserFS crowd who are demanding something from the Linux
> crowd, not the other way around.
