Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263082AbVHES5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbVHES5b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbVHES50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:57:26 -0400
Received: from mail.topfen.net ([212.24.114.150]:36493 "EHLO mail.topfen.net")
	by vger.kernel.org with ESMTP id S262818AbVHES5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:57:07 -0400
Date: Fri, 5 Aug 2005 20:56:51 +0200
From: JG <jg@cms.ac>
To: linux-kernel@vger.kernel.org
Subject: Re: sluggish/very slow usb mouse on hp nx6110 notebook => acpi
 problem
Message-ID: <20050805205651.2cd22f1b@x90.0x4a47.net>
In-Reply-To: <20050805195243.4e9df3de@x90.0x4a47.net>
References: <20050805195243.4e9df3de@x90.0x4a47.net>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Fri__5_Aug_2005_20_56_51_+0200_vSe4L5BVV0+y67c4;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Fri__5_Aug_2005_20_56_51_+0200_vSe4L5BVV0+y67c4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

hm, i currently have "acpi=3Doff noacpi noapic reboot=3Db" as kernel
parameter.

if i remove the acpi stuff and enable acpi, the usb mouse works fine..
but after some time (5-10min) the kacpid process goes havoc and eats
all cpu and the whole system is unresponsive- that's the reason i added
those acpi=3Doff parameters the first time when installing gentoo..

i tested with gentoo-2.6.12-r7 and vanilla-2.6.13rc5

JG

--Signature_Fri__5_Aug_2005_20_56_51_+0200_vSe4L5BVV0+y67c4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC87Z7U788cpz6t2kRAmtcAJ9W/+wY4Y3QkXQhXNVo9j68IqT3TwCeLyBc
mIRPZOsj1DdQ35MolOxULvI=
=Iu5H
-----END PGP SIGNATURE-----

--Signature_Fri__5_Aug_2005_20_56_51_+0200_vSe4L5BVV0+y67c4--
