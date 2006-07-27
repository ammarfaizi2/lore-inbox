Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWG0N3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWG0N3q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWG0N3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:29:46 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:56227 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932098AbWG0N3p (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:29:45 -0400
Message-Id: <200607271326.k6RDQWRW008048@laptop13.inf.utfsm.cl>
To: Hans Reiser <reiser@namesys.com>
cc: Adrian Bunk <bunk@stusta.de>, andrea@cpushare.com,
       "J. Bruce Fields" <bfields@fieldses.org>,
       Nikita Danilov <nikita@clusterfs.com>, Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Wed, 26 Jul 2006 22:35:26 CST." <44C8428E.4070007@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Thu, 27 Jul 2006 09:26:32 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 27 Jul 2006 09:26:33 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
> Adrian Bunk wrote:
> >[1] the conclusion itself might or might not be true
> >    e.g. there _could_ be an 1:5 ratio between reiser4 and ext3 users
> >    but your data is not in any way able to support or reject this 
> >    statement

> It does however suggest that my surprise at how people at the last 
> Linux Conference I went to all seemed to know that there exists a
> Reiser4

I'd be rather surprised to find someone at a Linux conference who hasn't at
least heard of the recurrent flamewars on the topic here...

>         may be due to it being more widely used than I would have
> guessed.  Maybe there is some coolness factor to having the faster FS
> that you can't get from any Distro that is enough to overcome the hassle
> of compiling reiser4progs and a kernel before inserting the DVD.

Not seen any data backing up the "faster", let alone so much faster that
the hassle (and the risk) would make it worth trying... No, Gentoo folks
don't count, around here they are fond of claiming that their self-compiled
systems are at least twice as fast as a binary distribution with the exact
same software.

>                                                                   I
> would not have guessed we had 1/5th of ext3's usage even among lkml
> readers.....

I'd guess something of the order of 1/100, for testing purposes and idle
curiosity.

>              I guess the market contains more people who like
> technology than I was guessing.  Maybe there is a positive word of mouth
> effect going on too.

LKML (and Linux conferences) are exactly the places where you /only/ find
this kind of people...

> It would be nice if SuSE and others at least made it an unsupported
> option at install time.  I shall have to find the time to go asking them
> all.....

At least Fedora is trying hard to just follow upstream packages (in this
case, Linus' kernels) with the absolute minimum of local patches. It makes
good sense, as it reduces the up-front work, and (more important) minimizes
the pain when the later official version is somehow incompatible with the
previews.

If you want ReiserFS 4 to get more exposure, do the legwork to get it into
the official kernel. Distributions should be reluctant to pick it up as
long as its status as an official Linux filesystem is in question.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
