Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTGHPNb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTGHPNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:13:30 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:65408
	"HELO ghanima.endorphin.org") by vger.kernel.org with SMTP
	id S263610AbTGHPNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:13:20 -0400
Date: Tue, 8 Jul 2003 17:27:55 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] AES for CryptoAPI - i586-optimized 
Message-ID: <20030708152755.GA24331@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Due to the recent discussion about the asm-optimized version of AES which is
included in loop-AES, I'd like to point out that I've ported this
implementation - Dr. Brian Gladman's btw. - to CryptoAPI a long time ago.

http://therapy.endorphin.org/patches/aes-i586-asm-2.5.58.diff

The demand for this patch will rise quickly if cryptoloop is included :)=20

Regards, Clemens

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/CuL7W7sr9DEJLk4RAuUDAJ9TDkJm5ti9FFDrbO9gCnqSfgbXGACbBI1S
ievFC/KK9e1xBKk8Am71rmk=
=jGJP
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
