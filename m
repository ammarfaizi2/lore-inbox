Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbUKMRz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbUKMRz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 12:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbUKMRz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 12:55:59 -0500
Received: from ctb-mesg6.saix.net ([196.25.240.78]:61902 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S261855AbUKMRzv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 12:55:51 -0500
Subject: Re: 2.6.10-rc1-mm5 [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041111012333.1b529478.akpm@osdl.org>
References: <20041111012333.1b529478.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/Svg4l6eU7W/PpM2lyDb"
Date: Sat, 13 Nov 2004 19:55:53 +0200
Message-Id: <1100368553.12239.3.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/Svg4l6eU7W/PpM2lyDb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-11-11 at 01:23 -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/=
2.6.10-rc1-mm5/
>=20
>=20
> - Various updates to various things.  Nothing really stands out.
>=20
> - Let me be the first to report this:
>=20
> 	*** Warning: "kgdb_irq" [drivers/serial/serial_core.ko] undefined!
> 	*** Warning: "hotplug_path" [drivers/acpi/container.ko] undefined!
>=20
>=20
>=20

I want to imagine there is some reason why some threading apps will have
issues?  I have since rc1-mm4 issues with evolution - some threads do
not seem to come out of sleep or get running time for some reason.
Unfortunately I cannot find the thread again.  Is there a patch I can
apply/revert to get it to work for now?


Thanks,

--=20
Martin Schlemmer


--=-/Svg4l6eU7W/PpM2lyDb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBlkqpqburzKaJYLYRArSkAJ9VtMswF/kJi4CVseyc9ZdUgXAW+wCbBsyV
0O/7D/JRToLqHblyGzjv97c=
=kyW0
-----END PGP SIGNATURE-----

--=-/Svg4l6eU7W/PpM2lyDb--

