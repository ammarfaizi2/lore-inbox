Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314483AbSEMWCI>; Mon, 13 May 2002 18:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314485AbSEMWCH>; Mon, 13 May 2002 18:02:07 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:61968 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S314483AbSEMWCF>; Mon, 13 May 2002 18:02:05 -0400
Date: Mon, 13 May 2002 14:59:42 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Phillip.Watts@nlynx.com,
        linux-kernel@vger.kernel.org
Subject: Re: Compact Flash bug
Message-ID: <20020513145942.H1627@one-eyed-alien.net>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Phillip.Watts@nlynx.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.3.96.1020513233800.26083k-100000@delta.ds2.pg.gda.pl> <Pine.LNX.4.33L2.0205131445170.20629-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="e5bfZ/T2xnjpUIbw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Someone should probably add a comment to that effect.  Even some recently
purchased units use the old spelling.

Matt

On Mon, May 13, 2002 at 02:45:44PM -0700, Randy.Dunlap wrote:
> On Mon, 13 May 2002, Maciej W. Rozycki wrote:
>=20
> | On Mon, 13 May 2002 Phillip.Watts@nlynx.com wrote:
> |
> | > in 2.4.18  the routine which is determining if Compact Flash
> | > has  Sandisk  spelled SunDisk.
> |
> |  That looks correct.  The company seems to have problems with identity:
> |
> | # hdparm -i /dev/hda
> |
> | /dev/hda:
> |
> |  Model=3DSunDisk SD35B-64, FwRev=3Dvcb 1.45, SerialNo=3DMT311213748
> |  Config=3D{ HardSect NotMFM Fixed DTR>10Mbs nonMagnetic }
> |  RawCHS=3D490/8/32, TrkSize=3D0, SectSize=3D576, ECCbytes=3D4
> |  BuffType=3DDualPort, BuffSize=3D1kB, MaxMultSect=3D1, MultSect=3D1
> |  CurCHS=3D490/8/32, CurSects=3D125440, LBA=3Dyes, LBAsects=3D125440
> |  IORDY=3Dno
> |  PIO modes: pio0 pio1
> |  DMA modes:
> |  AdvancedPM=3Dno
> |
> | (that's a traditional 3.5" ATA flash device).
>=20
> Yes, the company changed its name (at the urging of Sun IIRC).
>=20
> --=20
> ~Randy
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

It's monday.  It must be monday.
					-- Greg
User Friendly, 5/4/1998

--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE84DdOIjReC7bSPZARAkmdAJwLs9AcsjZOApFSmcQgAErtTjKpZQCffYCK
eSuMT11Od1RqjLD0jpJWJqQ=
=qoP5
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--
