Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265016AbRGAGtp>; Sun, 1 Jul 2001 02:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265029AbRGAGtZ>; Sun, 1 Jul 2001 02:49:25 -0400
Received: from secure.hostnoc.net ([66.96.192.200]:27404 "EHLO
	secure.hostnoc.net") by vger.kernel.org with ESMTP
	id <S265016AbRGAGtP>; Sun, 1 Jul 2001 02:49:15 -0400
Date: Sun, 1 Jul 2001 02:47:56 -0400
From: "J. Nick Koston" <nick@burst.net>
To: Chris Siebenmann <cks@utcc.utoronto.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Asus CUV4X-DLS
Message-ID: <20010701024756.A13334@burst.net>
In-Reply-To: <mail.linux.kernel/20010627233541.A32271@burst.net> <01Jun28.041132edt.62285@gpu.utcc.utoronto.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01Jun28.041132edt.62285@gpu.utcc.utoronto.ca>; from cks@utcc.utoronto.ca on Thu, Jun 28, 2001 at 04:11:32AM -0400
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - secure.hostnoc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [1003 1004] / [1003 1004]
X-AntiAbuse: Sender Address Domain - secure.hostnoc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

   I thought it was ok with a 2.4.5-ac kernel however it started
acting up again today giving more i/o errors.  I think I'm just going
to give up on these boards as I have 3 of them doing the exact same
thing.  However they are flawless in up mode.

         Nick

On Thu, Jun 28, 2001 at 04:11:32AM -0400, Chris Siebenmann wrote:
> Envelope-to: nick@burst.net
> Delivery-date: Thu, 28 Jun 2001 04:11:14 -0400
> To:	nick@burst.net ("J. Nick Koston")
> Subject: Re: Asus CUV4X-DLS
> X-Newsgroups: mail.linux.kernel
> In-Reply-To: <mail.linux.kernel/20010627233541.A32271@burst.net>
> Organization: Ziebmef home away from home
> Date:	Thu, 28 Jun 2001 04:11:32 -0400
> From:	Chris Siebenmann <cks@utcc.utoronto.ca>
>=20
> You write:
> | Anyways in case anyone is curious the i/o problem still happens
> | with an aic7xxx card put in and the onboard scsi disabled.
>=20
>  That's odd; our CUV4X-DLS is stable with PCI Adaptec cards in (but the
> onboard Symbios controllers have problems). We're running various -ac
> kernels (2.4.5-ac18 right now), SMP, etc. We currently have three SCSI
> channels and two disks per channel, and it's surviving the VA Linux
> stress tests quite handily.
>=20
> ---
> 	"I shall clasp my hands together and bow to the corners of the world."
> 			Number Ten Ox, "Bridge of Birds"
> cks@utcc.toronto.edu		   				    utgpu!cks

--=20

BurstNET -  The Speed the Internet Travels

To place an order, or for more info, contact;
BurstNET Technologies, Inc. - BurstNET
Toll Free 24/7/365 Support: 1-877-BURSTNET
Phone (570) 389-1100 - Fax (570) 389-1855=3D20
http://www.burst.net - sales@burst.net
P.O. Box #400  Bloomsburg, PA 17815-0400 USA
A World Wide Leader in Web Hosting & Internet Solutions
The Best Value For Your Dollar On The Net!

Copyright 1996-2000 =A9
BurstNET Technologies, Inc.
All Rights Reserved.

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7PsebT5huNxcQLWARArpzAJsH03YgChfyGjGlfGmXz+mU1JINKQCgit05
+AQVFwRVl+uQgRx1H8IeFY4=
=5K1q
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
