Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUKMVSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUKMVSq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 16:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUKMVSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 16:18:46 -0500
Received: from ctb-mesg2.saix.net ([196.25.240.74]:55754 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261179AbUKMVQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 16:16:28 -0500
Subject: Re: 2.6.10-rc1-mm5 [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1100368553.12239.3.camel@nosferatu.lan>
References: <20041111012333.1b529478.akpm@osdl.org>
	 <1100368553.12239.3.camel@nosferatu.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+V9LEF8JwJK5Fp9WNvjE"
Date: Sat, 13 Nov 2004 23:16:33 +0200
Message-Id: <1100380593.12663.1.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+V9LEF8JwJK5Fp9WNvjE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-11-13 at 19:55 +0200, Martin Schlemmer wrote:
> On Thu, 2004-11-11 at 01:23 -0800, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc=
1/2.6.10-rc1-mm5/
> >=20
> >=20
> > - Various updates to various things.  Nothing really stands out.
> >=20
> > - Let me be the first to report this:
> >=20
> > 	*** Warning: "kgdb_irq" [drivers/serial/serial_core.ko] undefined!
> > 	*** Warning: "hotplug_path" [drivers/acpi/container.ko] undefined!
> >=20
> >=20
> >=20
>=20
> I want to imagine there is some reason why some threading apps will have
> issues?  I have since rc1-mm4 issues with evolution - some threads do
> not seem to come out of sleep or get running time for some reason.
> Unfortunately I cannot find the thread again.  Is there a patch I can
> apply/revert to get it to work for now?
>=20

I should note that if I killall -STOP and then killall -CONT all
evolution processes (evolution-data-server-1.0, evolution-alarm-notify
and evolution-2.0) it works again for a while.  The issue happens pretty
quick after I start evo ...


Thanks,

--=20
Martin Schlemmer


--=-+V9LEF8JwJK5Fp9WNvjE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBlnmxqburzKaJYLYRAq38AJ4/TPTI9yrWoJofmJFUBTb56kbG5gCgi6eF
U7fBewD48xgRLDwIXwizZ2s=
=VYE1
-----END PGP SIGNATURE-----

--=-+V9LEF8JwJK5Fp9WNvjE--

