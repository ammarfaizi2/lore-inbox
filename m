Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277712AbRJRNyS>; Thu, 18 Oct 2001 09:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277718AbRJRNx6>; Thu, 18 Oct 2001 09:53:58 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:5130 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S277712AbRJRNxz>;
	Thu, 18 Oct 2001 09:53:55 -0400
Date: Thu, 18 Oct 2001 17:54:28 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] pci.ids addition for Moxa serial card
Message-ID: <20011018175428.B23104@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 4:36pm  up 6 days,  4:45,  2 users,  load average: 0.00, 0.08, 0.08
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AbQceqfdZEv+FvjW
Content-Type: multipart/mixed; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

please consider applying.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-moxaids

diff -ur -X /usr/dontdiff /linux.vanilla/drivers/pci/pci.ids /linux/drivers/pci/pci.ids
--- /linux.vanilla/drivers/pci/pci.ids	Wed Oct 17 11:26:01 2001
+++ /linux/drivers/pci/pci.ids	Thu Oct 18 12:53:58 2001
@@ -3677,6 +3677,11 @@
 1391  Development Concepts Inc
 1392  Medialight Inc
 1393  Moxa Technologies Co Ltd
+	1040  Smartio C104H/PCI
+	1680  Smartio C168H/PCI
+	2040  Intellio CP-204J
+	2180  Intellio C218 Turbo PCI
+	3200  Intellio C320 Turbo PCI
 1394  Level One Communications
 1395  Ambicom Inc
 1396  Cipher Systems Inc

--B4IIlcmfBL/1gGOG--

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7zt8UBm4rlNOo3YgRAm9OAJ9TQpWhffCKpLlFPEohO69/IgF/JQCaAxOy
S6l05fQh3HABMJm/pZkkxeY=
=0H81
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
