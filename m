Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131070AbQKACJO>; Tue, 31 Oct 2000 21:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131098AbQKACJF>; Tue, 31 Oct 2000 21:09:05 -0500
Received: from 35-LASP-X2.red.retevision.es ([62.174.192.163]:40320 "HELO
	jaya.dyndns.org") by vger.kernel.org with SMTP id <S131070AbQKACJA>;
	Tue, 31 Oct 2000 21:09:00 -0500
Date: Wed, 1 Nov 2000 02:00:48 -0500
From: linuxx <linuxx@retemail.es>
To: linux-kernel@vger.kernel.org
Subject: small fix in 2.4.0-test10
Message-ID: <20001101020048.B2975@retemail.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The version of udf in this kernel version has a bug in the access at the en=
d of the device (usually used in DVDs) the patch is currently in new versio=
ns of
udf 0.9.2 and 0.9.2.1 from linux-udf.sourceforge.net.  bye.

--=20
 Luis Toro Teijeiro
A=D1O 3021 de la era del pinguino :-) tux rules.
ICQ : 42466380
pasate por http://www.gulic.org  y veras Canarias y los linuxeros
http://jaya.dyndns.org  ------pagina personal
Firma gnupg disponible en http://jaya.dyndns.org/linuxx/gnupg/
GnupgFingerprint: 8F06 3E9A F610 89BF 0B09  3DEB 0C7E 9AE1 6CE0 B251=20
                              Windows Where do you want to go today?
                              MacOS   Where do you want to be tomorrow?
                              Linux           Are you coming, or what?
   =20

   =20

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE5/7+fDH6a4WzgslERAuUQAJ9lMe4POEHv5Cdls6yQe49w0KjxkgCfZXUc
TtHCU37ZMYct/xzWUtMtXqA=
=oN8e
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
