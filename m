Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbUCVQWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 11:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbUCVQWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 11:22:04 -0500
Received: from mail.fdk-filmhaus.de ([212.184.83.66]:63369 "EHLO
	mail.fdk-filmhaus.de") by vger.kernel.org with ESMTP
	id S262087AbUCVQWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 11:22:00 -0500
Subject: sk98lin errors on Asus K8VSE deluxe (Marvell)
From: Christoph Terhechte <ct@fdk-berlin.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uCNt0iQC/CJy+0Mfqq60"
Message-Id: <1079972482.1102.11.camel@asahi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Mar 2004 17:21:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uCNt0iQC/CJy+0Mfqq60
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to install gentoo AMD64 on my new Asus K8VSE Deluxe. The
installation process (kernel version is 2.6.3) identifies most of the
hardware, except for the Marvell ethernet controller. This is what lspci
says:

00:0a.0 Ethernet controller: Marvell: Unknown device 4320 (rev 13)

"modprobe sk98lin" gives the following error (repeated several times):

Class:  internal Software error
Nr:  0x19e
Msg:  Vpd Cannot read VPD keys

Can anyone explain to me what this means, or if there is an alternative
driver for the ethernet controller on this board?

Thanks,

Christoph

--=20
Christoph Terhechte <ct@fdk-berlin.de>


--=-uCNt0iQC/CJy+0Mfqq60
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAXxKCUMN/y69U3RgRAinrAJ467j/2sRuQ+gXMPXyFfGKnL0Fi9QCgjpCf
rw0avB0BhbyDRGeZPei8Rg4=
=gSin
-----END PGP SIGNATURE-----

--=-uCNt0iQC/CJy+0Mfqq60--
