Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVK1RHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVK1RHj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 12:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVK1RHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 12:07:39 -0500
Received: from lug-owl.de ([195.71.106.12]:53714 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751286AbVK1RHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 12:07:38 -0500
Date: Mon, 28 Nov 2005 18:07:37 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH 2.6.15-rc2-git6] Fix tar-pkg target
Message-ID: <20051128170737.GJ13985@lug-owl.de>
Mail-Followup-To: Erik Mouw <erik@harddisk-recovery.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	akpm@osdl.org, torvalds@osdl.org
References: <20051128170414.GA10601@harddisk-recovery.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nywXBoy70X0GaB8B"
Content-Disposition: inline
In-Reply-To: <20051128170414.GA10601@harddisk-recovery.nl>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nywXBoy70X0GaB8B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-11-28 18:04:15 +0100, Erik Mouw <erik@harddisk-recovery.com> w=
rote:
> Without this patch, "make tar-pkg" would generate a file
> linux-2.6.15-rc2.tar containing vmlinuz-2.6.15-rc2. With this patch, it
> generates linux-2.6.15-rc2-g458af543.tar containing
> vmlinuz-2.6.15-rc2-g458af543.
>=20
> Signed-off-by: Erik Mouw <erik@harddisk-recovery.com>

ACKed-By: Jan-Benedict Glaw <jbglaw@lug-owl.de>


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

--nywXBoy70X0GaB8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDizlZHb1edYOZ4bsRAm8jAJ9LuF/kHzVKOW/sAeD9F/kObTCffQCdH2nS
mFzF5F/x0xea1rG+TuXwdEs=
=jCOy
-----END PGP SIGNATURE-----

--nywXBoy70X0GaB8B--
