Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263255AbUCNDTV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 22:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263257AbUCNDTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 22:19:21 -0500
Received: from mail01.hansenet.de ([213.191.73.61]:45201 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S263255AbUCNDTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 22:19:19 -0500
Date: Sun, 14 Mar 2004 04:20:51 +0100
From: Bjoern Michaelsen <bmichaelsen@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: SiS746 AGP - patch succesfully tested
Message-ID: <20040314032051.GA5380@lord.sinclair>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi kernelhackers!
AGP did not work on my system with my SiS 746 chipset.
I applied this patch:=20
http://lkml.org/lkml/2004/2/22/102
by Oliver Schoett manually against 2.6.4-rc1 and then AGP
worked. More info about my system can be found here:
http://bugs.gentoo.org/show_bug.cgi?id=3D40891
I did not find a bug for this on buzilla.kernel.org, should I
file one?

Please CC me in an answer.
Thanks you all for your great work!

--=20
Bj=F6rn Michaelsen
pub  1024D/C9E5A256 2003-01-21 Bj=F6rn Michaelsen <bmichaelsen@gmx.de>
   Key fingerprint =3D D649 8C78 1CB1 23CF 5CCF  CA1A C1B5 BBEC C9E5 A256

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAU8+TwbW77MnlolYRAncUAKDKuiX3qqUXfnQ0aTq4l3ghYHSXgwCfQfsw
qX5zhqvn8JlMby60arFoF0k=
=oiHB
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
