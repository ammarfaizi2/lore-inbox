Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265283AbTLGA3r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 19:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265284AbTLGA3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 19:29:47 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:8082
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S265283AbTLGA3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 19:29:44 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Ian Kumlien <pomac@vapor.com>
To: Craig Bradney <cbradney@zip.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1070756427.2093.2.camel@athlonxp.bradney.info>
References: <1070739194.1985.4.camel@big.pomac.com>
	 <1070756427.2093.2.camel@athlonxp.bradney.info>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ayS4zb5QQe6IqCrXqTWE"
Message-Id: <1070756987.1987.7.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 07 Dec 2003 01:29:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ayS4zb5QQe6IqCrXqTWE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-12-07 at 01:20, Craig Bradney wrote:
> On Sat, 2003-12-06 at 20:33, Ian Kumlien wrote:
> > Hi, i'm now running this patch and it survived my grep in /usr/src.
> >=20
> > It's mainly a correction of the apic patch and the ACPI halt disconnect
> > patch that was originally done for 2.6...
>=20
> Correction? how so? code looks the same, although the line numbers are
> completely different for mpparse.c and at that location there is
> different code. (Havent checked the disconnect)

this is for 2.4.23 =3D)

> Or do u just mean combination of the two patches?

Combination + for 2.4.23

> > I'll get back to you about uptime, but i think this is it...=20
>=20
> Why do you think the disconnect is also related? (given some are just
> running the APIC patch and having (less/)no issues?

Since i had issues with just the apic patch, as stated in my mail.

> > Although i would prefer a not so workaroundish approach =3D)
>=20
> 23 hrs now..=20

I'm at 5:06 and thats a record for it running with apic.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-ayS4zb5QQe6IqCrXqTWE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0nR77F3Euyc51N8RAueFAJwOSQ90trbsMM59VAqXGyJJdkayOgCfQnhy
8EuH+wkkpxfyN5wIR6LMS+c=
=c8ed
-----END PGP SIGNATURE-----

--=-ayS4zb5QQe6IqCrXqTWE--

