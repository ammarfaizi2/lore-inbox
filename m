Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVDRTBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVDRTBA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVDRTA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:00:59 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:63652 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262162AbVDRTAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:00:47 -0400
Subject: [PATCH 5/7] procfs privacy:  /proc/config.gz
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D64V1QhVaWslQECC4hpP"
Date: Mon, 18 Apr 2005 20:51:59 +0200
Message-Id: <1113850319.17341.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D64V1QhVaWslQECC4hpP
Content-Type: multipart/mixed; boundary="=-+pKyBmVu/gi+jYQutaqM"


--=-+pKyBmVu/gi+jYQutaqM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This patch changes the permissions of the procfs entry config.gz, thus,
non-root users are restricted from accessing it.

It's also available at:
http://pearls.tuxedo-es.org/patches/security/proc-privacy-1_kernel_configs.=
c.patch

--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-+pKyBmVu/gi+jYQutaqM
Content-Disposition: attachment; filename=proc-privacy-1_kernel_configs.c.patch
Content-Type: text/x-patch; name=proc-privacy-1_kernel_configs.c.patch;
	charset=us-ascii
Content-Transfer-Encoding: base64

ZGlmZiAtcHVOIGtlcm5lbC9jb25maWdzLmN+cHJvYy1wcml2YWN5LTEga2VybmVsL2NvbmZpZ3Mu
Yw0KLS0tIGxpbnV4LTIuNi4xMS9rZXJuZWwvY29uZmlncy5jfnByb2MtcHJpdmFjeS0xCTIwMDUt
MDQtMTcgMTg6MDQ6MzkuMjgxNjAwODU2ICswMjAwDQorKysgbGludXgtMi42LjExLWxvcmVuem8v
a2VybmVsL2NvbmZpZ3MuYwkyMDA1LTA0LTE3IDE4OjA1OjMzLjQ3ODM2MTY5NiArMDIwMA0KQEAg
LTg5LDcgKzg5LDcgQEAgc3RhdGljIGludCBfX2luaXQgaWtjb25maWdfaW5pdCh2b2lkKQ0KIAlz
dHJ1Y3QgcHJvY19kaXJfZW50cnkgKmVudHJ5Ow0KIA0KIAkvKiBjcmVhdGUgdGhlIGN1cnJlbnQg
Y29uZmlnIGZpbGUgKi8NCi0JZW50cnkgPSBjcmVhdGVfcHJvY19lbnRyeSgiY29uZmlnLmd6Iiwg
U19JRlJFRyB8IFNfSVJVR08sDQorCWVudHJ5ID0gY3JlYXRlX3Byb2NfZW50cnkoImNvbmZpZy5n
eiIsIFNfSUZSRUcgfCBTX0lSVVNSLA0KIAkJCQkgICZwcm9jX3Jvb3QpOw0KIAlpZiAoIWVudHJ5
KQ0KIAkJcmV0dXJuIC1FTk9NRU07DQo=


--=-+pKyBmVu/gi+jYQutaqM--

--=-D64V1QhVaWslQECC4hpP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZAHPDcEopW8rLewRAlbzAKDgWYSu0+Y0d/MVF2GSrNu8DTdi8ACeMmez
3wIvY55JwC962H9NbDLms58=
=5qwU
-----END PGP SIGNATURE-----

--=-D64V1QhVaWslQECC4hpP--

