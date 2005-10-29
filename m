Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVJ2OcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVJ2OcI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 10:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVJ2OcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 10:32:08 -0400
Received: from lug-owl.de ([195.71.106.12]:53741 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751162AbVJ2OcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 10:32:07 -0400
Date: Sat, 29 Oct 2005 16:32:03 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: SPARC64: Configuration offers keyboards that don't make sense
Message-ID: <20051029143203.GT27184@lug-owl.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>
References: <20051028201735.GP27184@lug-owl.de> <200510290006.j9T066on029644@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aEcIyhw0mmnxygNd"
Content-Disposition: inline
In-Reply-To: <200510290006.j9T066on029644@inti.inf.utfsm.cl>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aEcIyhw0mmnxygNd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-10-28 21:06:06 -0300, Horst von Brand <vonbrand@inf.utfsm.cl> =
wrote:
> Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> > Well, the LK[24]01 was used by DECstations and VAXstations (as well as
> > some VT terminals), you can use it with a simple adaptor on any
> > machine that has a RS232 serial port. For example, I'm using such a
> > keyboard on my Athlon-based PeeCee.
>=20
> Does it need some kind of "serial keyboard configuration"? Wouldn't that
> make more sense?

Well, on the right hardware, the serio port gets a flag set by the
serial driver that it expects a keyboard on a given port.

On all other hardware, you need to call "inputattach" to do that for
you.

> > > Also, configuring this one gives a non-functional keyboard (the machi=
ne is
> > > running, I can log in over SSH, but keypresses have no effect at all).
>=20
> > Did the serial port register serio ports?
>=20
> How can I find this out?

/sys/devices/serio*

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

--aEcIyhw0mmnxygNd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDY4fjHb1edYOZ4bsRAuEWAJ0X5dJm0oyfaXXpgMTgRWsl/qvhzgCggWt7
NFyU6im+rm3tVot74cNv5Dc=
=HXQ8
-----END PGP SIGNATURE-----

--aEcIyhw0mmnxygNd--
