Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129744AbQLINAQ>; Sat, 9 Dec 2000 08:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130393AbQLINAG>; Sat, 9 Dec 2000 08:00:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:20720 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129744AbQLIM77>;
	Sat, 9 Dec 2000 07:59:59 -0500
Date: Sat, 9 Dec 2000 07:29:30 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        Chris Lattner <sabre@nondot.org>, linux-kernel@vger.kernel.org,
        orbit-list@gnome.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <E144ifI-0005IB-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0012090706270.29053-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Dec 2000, Alan Cox wrote:

> > Yeah... "Infinitely extendable API" and all such. Roughly translated
> > as "we can't live without API bloat". Frankly, judging by the GNOME
                                                   ^^^^^^^^^^^^^^^^^^^^
> > codebase people who designed the thing are culturally incompatible with
    ^^^^^^^^
> > UNIX.
> 
> Oh they are definitely unix people, but ORBit is about solving a very 
> different sort of problem to scribbling bits on a disk, or it was until very
> crazy people got involved

<shrug> From what I've seen in GNOME it's mostly about avoiding pipes
religiously and putting everything and a kitchen sink into the same
process. I'm not saying that it has no valid uses, but it definitely
had contributed to the bloat in case of GNOME.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
