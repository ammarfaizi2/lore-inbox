Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTKOPIp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 10:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTKOPIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 10:08:45 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:30088 "EHLO
	catnet.kabel.utwente.nl") by vger.kernel.org with ESMTP
	id S261788AbTKOPIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 10:08:44 -0500
Date: Sat, 15 Nov 2003 16:08:42 +0100
From: Wilmer van der Gaast <lintux@lintux.cx>
To: linux-kernel@vger.kernel.org
Subject: Configuration help texts for IPsec
Message-ID: <20031115150841.GA4854@gaast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
X-Operating-System: Linux 2.4.22-ac4 on a i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

In the 2.6 kernel configuration, the help texts for all the
IPsec-related options say "Say Y unless you know what you are doing.".
Looks fine for people who applied the IPsec patch to a kernel which
comes without it, but now that it's in stock, it's probably not very
useful to force all users to use IPsec.

Just FYI,


Wilmer van der Gaast.

--=20
+-------- .''`.     - -- ---+  +        - -- --- ---- ----- ------+
| lintux : :'  :  lintux.cx |  | OSS Programmer   www.bitlbee.org |
|   at   `. `~'  debian.org |  | www.algoritme.nl   www.lintux.cx |
+--- -- -  ` ---------------+  +------ ----- ---- --- -- -        +

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE/tkF5eYWXmuMwQFERAre+AKCRiihC1sg/MBXRjOilFhfRR7ixMgCgmd88
TugMoW0YcHmVkCbsINw49GM=
=q0NU
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
