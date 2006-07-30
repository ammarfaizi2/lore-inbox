Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWG3SnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWG3SnI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWG3SnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:43:07 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:56031 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932425AbWG3SnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:43:06 -0400
Message-Id: <200607301841.k6UIfO1P004213@laptop13.inf.utfsm.cl>
To: Hans Reiser <reiser@namesys.com>
cc: David Masover <ninja@slaphack.com>, Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion) 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Fri, 28 Jul 2006 07:34:36 CST." <44CA126C.7050403@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Sun, 30 Jul 2006 14:41:24 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 30 Jul 2006 14:41:36 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
> Let me put it from my perspective and stop pretending to be unbiased, so
> others can see where I am coming from.

OK, but /that/ was pretty clear from day one...

>                                         No one was interested in our
> plugins.

Should tell you something...

>           We put the design on a website, spoke at conferences, no one
> but users were interested.

Again, should tell you something... "Look, a cool new gadget nobody ever
imagined before" sure attracts lots of people. Intriguing. Play around a
bit. Go for next "last novel gadget". Rinse, repeat.

>                             No one would have conceived of having
> plugins if not for us.

Perhaps because nobody else sees any sense in them?

>                         Our plugins affect no one else.

Wrong. Others will want plugins if they are any use, at the very least. And
then there is the possibility of /massive/ maintainance problems ("So, you
/are/ using Reiser 4, the broken file has attached plugin A version 5.3,
and is reached through a "directory" with plugin D 3.4rc5, and ..."). /I/
wouldn't want to be at the receiving end of bug reports which after a dozen
rounds boil down to this.

>                                                          Our
> self-contained code should not be delayed

Not your call to make.

>                                           because other people delayed
> getting interested in our ideas and now they don't want us to have an
> advantage from leading.

Your problem, not Linux'.

>                          If they want to some distant day implement
> generic plugins, for which they have written not one line of code to
> date, fine, we'll use it when it exists, but right now those who haven't
> coded should get out of the way of people with working code.

But they are! Just branch the kernel, and be done with it.

>                                                               It is not
> fair or just to do otherwise.

/You/ are asking the kernel developers for a /huge/ favor. Even totally go
out of their ways, and acting contrary to their set ways and beliefs.
Saying "no" to that can't be called "unfair"...

>                                It also prevents users from getting
> advances they could be getting today, for no reason.

OK, so you have /never/ seen any reasons given here for not placing Reiser
4 into the kernel? Strange...

>                                                       Our code will not
> be harder to change once it is in the kernel, it will be easier, because
> there will be more staff funded to work on it.

Right. Just like Reiser 3 right now.

> As for this "we are all too grand to be bothered with money to feed our
> families" business, building a system in which those who contribute can
> find a way to be rewarded is what managers do.   Free software
> programmers may be willing to live on less than others, but they cannot
> live on nothing, and code that does not ever ship means living on
> nothing.

Then go do something else...

> If reiser4 is delayed enough, for reasons that have nothing to do with
> its needs, and without it having encumbered anyone else, it won't be
> ahead of the other filesystems when it ships.

How is that important in any way for the Linux kernel? This is not (and has
not been for quite some time now) an experimental operating system. And it
has /never/ been a dumpling ground for the next grand idea, it has always
been about sound engineering.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

