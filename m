Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVAVQET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVAVQET (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 11:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVAVQET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 11:04:19 -0500
Received: from lug-owl.de ([195.71.106.12]:3237 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262503AbVAVQEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 11:04:07 -0500
Date: Sat, 22 Jan 2005 17:04:07 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: James Simmons <jsimmons@www.infradead.org>
Cc: linux-mips@linux-mips.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TurboChannel Bsus sysfs port.
Message-ID: <20050122160407.GT28037@lug-owl.de>
Mail-Followup-To: James Simmons <jsimmons@www.infradead.org>,
	linux-mips@linux-mips.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.56.0501220021540.1021@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WiG3HOh2BFypK78Q"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0501220021540.1021@pentafluge.infradead.org>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WiG3HOh2BFypK78Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-01-22 00:25:28 +0000, James Simmons <jsimmons@www.infradead.or=
g>
wrote in message <Pine.LNX.4.56.0501220021540.1021@pentafluge.infradead.org=
>:
>=20
> Experimenting with sysfs to figure out how it works. So I'm attempting to=
=20
> port the TurboChannel bus code to sysfs. Its a test of concept and a=20
> learning experience. Comments welcomed.
[...]

I haven't tested the code, but basically, it's a good step into the
right direction. The DECstations aren't yet really in the 2.6.x world,
but that doesn't degrade your good work :-)  Also, it now seems easier
to me to integrate a different TC bus driver: this will be needed for
Linux' port to VAX computers, which may have TC busses, too.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--WiG3HOh2BFypK78Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB8nl3Hb1edYOZ4bsRAsG8AJwN+hUOCQiMVocwDK956cs0B3A/ggCfR56M
os1QkWFTDVejtmoWksCtmVw=
=dd7E
-----END PGP SIGNATURE-----

--WiG3HOh2BFypK78Q--
