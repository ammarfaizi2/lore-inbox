Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132289AbQLNFPR>; Thu, 14 Dec 2000 00:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132446AbQLNFPH>; Thu, 14 Dec 2000 00:15:07 -0500
Received: from nat-dial-160.valinux.com ([198.186.202.160]:41203 "EHLO
	tytlal.z.streaker.org") by vger.kernel.org with ESMTP
	id <S132289AbQLNFPD>; Thu, 14 Dec 2000 00:15:03 -0500
Date: Wed, 13 Dec 2000 20:42:39 -0800
From: Chip Salzenberg <chip@valinux.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
Message-ID: <20001213204239.L864@valinux.com>
In-Reply-To: <20001213202348.J864@valinux.com> <Pine.GSO.4.21.0012132325530.6300-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0012132325530.6300-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Dec 13, 2000 at 11:28:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Alexander Viro:
> On Wed, 13 Dec 2000, Chip Salzenberg wrote:
> > According to Alexander Viro:
> > > 9P is quite simple and unlike CORBA it had been designed for taking
> > > kernel stuff to userland.  Besides, authors definitely understand
> > > UNIX...
> > 
> > As nice as 9P is, it'll need some tweaks to work with Linux.
> > For example, it limits filenames to 30 characters; that's not OK.
> 
> For RPC-style uses? Why?

For the same reason C compilers recognize more than eight significant
characters in externals, even though ANSI doesn't require them to.
-- 
Chip Salzenberg            - a.k.a. -            <chip@valinux.com>
   "Give me immortality, or give me death!"  // Firesign Theatre
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
