Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSKNS0W>; Thu, 14 Nov 2002 13:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSKNS0W>; Thu, 14 Nov 2002 13:26:22 -0500
Received: from pc175.host14.starman.ee ([62.65.206.175]:260 "EHLO amd-laptop")
	by vger.kernel.org with ESMTP id <S261368AbSKNS0V>;
	Thu, 14 Nov 2002 13:26:21 -0500
Date: Thu, 14 Nov 2002 20:31:32 +0200
From: Priit Laes <amd@tt.ee>
To: linux-kernel@vger.kernel.org
Subject: [HELP]Driver for Winbond ethernet card
Message-ID: <20021114183132.GA26473@amd-laptop.mshome.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.19-gentoo-r9 (i686)
X-GPG-Fingerprint: 7297 A6E5 287F 40FD 0945  17FF 9D35 D5C0 8545 2118
X-GPG-Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x85452118
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's my problem...
I've been trying build a router box from an old 486 and it has one quite
exotic ethernet card. It doesn't have a name anywhere on a card, but i
guess the most important chip on card is Winbond W24129AS-35. I haven't
found any drivers yet for Linux. Some forums say, that this card is
NE2000 compatible, but insmod ne fails (i attached right io and irq).
Thanks in advance :)
--=20
Priit Laes <amd@tt.ee>                                     _o)         =20
http://amd-core.tk                                         /\\  _o)  _o)
GSM : +37256959083                                        _\_V _(\) _(\)

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE90+wEnTXVwIVFIRgRAtTgAJ0ftG5nP4nZPAKiceexqvSWrgjUMwCdFPeF
Vt4mT7n8gstM79qgo3M5FsY=
=C77Q
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
