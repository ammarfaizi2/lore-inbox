Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267239AbTAQEdI>; Thu, 16 Jan 2003 23:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267349AbTAQEdI>; Thu, 16 Jan 2003 23:33:08 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:4832
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S267239AbTAQEdH>; Thu, 16 Jan 2003 23:33:07 -0500
Date: Thu, 16 Jan 2003 20:41:57 -0800
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.59
Message-ID: <20030117044157.GA27633@ludicrus.ath.cx>
References: <8B67F2E2D93ED5118D6E00508BB8D127011C3ED0@exmsb04.curtin.edu.au> <Pine.LNX.4.44.0301162211410.19302-100000@chaos.physics.uiowa.edu> <20030117041739.GA15753@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20030117041739.GA15753@work.bitmover.com>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Doh! This is something I've always wanted to know. Do you know how long=20
bk -r get takes on a slow system with a badly implemented IDE driver? :(

Well, now I know. Great :D

Regards
Josh

On Thu, Jan 16, 2003 at 08:17:39PM -0800, Larry McVoy wrote:
> A little know option which makes things go faster is=20
>=20
> 	bk -r get -qS
>=20
> which gets only those files not already gotten.  Linus has asked why this=
=20
> isn't the default and the only reason I can give him is that it is an
> interface change and we'll do it in bk 4.0.  It's the right answer.
>=20
> > 	bk -r get -q
> >=20
> > or just
> >=20
> > 	bk get drivers/eisa
> >=20
> > in this case. I guess this is becoming a FAQ.
> >=20
> > --Kai
> >=20
> >=20
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>=20
> --=20
> ---
> Larry McVoy            	 lm at bitmover.com           http://www.bitmover=
=2Ecom/lm=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
=2E-`-.-`-.-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D----->
Joshua Kwan	joshk@ludicrus.ath.cx
		joshk@mspencer.net

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+J4mV6TRUxq22Mx4RAiXgAKCznHo/xqPJ8PW+W8YwpLZZHglEogCfftan
YlemZhclMI0ENJ2RptPQ/x0=
=Mu94
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
