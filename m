Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319647AbSH3SvZ>; Fri, 30 Aug 2002 14:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319649AbSH3SvY>; Fri, 30 Aug 2002 14:51:24 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:27398 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S319647AbSH3SvX>; Fri, 30 Aug 2002 14:51:23 -0400
Date: Fri, 30 Aug 2002 11:55:47 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20020830115546.E5131@one-eyed-alien.net>
Mail-Followup-To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>,
	linux-kernel@vger.kernel.org
References: <180577A42806D61189D30008C7E632E8793A25@boca213a.boca.ssc.siemens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <180577A42806D61189D30008C7E632E8793A25@boca213a.boca.ssc.siemens.com>; from Jack.Bloch@icn.siemens.com on Fri, Aug 30, 2002 at 02:43:52PM -0400
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I would simply recommend switching to ext3, where these types of errors
generally don't occur.

Oh, and if you just edit your initscripts, you can do anything you want.

Matt

On Fri, Aug 30, 2002 at 02:43:52PM -0400, Bloch, Jack wrote:
> I have an embedded system runing a 2.4.18-3 Kernel. It runs from a 256MB
> compact flash disk (emulates an IDE interface). I am using an EXT2
> filesystem. During some power-off/power-on testing, the disk check failed.
> It dropped me to a shell and I had to run e2fsck -cfv to correct this
> problem. This is all good and well in a lab environment, but in reality,
> there is nobody there to perform the repair (running system is not equipp=
ed
> with keyboard and monitor). Is there any way to invoke e2fsck automatical=
ly
> or inhibit the failure detection mechanism? Please CC me directly on any
> responses.
>=20
>=20
> Thanks in advance....
>=20
> Jack Bloch=20
> Siemens ICN
> phone                (561) 923-6550
> e-mail                jack.bloch@icn.siemens.com
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

My mother not mind to die for stoppink Windows NT!  She is rememberink=20
Stalin!
					-- Pitr
User Friendly, 9/6/1998

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9b7+yIjReC7bSPZARAtQpAKCsm3v0QvbI3Pg9zKY670apTF4wkACdGdnW
dhSgmPcmvrt+6DWLay0qMVI=
=/yx6
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
