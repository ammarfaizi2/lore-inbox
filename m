Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVDRTDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVDRTDG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVDRTBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:01:44 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:34469 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262164AbVDRTAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:00:52 -0400
Subject: [PATCH 7/7] procfs privacy:  /proc/iomem & /proc/ioports
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ujWRBe6hbEdFbsXUbpTZ"
Date: Mon, 18 Apr 2005 20:57:48 +0200
Message-Id: <1113850668.17341.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ujWRBe6hbEdFbsXUbpTZ
Content-Type: multipart/mixed; boundary="=-swC+SoOTkQOhqXaaNuc/"


--=-swC+SoOTkQOhqXaaNuc/
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This patch changes the permissions of the procfs entries ioports and
iomem to restrict non-root users from accessing them.

It's also available at
http://pearls.tuxedo-es.org/patches/security/proc-privacy-1_kernel_resource=
.c.patch.

(last patch from the procfs privacy patch-set)

The whole patch is available at:
http://pearls.tuxedo-es.org/patches/security/proc-privacy-1.patch

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-swC+SoOTkQOhqXaaNuc/
Content-Disposition: attachment; filename=proc-privacy-1_kernel_resource.c.patch
Content-Type: text/x-patch; name=proc-privacy-1_kernel_resource.c.patch;
	charset=us-ascii
Content-Transfer-Encoding: base64

ZGlmZiAtcHVOIGtlcm5lbC9yZXNvdXJjZS5jfnByb2MtcHJpdmFjeS0xIGtlcm5lbC9yZXNvdXJj
ZS5jDQotLS0gbGludXgtMi42LjExL2tlcm5lbC9yZXNvdXJjZS5jfnByb2MtcHJpdmFjeS0xCTIw
MDUtMDQtMTcgMTg6MDY6NTYuMjIxNzgyNzg0ICswMjAwDQorKysgbGludXgtMi42LjExLWxvcmVu
em8va2VybmVsL3Jlc291cmNlLmMJMjAwNS0wNC0xNyAxODowNzo1NS42ODU3NDI4ODggKzAyMDAN
CkBAIC0xMzYsMTAgKzEzNiwxMCBAQCBzdGF0aWMgaW50IF9faW5pdCBpb3Jlc291cmNlc19pbml0
KHZvaWQpDQogew0KIAlzdHJ1Y3QgcHJvY19kaXJfZW50cnkgKmVudHJ5Ow0KIA0KLQllbnRyeSA9
IGNyZWF0ZV9wcm9jX2VudHJ5KCJpb3BvcnRzIiwgMCwgTlVMTCk7DQorCWVudHJ5ID0gY3JlYXRl
X3Byb2NfZW50cnkoImlvcG9ydHMiLCBTX0lSVVNSLCBOVUxMKTsNCiAJaWYgKGVudHJ5KQ0KIAkJ
ZW50cnktPnByb2NfZm9wcyA9ICZwcm9jX2lvcG9ydHNfb3BlcmF0aW9uczsNCi0JZW50cnkgPSBj
cmVhdGVfcHJvY19lbnRyeSgiaW9tZW0iLCAwLCBOVUxMKTsNCisJZW50cnkgPSBjcmVhdGVfcHJv
Y19lbnRyeSgiaW9tZW0iLCBTX0lSVVNSLCBOVUxMKTsNCiAJaWYgKGVudHJ5KQ0KIAkJZW50cnkt
PnByb2NfZm9wcyA9ICZwcm9jX2lvbWVtX29wZXJhdGlvbnM7DQogCXJldHVybiAwOw0K


--=-swC+SoOTkQOhqXaaNuc/--

--=-ujWRBe6hbEdFbsXUbpTZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZAMsDcEopW8rLewRAkRpAJwPpHCD/sBfz6g7TnLcwQ7EnH91LgCghnBT
9RRGQdQXM+m8e/+/tbcd2lA=
=Izka
-----END PGP SIGNATURE-----

--=-ujWRBe6hbEdFbsXUbpTZ--

