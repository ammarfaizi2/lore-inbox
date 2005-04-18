Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVDRTBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVDRTBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVDRTBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:01:16 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:18853 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262163AbVDRTAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:00:50 -0400
Subject: [PATCH 6/7] procfs privacy: /proc/kallsyms
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D2Lz3XGUhLrmRLalKbOb"
Date: Mon, 18 Apr 2005 20:53:58 +0200
Message-Id: <1113850439.17341.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D2Lz3XGUhLrmRLalKbOb
Content-Type: multipart/mixed; boundary="=-rIX8qZ24obCxN0waTB2E"


--=-rIX8qZ24obCxN0waTB2E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This patch changes the permissions of the procfs entry kallsyms, thus,
non-root users are restricted from accessing it.

It's also available at:
http://pearls.tuxedo-es.org/patches/security/proc-privacy-1_kernel_kallsyms=
.c.patch

--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-rIX8qZ24obCxN0waTB2E
Content-Disposition: attachment; filename=proc-privacy-1_kernel_kallsyms.c.patch
Content-Type: text/x-patch; name=proc-privacy-1_kernel_kallsyms.c.patch;
	charset=us-ascii
Content-Transfer-Encoding: base64

ZGlmZiAtcHVOIGtlcm5lbC9rYWxsc3ltcy5jfnByb2MtcHJpdmFjeS0xIGtlcm5lbC9rYWxsc3lt
cy5jDQotLS0gbGludXgtMi42LjExL2tlcm5lbC9rYWxsc3ltcy5jfnByb2MtcHJpdmFjeS0xCTIw
MDUtMDQtMTcgMTg6MDY6MDEuMzgwMTE5OTg0ICswMjAwDQorKysgbGludXgtMi42LjExLWxvcmVu
em8va2VybmVsL2thbGxzeW1zLmMJMjAwNS0wNC0xNyAxODowNjoyNy4zNzgxNjc2ODAgKzAyMDAN
CkBAIC0zODgsNyArMzg4LDcgQEAgaW50IF9faW5pdCBrYWxsc3ltc19pbml0KHZvaWQpDQogew0K
IAlzdHJ1Y3QgcHJvY19kaXJfZW50cnkgKmVudHJ5Ow0KIA0KLQllbnRyeSA9IGNyZWF0ZV9wcm9j
X2VudHJ5KCJrYWxsc3ltcyIsIDA0NDQsIE5VTEwpOw0KKwllbnRyeSA9IGNyZWF0ZV9wcm9jX2Vu
dHJ5KCJrYWxsc3ltcyIsIFNfSUZSRUcgfCBTX0lSVVNSLCBOVUxMKTsNCiAJaWYgKGVudHJ5KQ0K
IAkJZW50cnktPnByb2NfZm9wcyA9ICZrYWxsc3ltc19vcGVyYXRpb25zOw0KIAlyZXR1cm4gMDsN
Cg==


--=-rIX8qZ24obCxN0waTB2E--

--=-D2Lz3XGUhLrmRLalKbOb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZAJGDcEopW8rLewRAvaQAJ9CoHDc0KDrMp20bCS4hXxNy1X7XQCgv8GL
8E6pQ61ba9vso4K+cEupfxY=
=cuqW
-----END PGP SIGNATURE-----

--=-D2Lz3XGUhLrmRLalKbOb--

