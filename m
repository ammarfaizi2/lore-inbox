Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262232AbSJNWwI>; Mon, 14 Oct 2002 18:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262234AbSJNWwI>; Mon, 14 Oct 2002 18:52:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38567 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262232AbSJNWwG>;
	Mon, 14 Oct 2002 18:52:06 -0400
Date: Mon, 14 Oct 2002 18:57:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Oliver Neukum <oliver@neukum.name>
cc: Shawn <core@enodev.com>, Christoph Hellwig <hch@infradead.org>,
       Michael Clark <michael@metaparadigm.com>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
In-Reply-To: <200210150035.14923.oliver@neukum.name>
Message-ID: <Pine.GSO.4.21.0210141842110.6505-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Oct 2002, Oliver Neukum wrote:

> 
> > If neither LVM2 or EVMS are truly ready, no one is beholden to anyone
> > else as to anything's inclusion in mainline.
> >
> > It's a matter of marketing so say whether Linux has volume management.
> > If all the distros have LVM in some form, then "Linux has an LVM". So,
> > no one can really say "Linux doesn't have an LVM so it's not enterprise
> > ready.
> 
> This is not true. Something has to be in the mainline, so that bugs can
> be fixed. This too important to be left to distributors.
> 
> Besides people who compile their own kernels are not that unimportant.

As for the bugs getting fixed, one of the main problems with EVMS merge
now is that it (as any merge) shifts part of that very burden from EVMS
maintainers to other developers *and* *it* *shifts* *too* *much*.

That's what "ready to be merged" boils down to.  It's a question of how
many problems will be inflicted by the merge upon current and future
development - over all kernel.  AFAICS in its current state EVMS is not
ready.  And yes, it means that EVMS maintainers get to play catch up for
a while.  Nobody refuses to help them, BTW.

