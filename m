Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbTEOTgK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264190AbTEOTgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:36:10 -0400
Received: from www.hostsharing.net ([212.42.230.151]:3229 "EHLO
	pima.hostsharing.net") by vger.kernel.org with ESMTP
	id S264188AbTEOTgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:36:09 -0400
Date: Thu, 15 May 2003 21:50:25 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: radeonfb and acpi
Message-ID: <20030515195025.GB696@gandalf.home.lxtec.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
Organization: LXTEC
X-gnupg-key-fingerprint: BE65 85E4 4867 7E9B 1F2A  B2CE DC88 3C6E C54F 7FB0
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi all,

I am running 2.4.21-rc2-ac2 with a radeonfb and dri. If ACPI is
enabled the power of 2.4 GHz Intel i686 is reduced to minimum the half.=20
The acpi modules of 2.4.20 are working perfect in that constellation.
(Need that for power off at shutdown). DRI and XF86 4.3.0 are
running much better than the ati-drivers.

BTW: Which kernel-params do I need to start radeonfb with
video:radeonfb=3D1280x1024-16@75 ? The FB even starts with=20
colour frame buffer device 80x30.

Any hints?

Ciao

Elimar


--=20
  Never make anything simple and efficient when a way=20
  can be found to make it complex and wonderful ;-)

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+w++B3Ig8bsVPf7ARApckAKCnVEHSBq8ecS9+arSvGzUNduyXmgCghLNl
zG8Y6h0xWANQcb0pVLnx4sE=
=m4on
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
