Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131132AbQLNEzo>; Wed, 13 Dec 2000 23:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131995AbQLNEze>; Wed, 13 Dec 2000 23:55:34 -0500
Received: from nat-dial-160.valinux.com ([198.186.202.160]:36595 "EHLO
	tytlal.z.streaker.org") by vger.kernel.org with ESMTP
	id <S131968AbQLNEzZ>; Wed, 13 Dec 2000 23:55:25 -0500
Date: Wed, 13 Dec 2000 20:23:49 -0800
From: Chip Salzenberg <chip@valinux.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Lattner <sabre@nondot.org>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
Message-ID: <20001213202348.J864@valinux.com>
In-Reply-To: <E146Mvx-0003Zj-00@the-village.bc.nu> <Pine.GSO.4.21.0012132037110.6300-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0012132037110.6300-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Dec 13, 2000 at 08:48:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Alexander Viro:
> 9P is quite simple and unlike CORBA it had been designed for taking
> kernel stuff to userland.  Besides, authors definitely understand
> UNIX...

As nice as 9P is, it'll need some tweaks to work with Linux.
For example, it limits filenames to 30 characters; that's not OK.
-- 
Chip Salzenberg            - a.k.a. -            <chip@valinux.com>
   "Give me immortality, or give me death!"  // Firesign Theatre
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
