Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVDRSlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVDRSlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 14:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVDRSlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 14:41:05 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:53722 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262136AbVDRSkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 14:40:55 -0400
Subject: [PATCH 1/7] procfs privacy: /proc/bus/pci
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-M/M3Gnm6lpweZ85it1g7"
Date: Mon, 18 Apr 2005 20:33:17 +0200
Message-Id: <1113849197.17341.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M/M3Gnm6lpweZ85it1g7
Content-Type: multipart/mixed; boundary="=-IPz41u/oMzg2SmovfqgH"


--=-IPz41u/oMzg2SmovfqgH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This patch changes the permissions of the /proc/bus/pci directory entry,
so, non-root users are restricted of accessing it's content.

It's also available at:
http://pearls.tuxedo-es.org/patches/security/proc-privacy-1_drivers_pci_pro=
c.c.patch

--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-IPz41u/oMzg2SmovfqgH
Content-Disposition: attachment; filename=proc-privacy-1_drivers_pci_proc.c.patch
Content-Type: text/x-patch; name=proc-privacy-1_drivers_pci_proc.c.patch;
	charset=us-ascii
Content-Transfer-Encoding: base64

ZGlmZiAtcHVOIGRyaXZlcnMvcGNpL3Byb2MuY35wcm9jLXByaXZhY3ktMSBkcml2ZXJzL3BjaS9w
cm9jLmMNCi0tLSBsaW51eC0yLjYuMTEvZHJpdmVycy9wY2kvcHJvYy5jfnByb2MtcHJpdmFjeS0x
CTIwMDUtMDQtMTcgMTc6NTA6NDkuMDMzODE3NzA0ICswMjAwDQorKysgbGludXgtMi42LjExLWxv
cmVuem8vZHJpdmVycy9wY2kvcHJvYy5jCTIwMDUtMDQtMTcgMTc6NTU6MTEuMzIxOTQzODQ4ICsw
MjAwDQpAQCAtNTY1LDcgKzU2NSw3IEBAIHN0YXRpYyBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIHBy
b2NfcGNpX28NCiANCiBzdGF0aWMgdm9pZCBsZWdhY3lfcHJvY19pbml0KHZvaWQpDQogew0KLQlz
dHJ1Y3QgcHJvY19kaXJfZW50cnkgKiBlbnRyeSA9IGNyZWF0ZV9wcm9jX2VudHJ5KCJwY2kiLCAw
LCBOVUxMKTsNCisJc3RydWN0IHByb2NfZGlyX2VudHJ5ICogZW50cnkgPSBjcmVhdGVfcHJvY19l
bnRyeSgicGNpIiwgU19JUlVTUiwgTlVMTCk7DQogCWlmIChlbnRyeSkNCiAJCWVudHJ5LT5wcm9j
X2ZvcHMgPSAmcHJvY19wY2lfb3BlcmF0aW9uczsNCiB9DQpAQCAtNTk0LDcgKzU5NCw3IEBAIHN0
YXRpYyBpbnQgX19pbml0IHBjaV9wcm9jX2luaXQodm9pZCkNCiB7DQogCXN0cnVjdCBwcm9jX2Rp
cl9lbnRyeSAqZW50cnk7DQogCXN0cnVjdCBwY2lfZGV2ICpkZXYgPSBOVUxMOw0KLQlwcm9jX2J1
c19wY2lfZGlyID0gcHJvY19ta2RpcigicGNpIiwgcHJvY19idXMpOw0KKwlwcm9jX2J1c19wY2lf
ZGlyID0gcHJvY19ta2Rpcl9tb2RlKCJwY2kiLCBTX0lSVVNSIHwgU19JWFVTUiwgcHJvY19idXMp
Ow0KIAllbnRyeSA9IGNyZWF0ZV9wcm9jX2VudHJ5KCJkZXZpY2VzIiwgMCwgcHJvY19idXNfcGNp
X2Rpcik7DQogCWlmIChlbnRyeSkNCiAJCWVudHJ5LT5wcm9jX2ZvcHMgPSAmcHJvY19idXNfcGNp
X2Rldl9vcGVyYXRpb25zOw0K


--=-IPz41u/oMzg2SmovfqgH--

--=-M/M3Gnm6lpweZ85it1g7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCY/1tDcEopW8rLewRApadAKCTGW1VKUeb9DcTv9oP+yu0q4qXXgCgmapB
Dhoixr86yWuYmjm4Ci57KmY=
=Pq5r
-----END PGP SIGNATURE-----

--=-M/M3Gnm6lpweZ85it1g7--

