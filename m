Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317511AbSGTUwd>; Sat, 20 Jul 2002 16:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317512AbSGTUwc>; Sat, 20 Jul 2002 16:52:32 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:12024 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S317511AbSGTUwa>;
	Sat, 20 Jul 2002 16:52:30 -0400
Date: Sat, 20 Jul 2002 22:55:20 +0200
From: David Weinehall <tao@acc.umu.se>
To: Austin Gonyou <austin@digitalroadkill.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Peloquin <peloquin@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020720205520.GX29001@khan.acc.umu.se>
References: <OF918E6F71.637B1CBC-ON85256BFB.004CDDD0@pok.ibm.com> <1027199147.16819.39.camel@irongate.swansea.linux.org.uk> <1027197028.26159.2.camel@UberGeek.digitalroadkill.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027197028.26159.2.camel@UberGeek.digitalroadkill.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2002 at 03:30:29PM -0500, Austin Gonyou wrote:
> On Sat, 2002-07-20 at 16:05, Alan Cox wrote:
> ...
> > > > Do you think the breakdown is realistic?
> > > >
> > > > -- Guillaume
> > > 
> > > o EVMS (Enterprise Volume Management System)      (EVMS team)
> > 
> > or LVM2, which already appears to be scrubbed down and clean
> 
> Just IMHO, LVM2 makes better sense as there currently is no "stable"
> module for XFS in EVMS, AFAIK.
> Also, LVM is currently in 2.4 and a lot of peopel use it, LVM2 seems to
> be the proper progression for 2.6. My $0.02

I'd rather see the EVMS go in, if a choice has to be made between the
two. EVMS seems to have a lot of effort put in it, and has the
experience from the (very good) volume-managers that IBM have in OS/2
and AIX.

Afaik, EVMS supports LVM volumes. As for XFS, I'm sure an XFS module can
be produced for EVMS (then again, XFS isn't merged yet either...)


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
