Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279103AbRKXTQV>; Sat, 24 Nov 2001 14:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279277AbRKXTQL>; Sat, 24 Nov 2001 14:16:11 -0500
Received: from f05s15.cac.psu.edu ([128.118.141.58]:32435 "EHLO
	f05n15.cac.psu.edu") by vger.kernel.org with ESMTP
	id <S279103AbRKXTPx>; Sat, 24 Nov 2001 14:15:53 -0500
Subject: Re: 2.4.15aa1
From: Phil Sorber <aafes@psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20011124085028.C1419@athlon.random>
In-Reply-To: <20011124085028.C1419@athlon.random>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-1ilDTgSIDjO2Uv2bGON+"
X-Mailer: Evolution/0.16 (Preview Release)
Date: 24 Nov 2001 14:15:50 -0500
Message-Id: <1006629351.1470.8.camel@praetorian>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1ilDTgSIDjO2Uv2bGON+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2001-11-24 at 02:50, Andrea Arcangeli wrote:
> Only in 2.4.15aa1: 00_iput-unmount-corruption-fix-1
>=20
> 	Fix iput umount corruption.

Is this the problem that Al put out a patch for yesterday? And is his
patch been tested and working?

> Only in 2.4.15aa1: 00_read_super-stale-inode-1
>=20
> 	If read_super fails avoid lefting stale inodes queued into
> 	the superblock.

What is this? How dangerous is it?

--=20
Phil Sorber
AIM: PSUdaemon
IRC: irc.openprojects.net #psulug PSUdaemon
GnuPG: keyserver - pgp.mit.edu

--=-1ilDTgSIDjO2Uv2bGON+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7//HmXm6Gwek+iaQRAsIxAJ9Ondoex1O/2n9R7Wr+XsYb5FeAxwCfeTFi
vgQKSpr7arYqg6TK+thFOfk=
=hGEi
-----END PGP SIGNATURE-----

--=-1ilDTgSIDjO2Uv2bGON+--

