Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262343AbSI1Wik>; Sat, 28 Sep 2002 18:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262342AbSI1Wik>; Sat, 28 Sep 2002 18:38:40 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:18051 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262343AbSI1Wik>; Sat, 28 Sep 2002 18:38:40 -0400
Date: Sat, 28 Sep 2002 16:43:58 -0600
Message-Id: <200209282243.g8SMhw232274@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: RE: [BUG] NFS in 2.4.20-pre6+ stalls
In-Reply-To: <15762.61332.832333.272997@charged.uio.no>
References: <200209251441.37444.trond.myklebust@fys.uio.no>
	<200209251530.g8PFUeI13628@vindaloo.ras.ucalgary.ca>
	<15762.61332.832333.272997@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust writes:
> >>>>> " " == Richard Gooch <rgooch@ras.ucalgary.ca> writes:
> 
>      > Monday afternoon (my time) I grabbed the current BK tree and
>      > have been using it since then. The problem has been reduced. I
>      > thought it was fixed, but just as I sent this message, I tried
>      > my little test again, and in one of the three runs I had a 21
>      > second stall. I waited a few minutes between tests.
> 
>      > Is your patch meant for the latest BK tree? Or something older?
> 
> The patch should apply fine to the latest BK tree: there have been no
> recent changes that might affect it.

Well, your patch doesn't make things worse. I tried to reproduce the
problem again, but couldn't. I'm running 2.4.20-pre8 plus your patch,
and will keep an eye on it.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
