Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbSKNUV4>; Thu, 14 Nov 2002 15:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265197AbSKNUV4>; Thu, 14 Nov 2002 15:21:56 -0500
Received: from pc175.host14.starman.ee ([62.65.206.175]:260 "EHLO amd-laptop")
	by vger.kernel.org with ESMTP id <S265196AbSKNUVz>;
	Thu, 14 Nov 2002 15:21:55 -0500
Date: Thu, 14 Nov 2002 22:27:06 +0200
From: Priit Laes <amd@tt.ee>
To: linux-kernel@vger.kernel.org
Subject: Lack of documentation (Was:  [HELP]Driver for Winbond ethernet card)
Message-ID: <20021114202706.GC26473@amd-laptop.mshome.net>
References: <20021114183132.GA26473@amd-laptop.mshome.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <20021114183132.GA26473@amd-laptop.mshome.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.19-gentoo-r9 (i686)
X-GPG-Fingerprint: 7297 A6E5 287F 40FD 0945  17FF 9D35 D5C0 8545 2118
X-GPG-Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x85452118
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Priit Laes (amd@tt.ee) wrote:
> Here's my problem...
> I've been trying build a router box from an old 486 and it has one quite
> exotic ethernet card. It doesn't have a name anywhere on a card, but i
> guess the most important chip on card is Winbond W24129AS-35. I haven't
> found any drivers yet for Linux. Some forums say, that this card is
> NE2000 compatible, but insmod ne fails (i attached right io and irq).
> Thanks in advance :)
Argh... it really was ne2000 compatible... i guess i'll make a patch for
docs later...
--=20
Priit Laes <amd@tt.ee>                                     _o)         =20
http://amd-core.tk                                         /\\  _o)  _o)
GSM : +37256959083                                        _\_V _(\) _(\)

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE91AcanTXVwIVFIRgRApA3AKCDAqBLFj6sjN2uVYYKlTUDkigBIACbBqaV
XHjne0dpX9JNtHXV8icECss=
=DTkL
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
