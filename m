Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265537AbTIDV5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265565AbTIDV4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:56:06 -0400
Received: from [165.165.195.1] ([165.165.195.1]:43392 "EHLO nosferatu.lan")
	by vger.kernel.org with ESMTP id S265537AbTIDVzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:55:54 -0400
Subject: Re: [PATCH 2.6.0-test4][sk98lin] sk98lin driver with hardware bug
	make eth unusable
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Mirko Lindner <mlindner@syskonnect.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1062066254.5426.391.camel@mlindner-lin.skd.de>
References: <200308121301.43873.gallir@uib.es>
	 <1060689676.13254.172.camel@workshop.saharacpt.lan>
	 <200308121440.50395.gallir@uib.es> <1061663721.13460.5.camel@nosferatu.lan>
	 <1061728032.13460.28.camel@nosferatu.lan>
	 <1062066254.5426.391.camel@mlindner-lin.skd.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-f72mzJ/Scd7vYzEmts58"
Message-Id: <1062712523.10805.2.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 04 Sep 2003 23:55:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f72mzJ/Scd7vYzEmts58
Content-Type: multipart/mixed; boundary="=-CZLS0GJuJIoUtPVgB8ql"


--=-CZLS0GJuJIoUtPVgB8ql
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-08-28 at 12:24, Mirko Lindner wrote:
> The newest version of the sk98lin driver with some fixes for HW Csum was
> sent to the driver Maintainers today (Kernel 2.4.22 and Kernel
> 2.6.0-test4). Here is a list with fixes and new functions:
>=20
> VERSION 6.17 (Thu Aug 26 2003 - mlindner)
> New Features:

I need to apply attached patch to test4-bk5 to get it to compile (on
SMP).  Other than that, it seems ok.


Thanks,

--=20

Martin Schlemmer




--=-CZLS0GJuJIoUtPVgB8ql
Content-Disposition: attachment; filename=sk98lin-smp-fixup.patch
Content-Transfer-Encoding: base64
Content-Type: text/plain; name=sk98lin-smp-fixup.patch; charset=iso-8859-1

LS0tIDEvZHJpdmVycy9uZXQvc2s5OGxpbi9za2RpbS5jCTIwMDMtMDktMDMgMjI6NTk6MzAuNzQx
NzYyNTkyICswMjAwDQorKysgMi9kcml2ZXJzL25ldC9zazk4bGluL3NrZGltLmMJMjAwMy0wOS0w
MyAyMjo1ODozNi4xNDUwNjI1NTIgKzAyMDANCkBAIC0zMTksNiArMzE5LDcgQEAgR2V0Q3VycmVu
dFN5c3RlbUxvYWQoU0tfQUMgKnBBQykgew0KIAl1bnNpZ25lZCBpbnQgIFVzZWRUaW1lICAgID0g
MDsNCiAJdW5zaWduZWQgaW50ICBTeXN0ZW1Mb2FkICA9IDA7DQogI2lmZGVmIENPTkZJR19TTVAN
CisJZXh0ZXJuIGludCBzbXBfbnVtX2NwdXM7DQogCXVuc2lnbmVkIGludCAgU0tOdW1DcHVzICAg
PSBzbXBfbnVtX2NwdXM7DQogI2Vsc2UNCiAJdW5zaWduZWQgaW50ICBTS051bUNwdXMgICA9IDE7
DQo=

--=-CZLS0GJuJIoUtPVgB8ql--

--=-f72mzJ/Scd7vYzEmts58
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/V7TLqburzKaJYLYRAhmZAJwLYSUefc5RdBETbJlzGeC2Nv5fNQCcDexn
eoc6ruv2/T3tP+rPy9KibRg=
=PUXZ
-----END PGP SIGNATURE-----

--=-f72mzJ/Scd7vYzEmts58--

