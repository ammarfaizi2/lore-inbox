Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281697AbRKQEOU>; Fri, 16 Nov 2001 23:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281698AbRKQEOK>; Fri, 16 Nov 2001 23:14:10 -0500
Received: from think.faceprint.com ([166.90.149.11]:50335 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S281697AbRKQEOC>; Fri, 16 Nov 2001 23:14:02 -0500
Date: Fri, 16 Nov 2001 23:11:41 -0500
To: Dave Jones <davej@suse.de>
Cc: Jeff Golds <jgolds@resilience.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
Message-ID: <20011116231141.A3030@faceprint.com>
In-Reply-To: <3BF5952E.E73BB648@resilience.com> <Pine.LNX.4.30.0111162353140.32578-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0111162353140.32578-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.23i
From: faceprint@faceprint.com (Nathan Walp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Whats probably closer to the truth is..
>=20
>   make cpu
>      |
>   smp tests run ok ? ------> No, sell as XP
>      |
>   yes, sell as MP
>=20

Actually, it's probably closer to:

   make cpu
      |
   smp tests run ok? -------> No, sell as XP
      |
   yes, do we have more demand
   for XPs than we have supply
   of those that didn't pass? -------> Yes, sell as XP
      |
   No, sell as MP

Remember, AMD is just trying to make a buck.  If they've got a bunch of
MP CPUs "sitting on the shelves" while no one can get their hands on the
XPs, some of those MPs are going to "become" XPs.  For those of us on a
budget, we can only hope to get one of *those* variety of XPs.

Now, that said, I'm probably going to buy MPs when I build my machine,
as long as the price difference stays as the current low levels.
Consider it a "warranty" or something.

Just my $0.02

Nathan

--=20
Nathan Walp             || faceprint@faceprint.com
GPG Fingerprint:        ||   http://faceprint.com/
5509 6EF3 928B 2363 9B2B  DA17 3E46 2CDC 492D DB7E


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE79eN9PkYs3Ekt234RAsKIAKCULjeXgjZj5lV2eLetrrkSaCny3QCgzWtT
RA4B8QHjeh2E7CKstqYuXFA=
=tjyQ
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
