Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262600AbRFBQJB>; Sat, 2 Jun 2001 12:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbRFBQIl>; Sat, 2 Jun 2001 12:08:41 -0400
Received: from lenka.ph.ipex.cz ([212.71.128.11]:29728 "EHLO lenka.ph.ipex.cz")
	by vger.kernel.org with ESMTP id <S262600AbRFBQId>;
	Sat, 2 Jun 2001 12:08:33 -0400
Date: Sat, 2 Jun 2001 18:09:44 +0200
From: Robert Vojta <vojta@ipex.cz>
To: linux-kernel@vger.kernel.org
Subject: [bug] at slab.c ...
Message-ID: <20010602180944.A1671@ipex.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Telephone: +420 603 167 911
X-Company: IPEX, s.r.o.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
  I download kernel 2.4.5 and -ac6 patches and I see this ... After that I
have black rxvt window on my desktop and I can't remove it in any way.

kernel BUG at slab.c:1244!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129884>]
EFLAGS: 00010082
eax: 0000001b   ebx: c1103768   ecx: 00000001   edx: 00001dcb
esi: c1a57000   edi: c1a579aa   ebp: 00012800   esp: c165fda4
ds: 0018   es: 0018   ss: 0018
Process rxvt (pid: 772, stackpage=3Dc165f000)
Stack: c01f8dca 000004dc c1a57000 00001000 c1a579aa 00000246 00000000 00000=
001=20
       0000270f c165fe50 c2fe1214 00000007 c165e000 0000080c c01b08db 00000=
85c=20
       00000007 c126c400 00000000 c01affd7 00000820 00000007 00000000 00000=
80c=20
Call Trace: [<c01b08db>] [<c01affd7>] [<c01e4e79>] [<c0129ddc>] [<c01adc1c>=
]=20
   [<c01b0a9b>] [<c01adf53>] [<c01adfeb>] [<c01321bc>] [<c0129ddc>] [<c0140=
412>]=20
   [<c0132323>] [<c0106cab>] [<c010002b>]=20

Code: 0f 0b 58 8b 6b 10 5a 81 e5 00 04 00 00 74 4d b8 a5 c2 0f 17

  If you want more informations, please write me and I will send you as
much as will be possible.

Best regards,
  .R.V.

--=20
   _
  |-|  __      Robert Vojta <vojta-at-ipex.cz>          -=3D Oo.oO =3D-
  |=3D| [Ll]     IPEX, s.r.o.
  "^" =3D=3D=3D=3D`o

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjsZD8cACgkQInNB3KDLeVNu0ACeIw0AR1czzNdMfCkY7P9tMtra
aIQAn01JUjkwmkNHdALwXan2cynyiid0
=x1NL
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
