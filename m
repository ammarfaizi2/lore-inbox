Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLNRSO>; Thu, 14 Dec 2000 12:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQLNRSD>; Thu, 14 Dec 2000 12:18:03 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:61683 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129267AbQLNRRx>; Thu, 14 Dec 2000 12:17:53 -0500
Date: Thu, 14 Dec 2000 14:45:03 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Chris Lattner <sabre@nondot.org>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Alexander Viro <viro@math.psu.edu>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012131755030.24165-100000@www.nondot.org>
Message-ID: <Pine.LNX.4.21.0012141442390.1437-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Chris Lattner wrote:

> 1. kORBit adds about 150k of code to the 2.4t10 kernel.
> 2. kNFS adds about 100k of code to the 2.4t10 kernel.
> 3. kORBit can do everything kNFS does, plus a WHOLE lot more: For example
>    implement an NFS like server that uses SSL to send files and
>    requests... so it is really actually "secure".

So can you implement a kNFS server in kORBit that takes
less than 50kB of RAM?  Otherwise it's still a contributor
to bloat and this argument won't work ;)

I guess it's time to stop the flaming and to see what can
be achieved using kORBit. The people who favour kORBit should
IMHO be left alone and given the opportunity to show what can
be achieved with kORBit ... if they don't achieve anything,
the nay-sayers can always claim their "victory"; if something
useful comes out the kORBit people can claim usefulness.

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
