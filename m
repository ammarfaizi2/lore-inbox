Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWHAOaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWHAOaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWHAOaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:30:21 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:12704 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751587AbWHAOaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:30:20 -0400
Message-Id: <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>
To: Bernd Schubert <bernd-schubert@gmx.de>
cc: reiserfs-list@namesys.com, Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Clay Barnes <clay.barnes@gmail.com>,
       Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion 
In-Reply-To: Message from Bernd Schubert <bernd-schubert@gmx.de> 
   of "Mon, 31 Jul 2006 23:14:37 +0200." <200607312314.37863.bernd-schubert@gmx.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Tue, 01 Aug 2006 10:28:18 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 01 Aug 2006 10:28:26 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schubert <bernd-schubert@gmx.de> wrote:
> On Monday 31 July 2006 21:29, Jan-Benedict Glaw wrote:
> > The point is that it's quite hard to really fuck up ext{2,3} with only
> > some KB being written while it seems (due to the
> > fragile^Wsophisticated on-disk data structures) that it's just easy to
> > kill a reiser3 filesystem.

> Well, I was once very 'luckily' and after a system crash (*) e2fsck put
> all files into lost+found. Sure, I never experienced this again, but I
> also never experienced something like this with reiserfs. So please, stop
> this kind of FUD against reiser3.6.

It isn't FUD. One data point doesn't allow you to draw conclusions.

Yes, I've seen/heard of ext2/ext3 failures and data loss too. But at least
the same number for ReiserFS. And I know it is outnumbered 10 to 1 or so in
my sample, so that would indicate at a 10 fold higher probability of
catastrophic data loss, other factors mostly the same.

> While filesystem speed is nice, it also would be great if reiser4.x would be 
> very robust against any kind of hardware failures.

Can't have both.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
