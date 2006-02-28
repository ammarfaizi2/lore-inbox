Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWB1OwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWB1OwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 09:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWB1OwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 09:52:25 -0500
Received: from lug-owl.de ([195.71.106.12]:50913 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751035AbWB1OwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 09:52:24 -0500
Date: Tue, 28 Feb 2006 15:52:17 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "James C. Georgas" <jgeorgas@rogers.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-ID: <20060228145217.GM19232@lug-owl.de>
Mail-Followup-To: "James C. Georgas" <jgeorgas@rogers.com>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20060225160150.GX3674@stusta.de> <1141078686.28136.20.camel@Rainsong.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4KxxQz8GMS4i+IrM"
Content-Disposition: inline
In-Reply-To: <1141078686.28136.20.camel@Rainsong.home>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4KxxQz8GMS4i+IrM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-02-27 17:18:06 -0500, James C. Georgas <jgeorgas@rogers.com> w=
rote:
> On Sat, 2006-25-02 at 17:01 +0100, Adrian Bunk wrote:
> > CONFIG_UNIX=3Dm doesn't make much sense.
>=20
> I've been building it as a module forever. I often load kernels from
> floppy disk, and building CONFIG_UNIX as a module often makes the
> difference between the kernel fitting or not fitting on the disk. Could
> we please keep this functionality?

Same for me. Maybe make the offer of CONFIG_UNIX=3Dm dependant on the
small/embedded stuff?

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--4KxxQz8GMS4i+IrM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEBGOhHb1edYOZ4bsRAmX+AJ0Zvbusno44TkECM5vUcN5B3W2dwACeNS5Q
Kb0zvKmPcMwNeHmxAkhXcRE=
=8GsI
-----END PGP SIGNATURE-----

--4KxxQz8GMS4i+IrM--
