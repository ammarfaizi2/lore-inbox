Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbTDNIS5 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 04:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTDNIS5 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 04:18:57 -0400
Received: from pfepa.post.tele.dk ([193.162.153.2]:58520 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262853AbTDNIS4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 04:18:56 -0400
Subject: 2.5.67-mm2 booting problems!
From: Mads Christensen <mfc@krycek.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1Ew5q65HQmGcnBIbbitv"
Organization: krycek.org
Message-Id: <1050309044.2522.6.camel@krycek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 Apr 2003 10:30:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1Ew5q65HQmGcnBIbbitv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ok, this puzzles me a bit -=20
i just upgraded 2.5.67 to -mm2, and it won't boot it just stalls after=20

'Booting Linux kernel....' or something similiar - and nothing.=20

I have CONFIG_VT=3Dy and CONFIG_INPUT=3Dy set, which is why i don't get it =
-
that was the problem with 2.5.67, but i fixed that, and the .config
should be intact after patching the kernel, shouldn't it?=20

Any suggestions ?
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| Mads F. Christensen     || email:                                    |
| phone:  +45 27 47 58 66 || mfc@krycek.org                            |
| Webdesign Development   || www.krycek.org - personal data site       |
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


--=-1Ew5q65HQmGcnBIbbitv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+mnG044SvOSUXdFgRAj+NAKCHDhB4NKxO6rCHruINEhZceNERIQCeJC9X
mteORll0tdGJgXI4WAqVJ0I=
=IQTt
-----END PGP SIGNATURE-----

--=-1Ew5q65HQmGcnBIbbitv--

