Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132546AbRDHMmP>; Sun, 8 Apr 2001 08:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132549AbRDHMmF>; Sun, 8 Apr 2001 08:42:05 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:22658 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132546AbRDHMl6>; Sun, 8 Apr 2001 08:41:58 -0400
Date: Sun, 8 Apr 2001 13:41:50 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Michael Reinelt <reinelt@eunet.at>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        =?iso-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
Message-ID: <20010408134150.D1089@redhat.com>
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <Pine.LNX.4.10.10104071043360.1085-100000@linux.local> <20010407200053.B3280@redhat.com> <3ACF6D1D.63A2A2FE@mandrakesoft.com> <20010407205204.H3280@redhat.com> <3AD05410.495A2BDC@eunet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD05410.495A2BDC@eunet.at>; from reinelt@eunet.at on Sun, Apr 08, 2001 at 02:05:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 08, 2001 at 02:05:36PM +0200, Michael Reinelt wrote:

> The simple solution: Gunters 'multifunction quirks'
> clean solution #1: a new module according to Jeffs sample code
> clean solution #2: 'invisible PCI bridge' from Linus
[...]
> Suggestion: multifunction quirks for 2.4, one of the clean solutions for
> 2.5?

I would rather we went for something in 2.4 and stick with it in 2.5
than changing again. (The parport ID list format changed in 2.2->2.4
already in order to handle subsystem IDs.)

Tim.
*/

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE60FyOONXnILZ4yVIRAq4OAKCVmeYl3ZJRpA9Besx2F0MZJvzTkgCXSSM1
3oW3ALbLA2FJ8Bg1ErTP4A==
=7VTI
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
