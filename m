Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267856AbTBKOIZ>; Tue, 11 Feb 2003 09:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267857AbTBKOIZ>; Tue, 11 Feb 2003 09:08:25 -0500
Received: from host213-121-98-76.in-addr.btopenworld.com ([213.121.98.76]:25520
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S267856AbTBKOIY>; Tue, 11 Feb 2003 09:08:24 -0500
Subject: Re: via rhine bug? (timeouts and resets)
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Henrik Persson <nix@socialism.nu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200302111344.h1BDiMPY067070@sirius.nix.badanka.com>
References: <200302111344.h1BDiMPY067070@sirius.nix.badanka.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-SulAcW9GUdXlRUgJqwVE"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Feb 2003 14:18:28 +0000
Message-Id: <1044973108.1118.89.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SulAcW9GUdXlRUgJqwVE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-02-11 at 13:43, Henrik Persson wrote:
> The problem is that my Via Rhine-NIC when transmitting alot of data fast
> (like.. ftp:ing large files over the network at 100mbit/s) gets an error
> (frame dropped, transmit error, reset).. As a cause of this the speed
> drops to about 3-4MB/s and the rest of the communication trough the
> network isn't working very well..
>=20
> Note that this ONLY happens when there's alot of traffic (i.e. speeds at
> ~100mbit/s)..

Have you tried connecting directly to the other device with a crossover
cable, do problems still occur?

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-SulAcW9GUdXlRUgJqwVE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+SQY0kbV2aYZGvn0RAiXyAJ0V0d4r3V84jBmT7NrLrbTS2dPrbgCeJiVL
TZB4wO5O/Jjs/xZelyDNwcg=
=tdJc
-----END PGP SIGNATURE-----

--=-SulAcW9GUdXlRUgJqwVE--

