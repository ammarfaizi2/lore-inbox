Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVAJNYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVAJNYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVAJNYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:24:34 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:31121 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S262238AbVAJNYW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:24:22 -0500
From: Mws <mws@twisted-brains.org>
To: linux-kernel@vger.kernel.org
Subject: pci express error on ASUS P5AD2
Date: Mon, 10 Jan 2005 14:24:35 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1491622.6bpqDLGyo1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501101424.41686.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1491622.6bpqDLGyo1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

i am using an ASUS P5AD2Premium Board with a P4 3,4 LGA 775 CPU.

This one has got 2 Gigabit PCI Express Ethernet cards on-board.

lspci=20

0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit Eth=
ernet Controller (rev 15)
0000:03:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit Eth=
ernet Controller (rev 15)

both 2 are working, but when i load the driver modules=20
i get 2 unrecoverable PciExpress Hardware failures.

Drivers are not implemented in the Kernel Mainstream but as syskonnect told=
 me, already send to the devs.

Driver version from syskonnect is v 7.09

obtainable @

http://www.syskonnect.com/syskonnect/support/driver/htm/sk9e21_lin.htm


help is appreciated. just mail me for more information if needed.

regards
marcel

--nextPart1491622.6bpqDLGyo1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB4oIZPpA+SyJsko8RAr5KAJwPK1j7alMo3RTMSbvxGjBRlR0cfACeMOQz
tgp7OsbtoqBLZNAJT+rhQSo=
=KcsZ
-----END PGP SIGNATURE-----

--nextPart1491622.6bpqDLGyo1--
