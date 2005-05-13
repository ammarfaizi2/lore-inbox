Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVEMRZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVEMRZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 13:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVEMRZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 13:25:09 -0400
Received: from mail.timesys.com ([65.117.135.102]:8766 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262441AbVEMRYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 13:24:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Type: multipart/signed;
	micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xBv0Swrf7GBHO6gatHdB"
Content-Class: urn:content-classes:message
Date: Fri, 13 May 2005 13:24:30 -0400
Subject: [PATCH 2.6.11.7] Swapping OOPS fix for ATA Over Ethernet
Message-ID: <1116005072.9050.86.camel@jmcmullan.timesys>
Date: Fri, 13 May 2005 13:18:40 -0400
MIME-Version: 1.0
Message-ID: <1116005072.9050.86.camel@jmcmullan.timesys>
X-Mailer: Evolution 2.0.4-3mdk 
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.11.7] Swapping OOPS fix for ATA Over Ethernet
thread-index: AcVX385qITU/sj3HQFafJYsoC0ro8w==
From: "McMullan, Jason" <jason.mcmullan@timesys.com>
To: "PPC_LINUX" <linuxppc-embedded@ozlabs.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xBv0Swrf7GBHO6gatHdB
Content-Type: multipart/mixed; boundary="=-KO/UJfUyoPtCKubXaLRa"


--=-KO/UJfUyoPtCKubXaLRa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch fixes swapping for devices that do not need to define an
unplug_io_fn().


--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-KO/UJfUyoPtCKubXaLRa
Content-Disposition: attachment; filename=swapping-unplug-oops.patch
Content-Type: text/x-patch; name=swapping-unplug-oops.patch; charset=ISO-8859-1
Content-Transfer-Encoding: base64

RGVzY3JpcHRpb246IEZpeCBPT1BTIHdoZW4gc3dhcHBpbmcgb24gYSBkZXZpY2UgdGhhdCBkb2Vz
bid0IGhhdmUNCglhbiB1bnBsdWdfaW9fZm4gZGVmaW5lZCAoaWUsIEFUQSBPdmVyIEV0aGVybmV0
KQ0KU2lnbmVkLU9mZi1CeTogSmFzb24gTWNNdWxsYW4gPGphc29uLm1jbXVsbGFuQHRpbWVzeXMu
Y29tPg0KDQotLS0gbGludXgtb3JpZy9tbS9zd2FwZmlsZS5jDQorKysgbGludXgvbW0vc3dhcGZp
bGUuYw0KQEAgLTgwLDcgKzgwLDcgQEANCiAJCVdBUk5fT04ocGFnZV9jb3VudChwYWdlKSA8PSAx
KTsNCiANCiAJCWJkaSA9IGJkZXYtPmJkX2lub2RlLT5pX21hcHBpbmctPmJhY2tpbmdfZGV2X2lu
Zm87DQotCQliZGktPnVucGx1Z19pb19mbihiZGksIHBhZ2UpOw0KKwkJYmxrX3J1bl9iYWNraW5n
X2RldihiZGksIHBhZ2UpOw0KIAl9DQogCXVwX3JlYWQoJnN3YXBfdW5wbHVnX3NlbSk7DQogfQ0K



--=-KO/UJfUyoPtCKubXaLRa--

--=-xBv0Swrf7GBHO6gatHdB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBChOLO8/0vJ5szK6kRAjEfAJ988G8q55d34Dbr6HCnFBXxcFhtkwCgr5Zb
mCbHr/HBHUmNaU+qDZJx9oQ=
=r/Zv
-----END PGP SIGNATURE-----

--=-xBv0Swrf7GBHO6gatHdB--
