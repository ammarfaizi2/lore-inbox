Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSGUUlR>; Sun, 21 Jul 2002 16:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313537AbSGUUlQ>; Sun, 21 Jul 2002 16:41:16 -0400
Received: from hub-r.franken.de ([194.94.249.2]:49423 "EHLO hub-r.franken.de")
	by vger.kernel.org with ESMTP id <S313558AbSGUUlN>;
	Sun, 21 Jul 2002 16:41:13 -0400
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
From: Ernst Lehmann <lehmann@acheron.franken.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020720205520.GX29001@khan.acc.umu.se>
References: <OF918E6F71.637B1CBC-ON85256BFB.004CDDD0@pok.ibm.com>
	 <1027199147.16819.39.camel@irongate.swansea.linux.org.uk>
	 <1027197028.26159.2.camel@UberGeek.digitalroadkill.net>
	 <20020720205520.GX29001@khan.acc.umu.se>
Content-Type: text/plain
Organization: 
Message-Id: <1027284252.10069.2.camel@hadley>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 21 Jul 2002 22:44:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-20 at 22:55, David Weinehall wrote:
> On Sat, Jul 20, 2002 at 03:30:29PM -0500, Austin Gonyou wrote:
> > On Sat, 2002-07-20 at 16:05, Alan Cox wrote:
> > ...
> > > > > Do you think the breakdown is realistic?
> > > > >
> > > > > -- Guillaume
> > > > 
> > > > o EVMS (Enterprise Volume Management System)      (EVMS team)
> > > 
> > > or LVM2, which already appears to be scrubbed down and clean
> > 
> > Just IMHO, LVM2 makes better sense as there currently is no "stable"
> > module for XFS in EVMS, AFAIK.
> > Also, LVM is currently in 2.4 and a lot of peopel use it, LVM2 seems to
> > be the proper progression for 2.6. My $0.02
> 
> I'd rather see the EVMS go in, if a choice has to be made between the
> two. EVMS seems to have a lot of effort put in it, and has the
> experience from the (very good) volume-managers that IBM have in OS/2
> and AIX.
> 
> Afaik, EVMS supports LVM volumes. As for XFS, I'm sure an XFS module can
> be produced for EVMS (then again, XFS isn't merged yet either...)
> 
Hmm, the XFS-module for EVMS is only comsetic. Because you can youe XFS
on EVMS right now.

I think the best will be to move both in the kernel, and if that is too
much :)) Then choose EVMS, because it is all under one hat. LVM and Raid
Management.

So my vote is on EVMS...
> 
> Regards: David Weinehall
>   _                                                                 _
>  // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
> //  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
> \>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Bye	
	Ernst


-- 
Ernst Lehmann <lehmann@acheron.franken.de>

