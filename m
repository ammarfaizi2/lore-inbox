Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbTL1DnW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 22:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbTL1DnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 22:43:22 -0500
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:13552 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S264966AbTL1DnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 22:43:20 -0500
Subject: [PATCH] Re: 2.6.0-mm1
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <rrey@ranty.pantax.net>
Reply-To: ramon.rey@hispalinux.es
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20031222211131.70a963fb.akpm@osdl.org>
References: <20031222211131.70a963fb.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-h6z3fSPBRGjpeZjSg1AZ"
Message-Id: <1072582996.6822.24.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 28 Dec 2003 04:43:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h6z3fSPBRGjpeZjSg1AZ
Content-Type: multipart/mixed; boundary="=-YmRVpP8k+PUGm34xqqUD"


--=-YmRVpP8k+PUGm34xqqUD
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

El mar, 23-12-2003 a las 06:11, Andrew Morton escribi=F3:

> +mt-ranier-support.patch
>=20
>  Mt Ranier support in the CDROM uniform layer.

Somebody forgot this WAIT_CMD-to-ATAPI_WAIT_PC change
--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-YmRVpP8k+PUGm34xqqUD
Content-Disposition: inline; filename=fix_idecd_seek_timeout_macro.patch
Content-Type: text/x-patch; name=fix_idecd_seek_timeout_macro.patch;
	charset=iso-8859-15
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4wLW9yaWcvZHJpdmVycy9pZGUvaWRlLWNkLmMJMjAwMy0xMi0yOCAwNDoy
NjozMS4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC0yLjYvZHJpdmVycy9pZGUvaWRlLWNkLmMJ
MjAwMy0xMi0yOCAwMzo1NDoxOC4wMDAwMDAwMDAgKzAxMDANCkBAIC0xMzE4LDcgKzEzMTgsNyBA
QA0KIA0KICNkZWZpbmUgSURFQ0RfU0VFS19USFJFU0hPTEQJKDEwMDApCQkJLyogMTAwMCBibG9j
a3MgKi8NCiAjZGVmaW5lIElERUNEX1NFRUtfVElNRVIJKDUgKiBXQUlUX01JTl9TTEVFUCkJLyog
MTAwIG1zICovDQotI2RlZmluZSBJREVDRF9TRUVLX1RJTUVPVVQJKDIgKiBXQUlUX0NNRCkJCS8q
IDIwIHNlYyAqLw0KKyNkZWZpbmUgSURFQ0RfU0VFS19USU1FT1VUCSgyICogQVRBUElfV0FJVF9Q
QykJLyogMjAgc2VjICovDQogDQogc3RhdGljIGlkZV9zdGFydHN0b3BfdCBjZHJvbV9zZWVrX2lu
dHIgKGlkZV9kcml2ZV90ICpkcml2ZSkNCiB7DQo=

--=-YmRVpP8k+PUGm34xqqUD--

--=-h6z3fSPBRGjpeZjSg1AZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7lFURGk68b69cdURAkDbAJ93VbAw9OYUp86QeD2gkLjZRer9CwCdHSu+
pq9yNfxoIH4e5jPxs435+zY=
=b4kC
-----END PGP SIGNATURE-----

--=-h6z3fSPBRGjpeZjSg1AZ--

