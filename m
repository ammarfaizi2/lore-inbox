Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbRCBPia>; Fri, 2 Mar 2001 10:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129250AbRCBPiL>; Fri, 2 Mar 2001 10:38:11 -0500
Received: from [212.6.145.2] ([212.6.145.2]:29705 "HELO heaven.astaro.de")
	by vger.kernel.org with SMTP id <S129249AbRCBPiD>;
	Fri, 2 Mar 2001 10:38:03 -0500
Date: Thu, 1 Mar 2001 18:45:28 -0800
From: Daniel Stutz <dstutz@astaro.de>
To: linux-kernel@vger.kernel.org
Subject: PPP bug in 2.4.1-ac20 ?
Message-ID: <20010301184528.B663@mukmin.astaro.de>
Reply-To: Daniel.Stutz@astaro.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Astaro AG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

pppd version is 2.3.11

In all 2.4.1 versions pppd exits with something like:
	ioctl(PPPIOFLAGS): invalid argument

I don't know if this is fixed in a 2.4.2 version.
I don't even know if this is not a pppd bug.

Daniel

--=20
--
In God we Trust, all others please submit signed PGP/X.509 key
Daniel Stutz <Daniel.Stutz@astaro.de>    | Product Development
Astaro AG | http://www.astaro.de  | +49-721-490069-0 | Fax -55

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1e-SuSE (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQEXAwUBOp8JSEvYZOFi63MrFAP1RwP9H5NUIbUox3YV4qAJ/mMsVhr4+bRSX1Fn
pezm+y/aDQH0ru6AeAEU1+t0SKLqigKt3PNEM+WVt4H4CjlKIfbwum8MrBM999LW
SkREnm4+Hkw5h/tdwq7pmTUPtwbzb8rEjnu6LG4C+1YJVEj7tqrwPpeZxDMDqtqQ
4iHl1rjt6c0D/R+lazQFmvYgEhu4dz7bu23unuufYhFJMPnO5Mi9CLt9pECsGyNc
fOPoMJ66ffLW9vCEHMxlJ9OAuXnWXg6VVt9lsZqffDOrQSKQAqJJIzPa7NqOXahm
prlZsuo60j1wk6FQpDGVwYqFvAKPXR8/lQq8P6tRpXtoGLK2hyz2COGh
=Hmmi
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
