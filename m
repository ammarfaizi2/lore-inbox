Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWCESWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWCESWr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 13:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWCESWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 13:22:47 -0500
Received: from lug-owl.de ([195.71.106.12]:21136 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750897AbWCESWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 13:22:46 -0500
Date: Sun, 5 Mar 2006 19:22:40 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Aritz Bastida <aritzbastida@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MMAP: How a driver can get called on mprotect()
Message-ID: <20060305182240.GH19232@lug-owl.de>
Mail-Followup-To: Aritz Bastida <aritzbastida@gmail.com>,
	linux-kernel@vger.kernel.org
References: <7d40d7190603051012p16ed826cx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="skNIaqTkWYyGFDfT"
Content-Disposition: inline
In-Reply-To: <7d40d7190603051012p16ed826cx@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--skNIaqTkWYyGFDfT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-03-05 19:12:29 +0100, Aritz Bastida <aritzbastida@gmail.com> w=
rote:
> Hello, i have a driver which lets a region of its memory to be mmaped.
> The memory can be read and written to from user processes, but sometimes
> i just want to let read it, not write it.

Well, what hardware is it for and where can we download the driver to
have a view at it? That'd probably help suggesting something...

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

--skNIaqTkWYyGFDfT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFECyxwHb1edYOZ4bsRAhSCAJ93sPf/TXBqpVN0aR9O7R47dCZrEwCffmoA
vbPlUHIwWJ62smAz/14+Rq0=
=lVsR
-----END PGP SIGNATURE-----

--skNIaqTkWYyGFDfT--
