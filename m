Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVF2RcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVF2RcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVF2RYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:24:41 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45284 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262251AbVF2RXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:23:31 -0400
Message-Id: <200506291719.j5THJCSg011438@laptop11.inf.utfsm.cl>
To: mjt@nysv.org (Markus T rnqvist)
cc: Douglas McNaught <doug@mcnaught.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from mjt@nysv.org (Markus T rnqvist) 
   of "Wed, 29 Jun 2005 16:58:20 +0300." <20050629135820.GJ11013@nysv.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 29 Jun 2005 13:19:12 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 29 Jun 2005 13:19:24 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Törnqvist <mjt@nysv.org> wrote:

[...]

> Note that MacOS has the monopoly on what they ship, Linux has a
> motherload of file managers and window systems and all.

Yep. Part of what is nice about it, too ;-)

> What pisses me off is the fact that Gnome and friends implement
> their own incompatible-with-others VFS's and automounters and
> stuff.

Then get them to agree on a common framework! They are trying hard to get
other parts of the GUI work well together, so this isn't far off in
wishfull thinking land.

> Surely supporting this in the kernel and extending the LSB
> to require this is the best step to take without infringing
> anyone's freedom as such.

Right. So then we have Gnome's way of doing things (Gnome isn't just for
Linux!), KDE's way, XFCE's way, ... (ditto). Plus the kernel way. Flambee
with a monthly thread on all reachable fora about "Why on &%@# does the
%&~#@ GUI not use the *#%&@ kernel's way?!".

This is /not/ the way of fxing that particular problem. Shoving random
stuff into the kernel /can't/ force its use. At least not until Linux is
the only Unixy system around, and that is still some way off. And when that
has happened, the kernel's way must be /clearly/ better for /all/ users, or
it won't matter.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

