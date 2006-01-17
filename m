Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWAQNPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWAQNPG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 08:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWAQNPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 08:15:06 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:26096 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750863AbWAQNPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 08:15:04 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.16-rc1
Date: Tue, 17 Jan 2006 14:16:12 +0100
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5957638.a4u4io4G4y";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601171416.13119.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5957638.a4u4io4G4y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Compiling libata SIL breaks with Linux 2.6.16-rc1:


  CC      drivers/scsi/sata_sil.o
drivers/scsi/sata_sil.c: In function 'sil_port_irq':
drivers/scsi/sata_sil.c:393: error: too many arguments to function=20
'ata_qc_complete'
drivers/scsi/sata_sil.c:400: error: too many arguments to function=20
'ata_qc_complete'

HTH,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart5957638.a4u4io4G4y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDzO4dxU2n/+9+t5gRAodXAKDFpFuebhAwKKSOyzI6qEw//02OVQCg8nX5
gt9BlkvDCyyt2fEa1ee9oX0=
=90os
-----END PGP SIGNATURE-----

--nextPart5957638.a4u4io4G4y--
