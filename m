Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267714AbTAMPIg>; Mon, 13 Jan 2003 10:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267762AbTAMPIg>; Mon, 13 Jan 2003 10:08:36 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:15891 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267714AbTAMPIf>; Mon, 13 Jan 2003 10:08:35 -0500
Subject: Re: Bugs and Releases Numbers
From: "Richard B. Tilley " "(Brad)" <rtilley@vt.edu>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030113150708.GI21826@fs.tum.de>
References: <1042469616.28005.36.camel@oubop4.bursar.vt.edu> 
	<20030113150708.GI21826@fs.tum.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-MzYDi8KBE101plWSFUGK"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jan 2003 10:17:22 -0500
Message-Id: <1042471046.28000.42.camel@oubop4.bursar.vt.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MzYDi8KBE101plWSFUGK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

So, if a major security bug was discovered in stable that impacted many
systems in a very fundamental way, then a patch would be written and
applied right away and a new kernel would be released, no?

If that ever happened, what would become of the patches that had been in
pre? Would they be included in the new kernel too, or not?

On Mon, 2003-01-13 at 10:07, Adrian Bunk wrote:
> On Mon, Jan 13, 2003 at 09:53:36AM -0500, Richard B. Tilley  (Brad) wrote=
:
>=20
> > Hello,
>=20
> Hi Richard,
>=20
> > How are bug patches worked into the current stable release? For example=
,
> > the ext3 file corruption bug in 2.4.20, was that patch worked into the
> > kernel or will it be included in 2.4.21? I'm confused about the exact
> > details of this type of thing. If the patch was worked in to 2.4.20, ho=
w
> > can one tell as the release number doesn't/hasn't changed?
> >...
>=20
> the kernel that was released as 2.4.20 will never be changed.
>=20
> The ext3 problems are fixed in the 2.4.21-pre kernels and the fixed ext3=20
> code will be in 2.4.21.
>=20
> > Thank you,
> >=20
> > Brad
>=20
> cu
> Adrian
>=20
> --=20
>=20
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
>=20
--=20
Richard B. Tilley (Brad), System Administrator & Web Developer
Virginia Tech, Office of the University Bursar
Phone: 540.231.6277
Fax: 540.231.3238
Page: 557.0891
Web: http://www.bursar.vt.edu
GPG Key: http://www.bursar.vt.edu/rtilley/pgpkey

--=-MzYDi8KBE101plWSFUGK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+ItiCPJE6j+LlAWERAqmdAJ9SL1s6UCr9QJQjL9chf7iIn/U4PgCfWswJ
fPlI0gukXRXLYsMgzXRS1gc=
=7cXR
-----END PGP SIGNATURE-----

--=-MzYDi8KBE101plWSFUGK--

