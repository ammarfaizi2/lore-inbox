Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318876AbSICQ3t>; Tue, 3 Sep 2002 12:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318877AbSICQ3t>; Tue, 3 Sep 2002 12:29:49 -0400
Received: from pD9E23EAA.dip.t-dialin.net ([217.226.62.170]:20864 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318876AbSICQ3q>; Tue, 3 Sep 2002 12:29:46 -0400
Date: Tue, 3 Sep 2002 10:34:17 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Oliver Pitzeier <o.pitzeier@uptime.at>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Leslie Donaldson <donaldlf@cs.rose-hulman.edu>,
       <axp-kernel-list@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.5.33 successfully compiled
In-Reply-To: <200209031818.16140.o.pitzeier@uptime.at>
Message-ID: <Pine.LNX.4.44.0209031032470.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 3 Sep 2002, Oliver Pitzeier wrote:
> No. It seems simply missing. In 2.5.32 it is there. On the right place. :o))))

Then copy it from 2.5.32 rather than from i386.

> > > > process.c: In function `alpha_clone':
> > > > process.c:268: too few arguments to function `do_fork'
> > > > process.c: In function `alpha_vfork':
> > > > process.c:277: too few arguments to function `do_fork'
> > > > make[1]: *** [process.o] Error 1
> > > > make[1]: Leaving directory
> >
> > Yes, the syntax changed.
> 
> I saw. But how should it be called now from within process.c?

What about += NULL? I'm not sure, but it may work.

The only thing that makes me sad is the other two zeroes. They simply seem 
down and out.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

