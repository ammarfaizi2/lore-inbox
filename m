Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVFAKOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVFAKOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 06:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVFAKOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 06:14:53 -0400
Received: from lug-owl.de ([195.71.106.12]:59112 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261193AbVFAKN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 06:13:58 -0400
Date: Wed, 1 Jun 2005 12:13:58 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Parallel Port: Settings PINs on?
Message-ID: <20050601101358.GP2417@lug-owl.de>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
References: <20050601100150.GB27717@schottelius.org> <20050601101022.GE3690@DervishD>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0i4az6ru2FyWQ2bd"
Content-Disposition: inline
In-Reply-To: <20050601101022.GE3690@DervishD>
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0i4az6ru2FyWQ2bd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-06-01 12:10:22 +0200, DervishD <lkml@dervishd.net> wrote:
>  * Nico Schottelius <nico-kernel@schottelius.org> dixit:
> > Is it possible to select (in userspace) which pins
> > should be enabled or do I have to write a kernel driver
> > for that?
>=20
>     Userspace will do. Take a look at programs like 'parapin', 'k74',
> 'libieee1284', 'libparportled', or similars. Look in FreshMeat. As
> far as I know, all them runs in userspace, although you can find some
> Linux drivers for performing pin control of parallel port.

Just for the records: some programs that access the parport use
non-portable inb/outb at PCish I/O addresses to control the parport
line. Though, I haven't checked the programs mentioned above.

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

--0i4az6ru2FyWQ2bd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCnYpmHb1edYOZ4bsRAjz1AJ40yd2x2TIb77r7QU9ACcbLTudDRgCgke1X
nZXuT6RFG48jzjIv8sEYgb0=
=DIJl
-----END PGP SIGNATURE-----

--0i4az6ru2FyWQ2bd--
