Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266507AbSKZSuG>; Tue, 26 Nov 2002 13:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266514AbSKZSuG>; Tue, 26 Nov 2002 13:50:06 -0500
Received: from [132.248.33.226] ([132.248.33.226]:24472 "EHLO
	garaged.homeip.net") by vger.kernel.org with ESMTP
	id <S266507AbSKZSuF>; Tue, 26 Nov 2002 13:50:05 -0500
Subject: swap usage on most 2.4.x kernels
From: Max Valdez <maxvaldez@yahoo.com>
To: kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-B1OQJK4ncuAsltJ6CjtM"
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 26 Nov 2002 12:57:45 +0000
Message-Id: <1038315477.3403.18.camel@garaged.fis.unam.mx>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-B1OQJK4ncuAsltJ6CjtM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all:

I have the same question that most people must have, why I need to
manually erase swap to avoid excesive paging after a couple of uptime
days ??.

Once i have most of my RAM ocupied (more than 50% by cache ona a 1GB
box) the swaping starts to be a problem,  I know the problem is that i
like a fancy desktop style, and memory eating programs to read the damn
email, but I think there should be a way to decrese the swaping isnt it
??.. after all, most of the ram is in chache !!, is it really that
necesary ??

BTW, im starting to have the same "old" pagging problem with
2.4.20-rc2-ac3. after 1 uptime day. and it seems to be getting worst,
could it be a hardware problem ??, maybe my ram chips are passing the
way ?

If i'm doing something wrong please send me some recomendations.
Best regards
Max

--=20
uname -a: Linux garaged.fis.unam.mx 2.4.20-rc2-ac3 #2 SMP Thu Nov 21
17:15:31 UTC 2002 i686 unknown unknown GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
GS/
d-s:a-C++ILIHA+++P-L++E--W++N+K-w++++O-M--V--PS+PEY+PGP-tXRtv++b+DI--D+Ge++=
h---r+++z+++
-----END GEEK CODE BLOCK-----
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-B1OQJK4ncuAsltJ6CjtM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA942/IsvQlVyd+QikRAq2+AJ0TK2n1DXjQBUj0GisVQDO46PeUYwCeJwsU
f/5mckirin+jL6l+m7njNLY=
=LDvh
-----END PGP SIGNATURE-----

--=-B1OQJK4ncuAsltJ6CjtM--

