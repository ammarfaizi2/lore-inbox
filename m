Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280941AbRKLTWY>; Mon, 12 Nov 2001 14:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280944AbRKLTWQ>; Mon, 12 Nov 2001 14:22:16 -0500
Received: from rhlx01.fht-esslingen.de ([134.108.34.10]:14312 "HELO
	rhlx01.fht-esslingen.de") by vger.kernel.org with SMTP
	id <S280941AbRKLTWH>; Mon, 12 Nov 2001 14:22:07 -0500
Subject: Re: [PATCH] VIA timer fix was removed?
From: Nils Philippsen <nils@wombat.dialup.fht-esslingen.de>
To: Jeronimo Pellegrini <pellegrini@mpcnet.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011112170026.A7310@socrates>
In-Reply-To: <20011112111409.A2617@socrates>
	<200111121448.PAA01060@green.mif.pg.gda.pl>
	<20011112140530.A23866@socrates> <1005590954.23106.1.camel@wombat> 
	<20011112170026.A7310@socrates>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ynCwk7gWLdwbNPq+c8dM"
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 12 Nov 2001 20:21:58 +0100
Message-Id: <1005592918.7932.0.camel@wombat>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ynCwk7gWLdwbNPq+c8dM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 2001-11-12 at 20:00, Jeronimo Pellegrini wrote:
> > I have seen IBM machines (Netfinity 6000R) where this code got triggere=
d
> > even though they didn't have VIA chipsets/timers. Seems to have caused
> > some problems there and I removed the code (in the custom kernel runnin=
g
> > on those machines).
>=20
> #ifdefs and a question in config, maybe?

It wasn't something that left those machines. People with more intimate
knowledge of this code and maybe those IBMs should take care.

Nils
--=20
 Nils Philippsen / Berliner Stra=DFe 39 / D-71229 Leonberg //
+49.7152.209647
nils@wombat.dialup.fht-esslingen.de / nils@redhat.de /
nils@fht-esslingen.de
        Ever noticed that common sense isn't really all that common?

--=-ynCwk7gWLdwbNPq+c8dM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA78CFWR9ibZWlRMBERAs0fAJ46NIx2l4jEFXcAambhIoWWbaLCVgCgm9tV
eCDWNG2y/Hqyf0Ji1/j6CDA=
=YqoU
-----END PGP SIGNATURE-----

--=-ynCwk7gWLdwbNPq+c8dM--

