Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSHPMI3>; Fri, 16 Aug 2002 08:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317892AbSHPMI3>; Fri, 16 Aug 2002 08:08:29 -0400
Received: from sauron.forwiss.uni-passau.de ([132.231.20.100]:64767 "EHLO
	sauron.forwiss.uni-passau.de") by vger.kernel.org with ESMTP
	id <S317887AbSHPMI2>; Fri, 16 Aug 2002 08:08:28 -0400
Date: Fri, 16 Aug 2002 14:12:23 +0200
From: M G Berberich <berberic@fmi.uni-passau.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.31 devfs consoles
Message-ID: <20020816121223.GG23847@finarfin.forwiss.uni-passau.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

a) [devfs]/vc/ only contains 0, the entries for the actual consoles
   are missing.

b) the devfs code misses a
   EXPORT_SYMBOL(devfs_find_and_unregister)
   as far as I remember this has already been reportet.

	MfG
	bmg

--=20
"Des is v=F6llig wurscht, was heut beschlos- | M G Berberich
 sen wird: I bin sowieso dagegn!"          | berberic@fmi.uni-passau.de
(SPD-Stadtrat Kurt Schindler; Regensburg)  | www.fmi.uni-passau.de/~berberic

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (SunOS)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9XOwlnp4msu7jrxMRA9vEAJ0S+4nTKImWSrvb9CawF9H5NP8XJACfY6hH
Vvmd9NmU66LCdHc32CxqP+0=
=Cav2
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
