Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263186AbTCWUZa>; Sun, 23 Mar 2003 15:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263190AbTCWUZa>; Sun, 23 Mar 2003 15:25:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6921 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263186AbTCWUZY>; Sun, 23 Mar 2003 15:25:24 -0500
Date: Sun, 23 Mar 2003 21:36:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, Pavel Machek <pavel@ucw.cz>,
       szepe@pinerecords.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030323203628.GA16025@atrey.karlin.mff.cuni.cz>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <1048448838.1486.12.camel@phantasy.awol.org> <20030323195606.GA15904@atrey.karlin.mff.cuni.cz> <1048450211.1486.19.camel@phantasy.awol.org> <402760000.1048451441@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402760000.1048451441@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Do not get me wrong, I think users can and should compile their own
> > kernel if they want.  And as kernel developers, we should facilitate
> > that.  But if someone requires handholding and instant or controlled
> > releases of bug fixes, they either need to be able to rely on their own
> > ability to get them or their vendor.  We have vendors for a reason,
> > after all.
> 
> If that's people's attitude ("you should use a vendor"), then we
> need a 

I believe sentence "you should use a vendor kernel" schould be banned
on this list ;-).

How badly would releasing 2.4.21 which does not have 2.4.20-preX as a
parent mess version control systems?  
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
