Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319467AbSILHqX>; Thu, 12 Sep 2002 03:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319469AbSILHqX>; Thu, 12 Sep 2002 03:46:23 -0400
Received: from bg77.anu.edu.au ([150.203.223.77]:51648 "EHLO lassus.himi.org")
	by vger.kernel.org with ESMTP id <S319467AbSILHqW>;
	Thu, 12 Sep 2002 03:46:22 -0400
Date: Thu, 12 Sep 2002 17:51:09 +1000
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4 & ff. blows away Xwindows with Matrox G400 and agpgart
Message-ID: <20020912075109.GA19542@himi.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3D7FF444.87980B8E@bigpond.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <3D7FF444.87980B8E@bigpond.com>
User-Agent: Mutt/1.3.28i
From: simon@himi.org (Simon Fowler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2002 at 11:56:20AM +1000, Allan Duncan wrote:
> This is a reissue of an earlier report, and I've since done some more dig=
ging.
>=20
> Up to kernel 2.4.20-pre2 there was no problem, agpgart et al ran fine etc,
> but from 2.4.20-pre4 onwards when Xwindows starts to load these modules
> I am instantly thrown back to a booting machine.
> The same kernels on a VIA MVP3 chipset box with a Matrox G200 are fine.
>=20
> I have ascertained that any attempt to use agpgart triggers it.
>=20
I've seen the same thing with 2.4.20-pre5-ac1, and I'm just building
pre5-aa2 to see if there's any difference. This is with an AMD 751
system (an Asus K7M), an original Radeon, and the DRI CVS code. I
couldn't get any log messages out of it, though.

Simon

--=20
PGP public key Id 0x144A991C, or ftp://bg77.anu.edu.au/pub/himi/himi.asc
(crappy) Homepage: http://bg77.anu.edu.au
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://bg77.anu.edu.au/pub/mirrors/css/=20

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9gEdsQPlfmRRKmRwRArtmAJ9lBDPvepkngE0rdNLBik9ZnDm9ZgCfWbSI
CIheejF7O1WswaQ2o0ThlPM=
=1Cex
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
