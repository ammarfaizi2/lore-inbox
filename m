Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbTDQSPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 14:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbTDQSPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 14:15:42 -0400
Received: from pfepc.post.tele.dk ([193.162.153.4]:4117 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261857AbTDQSPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 14:15:40 -0400
Subject: Re: cannot boot 2.5.67
From: Mads Christensen <mfc@krycek.org>
To: Paul Rolland <rol@as2917.net>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <01b401c3050d$7f441d70$6400a8c0@witbe>
References: <01b401c3050d$7f441d70$6400a8c0@witbe>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8rXCGtMpR6LbGKQ6u3uZ"
Organization: krycek.org
Message-Id: <1050604044.1136.4.camel@krycek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Apr 2003 20:27:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8rXCGtMpR6LbGKQ6u3uZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Common mistake i guess - but dude, never move old .config files to new
kernel dirs - patch the kernel, review the config (make menuconfig) and
recompile!

Regards

On tor, 2003-04-17 at 20:16, Paul Rolland wrote:
> Hello,
>=20
> > You have to get=20
> > CONFIG_INPUT=3Dy, CONFIG_VT=3Dy and CONFIG_VT_CONSOLE=3Dy
> > inorder for you to see anything =3D)
> Yes, I guess I have that, as I'm using the .config from a 2.5.66
> that was booting quite fine...
>=20
> Anyhow, you are right, maybe that moving .config from a release to
> another one is not 100% safe...
>=20
> Regards,
> Paul
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


--=-8rXCGtMpR6LbGKQ6u3uZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+nvIL44SvOSUXdFgRAnUaAJ9th5o9R0y+klqDFJtjuAzqEPeicACcCw1T
KrECaEKqR8ksEjAoQ8C/GGk=
=8cOT
-----END PGP SIGNATURE-----

--=-8rXCGtMpR6LbGKQ6u3uZ--

