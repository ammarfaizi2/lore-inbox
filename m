Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263344AbREXCTh>; Wed, 23 May 2001 22:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263345AbREXCTQ>; Wed, 23 May 2001 22:19:16 -0400
Received: from biglinux.tccw.wku.edu ([161.6.10.206]:50580 "EHLO
	biglinux.tccw.wku.edu") by vger.kernel.org with ESMTP
	id <S263344AbREXCTN>; Wed, 23 May 2001 22:19:13 -0400
Date: Wed, 23 May 2001 21:19:01 -0500 (CDT)
From: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
To: "David N. Lombard" <david.lombard@mscsoftware.com>
cc: Patric Mrawek <mrawek@punkt.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Boot Problem
In-Reply-To: <3B0C21C6.A78FEDB6@mscsoftware.com>
Message-ID: <Pine.LNX.4.30.0105232116450.30122-100000@biglinux.tccw.wku.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > sometimes one of my servers doesn't boot correctly. Lilo reads the
> > kernel-image, but doesn't decompress it. So the system won't
> > continue booting.
> >
> > Looks like:
> > Loading linux...................
> > (at this point the machine freezes)
>
> Our experience of this has been with suspect hardware.  It was our first
> (pre-release) P4 system, so we puzzled over it for a short while; later
> testing on other P4 systems showed no such problem.

My machines have produced this result with memory sticks that needed to be
reseated.  Might make sure everything is seated down and all the contacts
are clean.

Brent Norris

Executive Advisor -- WKU-Linux

System Administrator -- WKU-Center for Biodiversity
                        Best Mechanical


