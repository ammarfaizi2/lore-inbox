Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTIHWIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTIHWIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:08:12 -0400
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:5782 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S263593AbTIHWII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:08:08 -0400
Subject: [BUG][v2.6.0-test5] __ext3_journal_get_write_access<2>EXT3-fs error
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Nv8+UkV/y0UtF6TF06dH"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1063058883.908.6.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 00:08:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Nv8+UkV/y0UtF6TF06dH
Content-Type: multipart/mixed; boundary="=-dght0sji7YjuF6LCI01H"


--=-dght0sji7YjuF6LCI01H
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi

This happens deleting a big directory (~400 MiB) with many files and
subdirs
--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
------------------------------------------------------------
gpg public key ID 0xBEBD71D5 # http://pgp.escomposlinux.org/

--=-dght0sji7YjuF6LCI01H
Content-Disposition: inline; filename=sada
Content-Type: text/plain; name=sada; charset=ISO-8859-15
Content-Transfer-Encoding: base64

ZXAgIDggMjM6MzQ6NTUgZGViaWFuIGtlcm5lbDogRVhUMy1mcyBlcnJvciAoZGV2aWNlIGhkYjEp
OiBleHQzX2ZyZWVfYmxvY2tzOiBGcmVlaW5nIGJsb2NrcyBpbiBzeXN0ZW0gem9uZXMgLSBCbG9j
ayA9IDUxMiwgY291bnQgPSAxDQpTZXAgIDggMjM6MzQ6NTUgZGViaWFuIGtlcm5lbDogQWJvcnRp
bmcgam91cm5hbCBvbiBkZXZpY2UgaGRiMS4NClNlcCAgOCAyMzozNDo1NSBkZWJpYW4ga2VybmVs
OiBleHQzX2ZyZWVfYmxvY2tzOiBhYm9ydGluZyB0cmFuc2FjdGlvbjogSm91cm5hbCBoYXMgYWJv
cnRlZCBpbiBfX2V4dDNfam91cm5hbF9nZXRfdW5kb19hY2Nlc3M8Mj5FWFQzLWZzIGVycm9yIChk
ZXZpY2UgaGRiMSkgaW4gZXh0M19mcmVlX2Jsb2NrczogSm91cm5hbCBoYXMgYWJvcnRlZA0KU2Vw
ICA4IDIzOjM0OjU1IGRlYmlhbiBrZXJuZWw6IGV4dDNfcmVzZXJ2ZV9pbm9kZV93cml0ZTogYWJv
cnRpbmcgdHJhbnNhY3Rpb246IEpvdXJuYWwgaGFzIGFib3J0ZWQgaW4gX19leHQzX2pvdXJuYWxf
Z2V0X3dyaXRlX2FjY2VzczwyPkVYVDMtZnMgZXJyb3IgKGRldmljZSBoZGIxKSBpbiBleHQzX3Jl
c2VydmVfaW5vZGVfd3JpdGU6IEpvdXJuYWwgaGFzIGFib3J0ZWQNClNlcCAgOCAyMzozNDo1NSBk
ZWJpYW4ga2VybmVsOiBFWFQzLWZzIGVycm9yIChkZXZpY2UgaGRiMSkgaW4gZXh0M190cnVuY2F0
ZTogSm91cm5hbCBoYXMgYWJvcnRlZA0KU2VwICA4IDIzOjM0OjU1IGRlYmlhbiBrZXJuZWw6IGV4
dDNfcmVzZXJ2ZV9pbm9kZV93cml0ZTogYWJvcnRpbmcgdHJhbnNhY3Rpb246IEpvdXJuYWwgaGFz
IGFib3J0ZWQgaW4gX19leHQzX2pvdXJuYWxfZ2V0X3dyaXRlX2FjY2VzczwyPkVYVDMtZnMgZXJy
b3IgKGRldmljZSBoZGIxKSBpbiBleHQzX3Jlc2VydmVfaW5vZGVfd3JpdGU6IEpvdXJuYWwgaGFz
IGFib3J0ZWQNClNlcCAgOCAyMzozNDo1NSBkZWJpYW4ga2VybmVsOiBFWFQzLWZzIGVycm9yIChk
ZXZpY2UgaGRiMSkgaW4gZXh0M19vcnBoYW5fZGVsOiBKb3VybmFsIGhhcyBhYm9ydGVkDQpTZXAg
IDggMjM6MzQ6NTUgZGViaWFuIGtlcm5lbDogZXh0M19yZXNlcnZlX2lub2RlX3dyaXRlOiBhYm9y
dGluZyB0cmFuc2FjdGlvbjogSm91cm5hbCBoYXMgYWJvcnRlZCBpbiBfX2V4dDNfam91cm5hbF9n
ZXRfd3JpdGVfYWNjZXNzPDI+RVhUMy1mcyBlcnJvciAoZGV2aWNlIGhkYjEpIGluIGV4dDNfcmVz
ZXJ2ZV9pbm9kZV93cml0ZTogSm91cm5hbCBoYXMgYWJvcnRlZA0KU2VwICA4IDIzOjM0OjU1IGRl
YmlhbiBrZXJuZWw6IEVYVDMtZnMgZXJyb3IgKGRldmljZSBoZGIxKSBpbiBleHQzX2RlbGV0ZV9p
bm9kZTogSm91cm5hbCBoYXMgYWJvcnRlZA0KU2VwICA4IDIzOjM0OjU1IGRlYmlhbiBrZXJuZWw6
IGV4dDNfYWJvcnQgY2FsbGVkLg0KU2VwICA4IDIzOjM0OjU1IGRlYmlhbiBrZXJuZWw6IEVYVDMt
ZnMgYWJvcnQgKGRldmljZSBoZGIxKTogZXh0M19qb3VybmFsX3N0YXJ0OiBEZXRlY3RlZCBhYm9y
dGVkIGpvdXJuYWwNClNlcCAgOCAyMzozNDo1NSBkZWJpYW4ga2VybmVsOiBSZW1vdW50aW5nIGZp
bGVzeXN0ZW0gcmVhZC1vbmx5DQo=

--=-dght0sji7YjuF6LCI01H--

--=-Nv8+UkV/y0UtF6TF06dH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/XP3DRGk68b69cdURAsxiAJ9XgUSuuwmW/vEZUF5iy45+wNNfXgCeKvKi
6evA4RmWRjGFwCvfND89O9w=
=9R79
-----END PGP SIGNATURE-----

--=-Nv8+UkV/y0UtF6TF06dH--

