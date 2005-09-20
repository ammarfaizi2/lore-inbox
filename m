Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbVITSSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbVITSSg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVITSSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:18:36 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:24990 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964967AbVITSSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:18:35 -0400
Message-Id: <200509201817.j8KIHcMK001086@laptop11.inf.utfsm.cl>
To: David Masover <ninja@slaphack.com>
cc: Pavel Machek <pavel@suse.cz>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel 
In-Reply-To: Message from David Masover <ninja@slaphack.com> 
   of "Tue, 20 Sep 2005 09:41:36 EST." <43301FA0.7030906@slaphack.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 20 Sep 2005 14:17:38 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 20 Sep 2005 14:17:39 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> wrote:
> Pavel Machek wrote:
> >>V3 is obsoleted by V4 in every way.  V3 is old code that should be
> >>marked as deprecated as soon as V4 has passed mass testing.   V4 is far
> >>superior in its coding style also.  Having V3 in and V4 out is at this
> >> point just stupid.

> > Really? Last time I checked, even V3's fsck was not too great. [In
> > fact I never could make it run stable enough to even _test_ it
> > properly].
> > Do you have working fsck for V4?

> Already saved me once.  But then, I should have had backups.

And if you haven't? Backing up 200+ GiB is no peanuts...

> And personally, if it was my FS, I'd stop working on fsck after it was
> able to "check".  That's what it's for.  To fix an FS, you wipe it and
> restore from backups.

Remind me /never/ to go near a filesystem you are in any way involved with.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
