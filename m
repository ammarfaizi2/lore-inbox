Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbSJTSOv>; Sun, 20 Oct 2002 14:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263345AbSJTSOv>; Sun, 20 Oct 2002 14:14:51 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:17424 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S263342AbSJTSOu>;
	Sun, 20 Oct 2002 14:14:50 -0400
Date: Sun, 20 Oct 2002 20:20:53 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44 on Alpha
Message-ID: <20021020182053.GC30418@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wLCFyzgXNT+WnbjT"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wLCFyzgXNT+WnbjT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've successfully build (and used) 2.5.4[123] on Alphas (NoNames and
Miatas), but I can't get 2.5.44 up'n'running. Using my old .config files
(from the respective previously running kernel) now first gives me
'Unable to open an initial console', followed by 'No init found. Try
passing init=3D... ...'.

I can't figure out what had changed between 2.5.43 and 2.5.44. I've
looked over the patch, but I cannot find the offender:-( Has anybody
seen the same (and got some hint for me)?

MfG, JBG

--=20
   - Eine Freie Meinung in einem Freien Kopf f=FCr
   - einen Freien Staat voll Freier B=FCrger
   						Gegen Zensur im Internet
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--wLCFyzgXNT+WnbjT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9svQFHb1edYOZ4bsRApedAJ4s64R3ky/OCev4hsHAW6j/tatAgwCffYfe
h6N+xdp2PrMuwUboN1gXplE=
=bJoE
-----END PGP SIGNATURE-----

--wLCFyzgXNT+WnbjT--
