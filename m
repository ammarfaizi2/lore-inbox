Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTDQRer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTDQReq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:34:46 -0400
Received: from pfepa.post.tele.dk ([193.162.153.2]:41522 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261804AbTDQReo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:34:44 -0400
Subject: Re: cannot boot 2.5.67
From: Mads Christensen <mfc@krycek.org>
To: "'lkml'" <linux-kernel@vger.kernel.org>
In-Reply-To: <018401c30505$1a1e6200$6400a8c0@witbe>
References: <018401c30505$1a1e6200$6400a8c0@witbe>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gbLx2qQfDiHjQo3O1cnD"
Organization: krycek.org
Message-Id: <1050601594.1073.1.camel@krycek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Apr 2003 19:46:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gbLx2qQfDiHjQo3O1cnD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

You have to get=20
CONFIG_INPUT=3Dy, CONFIG_VT=3Dy and CONFIG_VT_CONSOLE=3Dy
inorder for you to see anything =3D)

On tor, 2003-04-17 at 19:16, Paul Rolland wrote:
> Got the same starting with 2.5.67...
> I took the .config from the booting 2.5.66, made a 2.5.67 kernel,
> and when booting, booh :-(
>=20
> It was a RH8 base, Lilo... I'll try tonite to find out which option
> is responsible of that...
>=20
> Regards,
> Paul
>=20
> > I have a rh9 installation, grub is properly configured, and=20
> > when I select=20
> > to boot a 2.5 kernel it does not even decompress it. It stops=20
> > even before=20
> > printing the kernel version.
> >=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
| Mads F. Christensen     ||                      |
| Email:                  || mfc@krycek.org       |
| Webdesign Development   || www.krycek.org       |
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


--=-gbLx2qQfDiHjQo3O1cnD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+nuh644SvOSUXdFgRAgtBAJ43cOJQuek17+ZVTa4OwiDZN4Fl1QCgvIc7
8lps2AwQEB1eU3EVfyN+O+g=
=v0cO
-----END PGP SIGNATURE-----

--=-gbLx2qQfDiHjQo3O1cnD--

