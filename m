Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266381AbUAHXng (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 18:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266379AbUAHXng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 18:43:36 -0500
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:58093 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S266381AbUAHXnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 18:43:19 -0500
Subject: [2.6.1-rc2-mm1][BUG] kernel BUG at mm/rmap.c:305!
From: Ramon Rey Vicente <ramon.rey@augcyl.org>
Reply-To: ramon.rey@hispalinux.es
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sLIkbmQWof5hgoj7kHMD"
Organization: AUGCyL - http://www.augcyl.org
Message-Id: <1073605394.1070.3.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 09 Jan 2004 00:43:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sLIkbmQWof5hgoj7kHMD
Content-Type: multipart/mixed; boundary="=-GoXnAPg6bYE+/SEp3ncB"


--=-GoXnAPg6bYE+/SEp3ncB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


--=20
Ram=C3=B3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-GoXnAPg6bYE+/SEp3ncB
Content-Disposition: inline; filename=bug1
Content-Transfer-Encoding: base64
Content-Type: text/plain; name=bug1; charset=UTF-8

SmFuICA4IDIzOjEyOjI5IGRlYmlhbiBrZXJuZWw6IEVJUDogICAgMDA2MDpbdHJ5X3RvX3VubWFw
X29uZSs0NTYvNDgwXSAgICBOb3QgdGFpbnRlZCBWTEkNCkphbiAgOCAyMzoxMjoyOSBkZWJpYW4g
a2VybmVsOiBFRkxBR1M6IDAwMDEwMjQ2DQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDog
RUlQIGlzIGF0IHRyeV90b191bm1hcF9vbmUrMHgxYzgvMHgxZTANCkphbiAgOCAyMzoxMjoyOSBk
ZWJpYW4ga2VybmVsOiBlYXg6IDAwMDAwMDAwICAgZWJ4OiAwMDAwMzA3NiAgIGVjeDogY2IyMjQw
MGMgICBlZHg6IGNiMjI0MDBjDQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDogZXNpOiBj
MTE0Y2I5OCAgIGVkaTogYzExNGNiOTggICBlYnA6IGNiMjI0MDBjICAgZXNwOiBjZmUwM2QzOA0K
SmFuICA4IDIzOjEyOjI5IGRlYmlhbiBrZXJuZWw6IGRzOiAwMDdiICAgZXM6IDAwN2IgICBzczog
MDA2OA0KSmFuICA4IDIzOjEyOjI5IGRlYmlhbiBrZXJuZWw6IFByb2Nlc3Mga3N3YXBkMCAocGlk
OiA4LCB0aHJlYWRpbmZvPWNmZTAyMDAwIHRhc2s9Y2ZlMDhjZTApDQpKYW4gIDggMjM6MTI6Mjkg
ZGViaWFuIGtlcm5lbDogU3RhY2s6IDAwMDQwODQwIGNmZTAyMDAwIDAwMDAwMDAwIGMwMjdhYzgw
IGMxMTRjYjk4IDAwMDAwMDAxIGMxMTRjYjk4IGMwMTQ2MDIyIA0KSmFuICA4IDIzOjEyOjI5IGRl
YmlhbiBrZXJuZWw6ICAgICAgICBmZmZmZmZmZiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCBj
ZmUwMjAwMCAwMDAwMDAwMSBjMTE0Y2I5OCBjMDEzZGQ2MyANCkphbiAgOCAyMzoxMjoyOSBkZWJp
YW4ga2VybmVsOiAgICAgICAgY2ZlMDIwMDAgYzAxMjQ1ZTUgMDAwMDAwMDkgMDAwMDAwMDMgYzAy
N2FjODAgYzEwNjEyMDAgYzEwYjk5NTAgY2ZlMDIwMDAgDQpKYW4gIDggMjM6MTI6MjkgZGViaWFu
IGtlcm5lbDogQ2FsbCBUcmFjZToNCkphbiAgOCAyMzoxMjoyOSBkZWJpYW4ga2VybmVsOiAgW3Ry
eV90b191bm1hcCszMjIvMzg0XSB0cnlfdG9fdW5tYXArMHgxNDIvMHgxODANCkphbiAgOCAyMzox
MjoyOSBkZWJpYW4ga2VybmVsOiAgW3Nocmlua19saXN0KzU3OS8xNDA4XSBzaHJpbmtfbGlzdCsw
eDI0My8weDU4MA0KSmFuICA4IDIzOjEyOjI5IGRlYmlhbiBrZXJuZWw6ICBbZG9fdGltZXIrMTk3
LzIyNF0gZG9fdGltZXIrMHhjNS8weGUwDQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDog
IFtkb19zb2Z0aXJxKzE0MC8xNjBdIGRvX3NvZnRpcnErMHg4Yy8weGEwDQpKYW4gIDggMjM6MTI6
MjkgZGViaWFuIGtlcm5lbDogIFtjb21tb25faW50ZXJydXB0KzI0LzMyXSBjb21tb25faW50ZXJy
dXB0KzB4MTgvMHgyMA0KSmFuICA4IDIzOjEyOjI5IGRlYmlhbiBrZXJuZWw6ICBbX19wYWdldmVj
X3JlbGVhc2UrMjQvNjRdIF9fcGFnZXZlY19yZWxlYXNlKzB4MTgvMHg0MA0KSmFuICA4IDIzOjEy
OjI5IGRlYmlhbiBrZXJuZWw6ICBbc2hyaW5rX2NhY2hlKzQwOS84NjRdIHNocmlua19jYWNoZSsw
eDE5OS8weDM2MA0KSmFuICA4IDIzOjEyOjI5IGRlYmlhbiBrZXJuZWw6ICBbc2hyaW5rX3pvbmUr
MTA3LzEyOF0gc2hyaW5rX3pvbmUrMHg2Yi8weDgwDQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtl
cm5lbDogIFtiYWxhbmNlX3BnZGF0KzM1OS80ODBdIGJhbGFuY2VfcGdkYXQrMHgxNjcvMHgxZTAN
CkphbiAgOCAyMzoxMjoyOSBkZWJpYW4ga2VybmVsOiAgW2tzd2FwZCsyNTQvMjg4XSBrc3dhcGQr
MHhmZS8weDEyMA0KSmFuICA4IDIzOjEyOjI5IGRlYmlhbiBrZXJuZWw6ICBbYXV0b3JlbW92ZV93
YWtlX2Z1bmN0aW9uKzAvNjRdIGF1dG9yZW1vdmVfd2FrZV9mdW5jdGlvbisweDAvMHg0MA0KSmFu
ICA4IDIzOjEyOjI5IGRlYmlhbiBrZXJuZWw6ICBbcmV0X2Zyb21fZm9yays2LzMyXSByZXRfZnJv
bV9mb3JrKzB4Ni8weDIwDQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDogIFthdXRvcmVt
b3ZlX3dha2VfZnVuY3Rpb24rMC82NF0gYXV0b3JlbW92ZV93YWtlX2Z1bmN0aW9uKzB4MC8weDQw
DQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDogIFtrc3dhcGQrMC8yODhdIGtzd2FwZCsw
eDAvMHgxMjANCkphbiAgOCAyMzoxMjoyOSBkZWJpYW4ga2VybmVsOiAgW2tlcm5lbF90aHJlYWRf
aGVscGVyKzUvMzZdIGtlcm5lbF90aHJlYWRfaGVscGVyKzB4NS8weDI0DQpKYW4gIDggMjM6MTI6
MjkgZGViaWFuIGtlcm5lbDogDQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDogQ29kZTog
ZTggMWIgMDEgYzAgMDkgZDggODkgNDUgMDAgYjggMDAgMDAgMDAgMDAgODUgYzAgMGYgODQgMzIg
ZmYgZmYgZmYgMGYgMGIgNTcgMDEgMTEgMzIgMjUgYzAgZTkgMjUgZmYgZmYgZmYgMGYgMDEgM2Ig
ZTkgYmQgZmUgZmYgZmYgPDBmPiAwYiAzMSAwMSAxMSAzMiAyNSBjMCBlOSA2NSBmZSBmZiBmZiA4
ZCA3NCAyNiAwMCA4ZCBiYyAyNyAwMCANCg==

--=-GoXnAPg6bYE+/SEp3ncB--

--=-sLIkbmQWof5hgoj7kHMD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD4DBQA//esSRGk68b69cdURAghlAJ9Dp4ubLHvoIZCSJANnGQGVilBp3ACXR2cD
Ey5jwUpmbzShDU1CKwLHUw==
=7C0I
-----END PGP SIGNATURE-----

--=-sLIkbmQWof5hgoj7kHMD--

