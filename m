Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbSL3UVB>; Mon, 30 Dec 2002 15:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbSL3UVB>; Mon, 30 Dec 2002 15:21:01 -0500
Received: from ce.fis.unam.mx ([132.248.33.1]:4784 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id <S265844AbSL3UU7>;
	Mon, 30 Dec 2002 15:20:59 -0500
Subject: module-init-tools-0.9.7 on MDK 9.0
From: Max Valdez <maxvaldez@yahoo.com>
To: kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Q32dmorCzD7XeSGBOYNH"
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 30 Dec 2002 14:29:31 -0600
Message-Id: <1041280171.11695.51.camel@garaged.fis.unam.mx>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q32dmorCzD7XeSGBOYNH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all:

Again, in the process of compiling and installing kernel 2.5.53, I got
the tip of module-init-tools-0.9.7 needed (from Frank Davis, Thanks!),
but when i try to install it, I get this error:

gcc  -g -O2  -o insmod.static -static insmod.o
/usr/bin/ld: cannot find -lc
collect2: ld returned 1 exit status
make: *** [insmod.static] Error 1

I havent uninstalled modutils, should I first ?, am I going to break my
box big time ?? :-)

Any help apreciated again !
Sorry for the newbieness
Best regards !
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

--=-Q32dmorCzD7XeSGBOYNH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+EKyqsvQlVyd+QikRApjSAJ41MPG+i4IxXoTNyzVibBdG2ct1JwCdEreo
o6C3w0+JZrVllfTwA9HzQug=
=bMGg
-----END PGP SIGNATURE-----

--=-Q32dmorCzD7XeSGBOYNH--

