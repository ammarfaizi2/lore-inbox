Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbTB0Qmb>; Thu, 27 Feb 2003 11:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbTB0Qmb>; Thu, 27 Feb 2003 11:42:31 -0500
Received: from r35h118.res.gatech.edu ([128.61.35.118]:6344 "EHLO
	mail.overcode.net") by vger.kernel.org with ESMTP
	id <S265608AbTB0Qm3>; Thu, 27 Feb 2003 11:42:29 -0500
Date: Thu, 27 Feb 2003 11:52:48 -0500
From: fauxpas@temp123.org
To: linux-kernel@vger.kernel.org
Subject: IOAPIC on Via KT266a
Message-ID: <20030227165248.GA12030@temp123.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
X-GPG-Key: http://temp123.org/~fauxpas/fauxpas.pgp
X-GPG-Fingerprint: CFF3 EB2B 4451 DC3C A053  1E07 06B4 C3FC 893D 9228
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a UP system with Via kt266a chipset.  When I enable APIC in
the BIOS and in Linux, the system boots mostly normally, but I get
a fairly constant stream of

APIC error on CPU0: 02(02)

with a smattering of other numeric codes from time to time.  Most
things still work, but there are a number of oddities and instabilities,
most notably my integrated uhci USB controllers give usb bulk-msg
timeouts on every device.

This happens with 2.4.20 vanilla, 2.4.21-pre4-ac6, Debian's 2.4.18-bf24
and every other 2.4 series kernel I've tried... can somebody point me=20
at a faq/patch/person to help get me started resolving this issue ?

Thanks in advance.

--=20
Josh Litherland (fauxpas@temp123.org)

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+XkJgBrTD/Ik9kigRApCUAJ95Y6ObWNvA2QZSmYAWmYjSftyVZgCdHO0r
bdIG8vhIhxrVeWrX3bTxpN0=
=EIcH
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
