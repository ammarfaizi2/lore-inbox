Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262002AbSIYPZ2>; Wed, 25 Sep 2002 11:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSIYPZ2>; Wed, 25 Sep 2002 11:25:28 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:63873 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262002AbSIYPZ1>; Wed, 25 Sep 2002 11:25:27 -0400
Date: Wed, 25 Sep 2002 09:30:40 -0600
Message-Id: <200209251530.g8PFUeI13628@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [BUG] NFS in 2.4.20-pre6+ stalls
In-Reply-To: <200209251441.37444.trond.myklebust@fys.uio.no>
References: <200209251441.37444.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust writes:
> >   Hi, all. Just noticed this with 2.4.20-pre6 (and -pre7): NFS write
> > sometimes (usually) stalls for minutes at a time. This problem wasn't
> 
> Richard,
>   Does the appended patch make a difference?

Monday afternoon (my time) I grabbed the current BK tree and have been
using it since then. The problem has been reduced. I thought it was
fixed, but just as I sent this message, I tried my little test again,
and in one of the three runs I had a 21 second stall. I waited a few
minutes between tests.

Is your patch meant for the latest BK tree? Or something older?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
