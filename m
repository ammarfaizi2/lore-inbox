Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130075AbQLNE6r>; Wed, 13 Dec 2000 23:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131417AbQLNE6h>; Wed, 13 Dec 2000 23:58:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:41419 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130075AbQLNE6a>;
	Wed, 13 Dec 2000 23:58:30 -0500
Date: Wed, 13 Dec 2000 23:28:02 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chip Salzenberg <chip@valinux.com>
cc: linux-kernel@vger.kernel.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <20001213202348.J864@valinux.com>
Message-ID: <Pine.GSO.4.21.0012132325530.6300-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Chip Salzenberg wrote:

> According to Alexander Viro:
> > 9P is quite simple and unlike CORBA it had been designed for taking
> > kernel stuff to userland.  Besides, authors definitely understand
> > UNIX...
> 
> As nice as 9P is, it'll need some tweaks to work with Linux.
> For example, it limits filenames to 30 characters; that's not OK.

For RPC-style uses? Why?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
