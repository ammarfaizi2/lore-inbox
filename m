Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUGYK1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUGYK1G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 06:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUGYK1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 06:27:06 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:32717 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263851AbUGYK1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 06:27:01 -0400
Date: Sun, 25 Jul 2004 12:27:00 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Bc. Michal Semler" <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3C905 and ethtool
Message-ID: <20040725102700.GN18676@lug-owl.de>
Mail-Followup-To: "Bc. Michal Semler" <cijoml@volny.cz>,
	linux-kernel@vger.kernel.org
References: <200407251016.22001.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Lqu5hkAdORZH7CMT"
Content-Disposition: inline
In-Reply-To: <200407251016.22001.cijoml@volny.cz>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Lqu5hkAdORZH7CMT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-07-25 10:16:21 +0200, Bc. Michal Semler <cijoml@volny.cz>
wrote in message <200407251016.22001.cijoml@volny.cz>:
> I wanted to get info about my NIC via ethtool, but it writes:
> # ethtool eth0
> Cannot get device settings: Operation not supported
> # ethtool eth1
> Cannot get device settings: Operation not supported
>=20
> 00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] =
(rev 30)
> 01:08.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
>=20
> Any possibility to add this support into this driver?

Feel free to do it:)  Some other cards support it, so their code should
give you an idea about how that is done...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--Lqu5hkAdORZH7CMT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBA4r0Hb1edYOZ4bsRArRQAJ94I+UZF/V8K2ZfaOI0Pg1CRd28ZACfVWSH
hU4Wcr9GAeJ74Som3REWkeY=
=J1EA
-----END PGP SIGNATURE-----

--Lqu5hkAdORZH7CMT--
