Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNRUE>; Thu, 14 Dec 2000 12:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQLNRTy>; Thu, 14 Dec 2000 12:19:54 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:59654 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S129260AbQLNRTi>;
	Thu, 14 Dec 2000 12:19:38 -0500
Date: Thu, 14 Dec 2000 10:49:47 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Alexander Viro <viro@math.psu.edu>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012141442390.1437-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0012141048190.26708-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 1. kORBit adds about 150k of code to the 2.4t10 kernel.
> > 2. kNFS adds about 100k of code to the 2.4t10 kernel.

> So can you implement a kNFS server in kORBit that takes
> less than 50kB of RAM?  Otherwise it's still a contributor
> to bloat and this argument won't work ;)

Actually the kORBitNFS server would have to take -50K of code to break
even.  :)  The point was that kORBit lets you do a lot more... so
hopefully that 50k of generality gives you something.  :)

> I guess it's time to stop the flaming and to see what can
> be achieved using kORBit. The people who favour kORBit should
> IMHO be left alone and given the opportunity to show what can
> be achieved with kORBit ... if they don't achieve anything,
> the nay-sayers can always claim their "victory"; if something
> useful comes out the kORBit people can claim usefulness.

Agreed!

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
