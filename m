Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbSJYO3Z>; Fri, 25 Oct 2002 10:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSJYO3Z>; Fri, 25 Oct 2002 10:29:25 -0400
Received: from B5acb.pppool.de ([213.7.90.203]:38879 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261432AbSJYO3X>; Fri, 25 Oct 2002 10:29:23 -0400
Subject: Re: Csum and csum copyroutines benchmark
From: Daniel Egger <degger@fhm.edu>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200210250643.g9P6hop13980@Port.imtp.ilyichevsk.odessa.ua>
References: <200210231218.18733.roy@karlsbakk.net>
	<20021024125030.A7529@flint.arm.linux.org.uk>
	<200210241249.g9OCnOp09750@Port.imtp.ilyichevsk.odessa.ua> 
	<200210250643.g9P6hop13980@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-40HWn+HVOTTmbilsl3A0"
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Oct 2002 16:26:10 +0200
Message-Id: <1035555970.1863.1.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-40HWn+HVOTTmbilsl3A0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fre, 2002-10-25 um 13.36 schrieb Denis Vlasenko:

On Via Ezra 667 I get this:
Csum benchmark program
buffer size: 4 Mb
Each test tried 16 times, max and min CPU cycles are reported.
Please disregard max values. They are due to system interference only.
csum tests:
                     kernel_csum - took  2739 max, 2727 min cycles per kb. =
sum=3D0x44000077
                     kernel_csum - took  2733 max, 2727 min cycles per kb. =
sum=3D0x44000077
                     kernel_csum - took  2733 max, 2727 min cycles per kb. =
sum=3D0x44000077
                  kernelpii_csum - took  2691 max, 2686 min cycles per kb. =
sum=3D0x44000077
copy tests:
                     kernel_copy - took  2044 max, 2014 min cycles per kb. =
sum=3D0x44000077
                     kernel_copy - took  2026 max, 2016 min cycles per kb. =
sum=3D0x44000077
                     kernel_copy - took  2061 max, 2016 min cycles per kb. =
sum=3D0x44000077
                  kernelpii_copy - took  1526 max, 1523 min cycles per kb. =
sum=3D0x44000077
Done

The nt* functions do not work on this CPU.

--=20
Servus,
       Daniel

--=-40HWn+HVOTTmbilsl3A0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQA9uVSCchlzsq9KoIYRAvEQAKC7kbxBiRINYhOnU/82lxc80uJGnQCgjFer
y594o4MU+LmNQHsgFQzOWik=
=fF/x
-----END PGP SIGNATURE-----

--=-40HWn+HVOTTmbilsl3A0--

