Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVKAWB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVKAWB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVKAWB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:01:27 -0500
Received: from the-penguin.otak.com ([65.37.126.18]:2500 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S1751286AbVKAWB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:01:27 -0500
Date: Tue, 1 Nov 2005 14:01:30 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: russb@emc.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: sata_mv
Message-ID: <20051101220129.GA18919@the-penguin.otak.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
X-Operating-System: Linux 2.6.14-rc4-mm1 on an i686
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi I've put a server together, and it has a

Marvell Technology Group Ltd. MV88SX6041 4-port SATA II PCI-X Controller=20

After a great deal of work I've got it booting with the .25 version of the =
marvel driver.=20
But It's generating many many of these kinds of errors.

 Assertion failed! 0 =3D=3D (sg_len & ~MV_DMA_BOUNDARY),drivers/scsi/sata_m=
v.c,mv_fill_sg,line=3D798


How close is the driver to being reliable enough to use in a single drive
environment?=20

is there anything I can do to help debug further?



--=20
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence
--------------------------------------
- - - - - - O t a k  i n c . - - - - -=20



--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDZ+W5sgPkFxgrWYkRArNqAJoCwzel06qf0fQPnbxzFPeW+0svMACfc0tq
cbD/w5MJedr1OAyA+fa+4WU=
=BiTG
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
