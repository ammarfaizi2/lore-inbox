Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267203AbTBDKOL>; Tue, 4 Feb 2003 05:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbTBDKOL>; Tue, 4 Feb 2003 05:14:11 -0500
Received: from [213.69.232.58] ([213.69.232.58]:14346 "HELO schottelius.net")
	by vger.kernel.org with SMTP id <S267203AbTBDKOI>;
	Tue, 4 Feb 2003 05:14:08 -0500
Date: Tue, 4 Feb 2003 09:21:36 +0100
From: Nico Schottelius <schottelius@wdt.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.59] ppc/cross-compile error
Message-ID: <20030204082135.GA1193@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.4.21-pre3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello!

is phys_addr_t structure missing in 2.5.59 or is a header file
missing ?

arch/ppc/mm/4xx_mmu.c: In function `mmu_mapin_ram':
arch/ppc/mm/4xx_mmu.c:100: `phys_addr_t' undeclared (first use in this func=
tion)
arch/ppc/mm/4xx_mmu.c:100: (Each undeclared identifier is reported only once
arch/ppc/mm/4xx_mmu.c:100: for each function it appears in.)
arch/ppc/mm/4xx_mmu.c:100: parse error before "p"
arch/ppc/mm/4xx_mmu.c:103: `p' undeclared (first use in this function)
make[1]: *** [arch/ppc/mm/4xx_mmu.o] Fehler 1

Nico

p.s.: please cc:

--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+P3gPtnlUggLJsX0RAnYlAJ4oCGEqe4gKSS2zpYmLPlF4yBWYSwCfQaKw
TbG5LIFpMEMgZ32BWycBpXg=
=Afkq
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
