Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSKGT1m>; Thu, 7 Nov 2002 14:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261528AbSKGT1m>; Thu, 7 Nov 2002 14:27:42 -0500
Received: from dialin-145-254-144-243.arcor-ip.net ([145.254.144.243]:15232
	"HELO schottelius.net") by vger.kernel.org with SMTP
	id <S261527AbSKGT1i>; Thu, 7 Nov 2002 14:27:38 -0500
Date: Thu, 7 Nov 2002 10:04:26 +0100
From: Nico Schottelius <schottelius@wdt.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: PCMCIA <dhinds@zen.stanford.edu>
Subject: [BUGS 2.5.45]
Message-ID: <20021107090425.GA461@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.4.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again!

1)
As you'll all have noticed, the makefile for the build wants QT installed f=
or
a simple build process.

2)
PCMCIA module ds.o cannot be loaded -> somehow the kernel denies that.

3)
atimach64 console driver makes blank screen on
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M Mobilit=
y AGP 2x (rev 64)

I know, the video driver didn't work in any kernel version, but I am intere=
sted
in fixing that. I don't know where the problem is located, but I would beta
test drivers, if available. I would also help to trace down the problem,
with little help from the developers.

Is there any development with this driver ? Or is it simply dead? I can't=
=20
find any contact in any of the kernel source files...

Please tell me what todo with pcmcia/ati, I want to have those things
usable, not only for me.

Nico


--=20
Changing mail address: please forget all known @pcsystems.de addresses.

Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9yiyZtnlUggLJsX0RAkjPAJ97Hy01NoboLuCwIGs0ftTH8YXeQQCgk0Sa
uxtnW03USj/jR6WU/lu9SgY=
=mCaI
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
