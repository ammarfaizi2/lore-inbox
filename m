Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283521AbRLDUvX>; Tue, 4 Dec 2001 15:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283479AbRLDUtg>; Tue, 4 Dec 2001 15:49:36 -0500
Received: from staff.staff.osogrande.net ([129.121.5.11]:36106 "HELO
	staff.nm.org") by vger.kernel.org with SMTP id <S283436AbRLDUsl>;
	Tue, 4 Dec 2001 15:48:41 -0500
Date: 4 Dec 2001 13:48:34 -0700
Date: Tue, 4 Dec 2001 13:48:34 -0700 (MST)
From: Todd Underwood <todd@osogrande.com>
To: "M. Edward Borasky" <znmeb@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Over 4-way systems considered harmful :-)
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBCEOJECAA.znmeb@aracnet.com>
Message-ID: <Pine.LNX.4.10.10112041343500.9662-100000@staff>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

folx,

although i agree with the sentiment expressed below, i beg to differ...

On Tue, 4 Dec 2001, M. Edward Borasky wrote:

> Sure, the military guys would *love* to have a petaflop engine, but
> they're gonna build 'em anyway and quite probably not bother to contribute
> their kernel source on this mailing list. *Commercial* applications for
> supercomputers of this level are few and far between. 

the CPlant (http://www.cs.sandia.gov/cplant/) system software (currently
built on top of Linux 2.2 but it's working now on 2.4 as well) is Open
Source (GPL).  CPlant is built by Sandia National Labs (which could be
interpreted as "the military guys" is is currently one of the largest
Linux-based supercomputers in the world.  The source for it is publicly
available and gives some interesting insight to what happens when you try
to scale beyond the "traditional" 32 or 64 processor cluster.

Additionally, the same systems software is being used in at least one big
commercial application (for processing genetic information).

my point here is not that building huge SMP machine makes sense
(obviously, for reasons that have been repeatedly reexplained by others
including Larry McVoy, it doesn't).  my point is just that many parts of
the national security aparatus are playing well in the Linux kernel
development space these days and it's foolish to write them off.

todd underwood, vp & cto
oso grande technologies, inc.
todd@osogrande.com

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin

