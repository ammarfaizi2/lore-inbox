Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbTASJCI>; Sun, 19 Jan 2003 04:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267403AbTASJCI>; Sun, 19 Jan 2003 04:02:08 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:5856
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S267267AbTASJCF>; Sun, 19 Jan 2003 04:02:05 -0500
Date: Sun, 19 Jan 2003 01:10:43 -0800
To: Anton Altaparmakov <aia21@cantab.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANN] ntfsprogs (formerly Linux-NTFS) 1.7.0beta released
Message-ID: <20030119091043.GA8856@ludicrus.ath.cx>
References: <Pine.SOL.3.96.1030118163630.27974A-100000@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <Pine.SOL.3.96.1030118163630.27974A-100000@libra.cus.cam.ac.uk>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

How stable would you say NTFS write is for this release? Is it as=20
yucky as it was in the 2.4.20 driver version?

Regards
Josh

On Sat, Jan 18, 2003 at 04:44:17PM +0000, Anton Altaparmakov wrote:
> This is to announce the new release of the ntfsprogs package (formerly
> Linux-NTFS).
>=20
> This is a massive update featuring an almost complete rewrite of the ntfs
> library (the API should hopefully remain stable from now on) as well as
> several new utilities: ntfslabel, ntfsresize, and ntfsundelete.
>=20
> Note this is a beta release and can contain bugs. Please backup your data
> before using any of the utilities in write mode.=20
>=20
> You can download the source code as a tar ball or source rpm or binary
> rpms for intel 386 architecture from our website:
>=20
> 	http://linux-ntfs.sourceforge.net/downloads.html
>=20
> Or you can get the latest source from our bitkeeper repository by doing a:
>=20
> 	bk clone http://linux-ntfs.bkbits.net/ntfsprogs
>=20
> You can also browse the source code online here:
>=20
> 	http://linux-ntfs.bkbits.net:8080/ntfsprogs
>=20
> Best regards,
>=20
> 	Anton
> --=20
> Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
> Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
> WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
=2E-`-.-`-.-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D----->
Joshua Kwan	joshk@ludicrus.ath.cx
		joshk@mspencer.net

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+KmuT6TRUxq22Mx4RAvXMAKCMcGyjiJVh1E34AbxFoxOH1wontgCdE05d
PTeyaPLK/zd0HJwJdGk+Czs=
=3LRE
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
