Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265296AbTL0C2V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 21:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265297AbTL0C2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 21:28:21 -0500
Received: from adsl-67-121-154-253.dsl.pltn13.pacbell.net ([67.121.154.253]:3556
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265296AbTL0C2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 21:28:19 -0500
Date: Fri, 26 Dec 2003 18:28:13 -0800
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
Message-ID: <20031227022813.GF12871@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20031226081535.GB12871@triplehelix.org> <20031226103427.GB11127@ucw.cz> <20031226194457.GC12871@triplehelix.org> <3FEC91FA.1050705@rackable.com> <20031226202700.GD12871@triplehelix.org> <3FECC3C1.5000108@wmich.edu> <3FECCAC2.2030101@vgertech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline
In-Reply-To: <3FECCAC2.2030101@vgertech.com>
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2003 at 11:56:50PM +0000, Nuno Silva wrote:
> This happens to me too, running 2.6.0-mm1. Even a music CD gets stuck=20
> and can only be ejected with the "eject" command. eject, after ejecting=
=20
> sucessfully the CD outputs this:
>=20
> # eject
> eject: unable to eject, last error: Invalid argument
> #

Exactly! This must be a -mm problem then... Andrew?

--=20
Joshua Kwan

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP+zuPKOILr94RG8mAQKHnA//XpP9tnHJ4+Gsk8lCVPT6YJD75J2+80KT
TooIhdpo3Xd9Jyf5dcsGA0VWPMLY14dv+9/u3QMiW9BAF4L5GotNNJkZ7sh4Ckeo
pAznTsECNPmOsab/Qp+Udd/2Bws3Xo4DgTJmkpGKvGb3RNR7hBm81S+TjJcQxWfZ
T9w1BDw7WaEZtpXmlR8pz8kQ27yvIIT1mdY5WNuUb1xRkhkaxBq3Yym2qMN2z9V7
XwqkjsDQK3bdZUVuBJneD/hl/FGz63ifZYIDvlJpz+OtUru4C58UBstU/jv3z6HA
8Uco3SWMk1MSjsqUE9tI+EmJdIzTDA6MVz8aScESkgWd3dubmMoaCk92VpQhC0Nc
24CAaxBtdcf5cJc0pc41T5WNY1gSl4pJDjjXWOuLjNdP+y4ssIwscrWOh4fOl6e8
+t+jyiIjRv/wUf1ms/dWop3HG5de+JYSaGLTmeapue9zgiXRmxHGp0NNNiURObxy
ALa+hFHk2XP3c8VkQd3NdWtFO+XRCmG4EQDFzd+DW3FWsLRjG/EhgP6h8JMNx5Yu
2rajYwDfrPqdWwCbBCHXOn3wU2FREMjSiH59tE+ZLtyc8sqaVPf9bBrT9jaWrOCo
tI2CiDKnBjmc7Y+7Os3ACoplpSNNO3R04yMSgDcWCV+I+Ass0lKQFBR606JlXISH
ENZ1HdvYbVM=
=nh/c
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--
