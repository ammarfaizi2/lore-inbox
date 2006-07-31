Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWGaN3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWGaN3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 09:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWGaN3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 09:29:55 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:23237 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750705AbWGaN3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 09:29:54 -0400
Message-Id: <200607311328.k6VDScg6003611@laptop13.inf.utfsm.cl>
To: Hans Reiser <reiser@namesys.com>
cc: David Masover <ninja@slaphack.com>, Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion) 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Fri, 28 Jul 2006 19:36:07 CST." <44CABB87.3050509@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 31 Jul 2006 09:28:38 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 31 Jul 2006 09:28:39 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
> David Masover wrote:
> > If indeed it can be changed easily at all.  I think the burden is on
> > you to prove that you can change it to be more generic, rather than
> > saying "Well, we could do it later, if people want us to..."

> None of the filesystems other than reiser4 have any interest in using
> plugins,

Then they are probably nonsense...

>          and this whole argument over how it should be in VFS is
> nonsensical because nobody but us has any interest in using the
> functionality.  The burden is on the generic code authors to prove that
> they will ever ever do anything at all besides complain.  Frankly, I
> don't think they will.  I think they will never produce one line of code.

It is /your/ burden to show that they are worthwhile. And if they are, thay
aren't worthwhile only in your pet filesystem...

> Please cite one ext3 developer who is signed up to implement ext3 using
> plugins if they are supported by VFS.

Have you asked?

> >> .  It also prevents users from getting
> >> advances they could be getting today, for no reason.

> > It prevents users from doing nothing.

> Most users not only cannot patch a kernel, they don't know what a patch
> is.  It most certainly does. 

Simple answer: Fork the kernel with all your grandiose plans, and see which
one wins. Open source, remember? It is not as if your only chance is to get
it into the official kernel.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
