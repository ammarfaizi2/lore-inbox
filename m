Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWCZPUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWCZPUt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 10:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWCZPUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 10:20:49 -0500
Received: from lug-owl.de ([195.71.106.12]:32404 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751313AbWCZPUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 10:20:48 -0500
Date: Sun, 26 Mar 2006 17:20:44 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-ID: <20060326152044.GV31387@lug-owl.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060225160150.GX3674@stusta.de> <20060225224631.GA4085@suse.de> <20060325194739.GS4053@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qa1NXTiqN6KSzHv0"
Content-Disposition: inline
In-Reply-To: <20060325194739.GS4053@stusta.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qa1NXTiqN6KSzHv0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-03-25 20:47:39 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> On Sat, Feb 25, 2006 at 11:46:31PM +0100, Olaf Hering wrote:
> >  On Sat, Feb 25, Adrian Bunk wrote:
> > > CONFIG_UNIX=3Dm doesn't make much sense.
> >=20
> > There is likely more code to support a modular unix.ko, this has to go
> > as well.
>=20
> Sounds resonable, updated patch below.

Thanks for the patch. I'll save it somewhere to have it handy for
"patch -R" use IFF it makes its ways into Linus's repo.

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

--qa1NXTiqN6KSzHv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEJrFMHb1edYOZ4bsRAgJWAJ0UmyyPdwnFhjjbBRPnIr/EFYujxQCfWO9/
MGJ0ZDiE7pUj6ecikUKG2N0=
=lxzA
-----END PGP SIGNATURE-----

--qa1NXTiqN6KSzHv0--
