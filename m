Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTIHWK5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbTIHWK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:10:57 -0400
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:4504 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S263637AbTIHWKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:10:51 -0400
Subject: [OOPS][v2.6.0-test5] Unable to handle kernel NULL pointer
	dereference at virtual address 00000204
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-I+nmiGV6bRTHLx1FDiqB"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1063059043.913.9.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 00:10:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I+nmiGV6bRTHLx1FDiqB
Content-Type: multipart/mixed; boundary="=-EC0mJbInqeqG6Oy7kj4r"


--=-EC0mJbInqeqG6Oy7kj4r
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi

The log is attached.
--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
------------------------------------------------------------
gpg public key ID 0xBEBD71D5 # http://pgp.escomposlinux.org/

--=-EC0mJbInqeqG6Oy7kj4r
Content-Disposition: inline; filename=log-oops
Content-Type: text/plain; name=log-oops; charset=ISO-8859-15
Content-Transfer-Encoding: base64

ZXAgIDggMjI6NDk6NDYgZGViaWFuIGtlcm5lbDogVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDIwNA0KU2VwICA4
IDIyOjQ5OjQ2IGRlYmlhbiBrZXJuZWw6ICBwcmludGluZyBlaXA6DQpTZXAgIDggMjI6NDk6NDYg
ZGViaWFuIGtlcm5lbDogYzAxMzExNzUNClNlcCAgOCAyMjo0OTo0NiBkZWJpYW4ga2VybmVsOiAq
cGRlID0gMDAwMDAwMDANClNlcCAgOCAyMjo0OTo0NiBkZWJpYW4ga2VybmVsOiBPb3BzOiAwMDAy
IFsjMV0NClNlcCAgOCAyMjo0OTo0NiBkZWJpYW4ga2VybmVsOiBDUFU6ICAgIDANClNlcCAgOCAy
Mjo0OTo0NiBkZWJpYW4ga2VybmVsOiBFSVA6ICAgIDAwNjA6W2ZpbmRfZ2V0X3BhZ2VzKzUzLzk2
XSAgICBOb3QgdGFpbnRlZA0KU2VwICA4IDIyOjQ5OjQ2IGRlYmlhbiBrZXJuZWw6IEVGTEFHUzog
MDAwMTAyMDINClNlcCAgOCAyMjo0OTo0NiBkZWJpYW4ga2VybmVsOiBFSVAgaXMgYXQgZmluZF9n
ZXRfcGFnZXMrMHgzNS8weDYwDQpTZXAgIDggMjI6NDk6NDYgZGViaWFuIGtlcm5lbDogZWF4OiAw
MDAwMDIwMCAgIGVieDogMDAwMDAwMDQgICBlY3g6IDAwMDAwMDAxICAgZWR4OiBjMTNkN2UyMA0K
U2VwICA4IDIyOjQ5OjQ2IGRlYmlhbiBrZXJuZWw6IGVzaTogYzEzZDdlMTQgICBlZGk6IDAwMDAw
MDczICAgZWJwOiBjMTNkNjAwMCAgIGVzcDogYzEzZDdkZDQNClNlcCAgOCAyMjo0OTo0NiBkZWJp
YW4ga2VybmVsOiBkczogMDA3YiAgIGVzOiAwMDdiICAgc3M6IDAwNjgNClNlcCAgOCAyMjo0OTo0
NiBkZWJpYW4ga2VybmVsOiBQcm9jZXNzIGtzd2FwZDAgKHBpZDogOCwgdGhyZWFkaW5mbz1jMTNk
NjAwMCB0YXNrPWMxM2RjYzgwKQ0KU2VwICA4IDIyOjQ5OjQ2IGRlYmlhbiBrZXJuZWw6IFN0YWNr
OiBjMTNkN2UwYyAwMDAwMDAwMCBjMDEzOTY5YSBjYTQ1NDhmNCAwMDAwMDAwMCAwMDAwMDAxMCBj
MTNkN2UxNCBjYTQ1NDg3MA0KU2VwICA4IDIyOjQ5OjQ2IGRlYmlhbiBrZXJuZWw6ICAgICAgICBj
MDEzOWFlNCBjMTNkN2UwYyBjYTQ1NDhmNCAwMDAwMDAwMCAwMDAwMDAxMCAwMDAwMDAwMCAwMDAw
MDAwMCAwMDAwMDAwMA0KU2VwICA4IDIyOjQ5OjQ2IGRlYmlhbiBrZXJuZWw6ICAgICAgICBjMTBk
NGI0OCBjMTBkNGIyMCBjMTBjMWU1OCAwMDAwMDIwMCBjMTE1YjFjMCBjMTBhMzcyOCBjMTBhMzcw
MCBjMTA5YjgyMA0KU2VwICA4IDIyOjQ5OjQ2IGRlYmlhbiBrZXJuZWw6IENhbGwgVHJhY2U6DQpT
ZXAgIDggMjI6NDk6NDYgZGViaWFuIGtlcm5lbDogIFtwYWdldmVjX2xvb2t1cCsyNi82NF0gcGFn
ZXZlY19sb29rdXArMHgxYS8weDQwDQpTZXAgIDggMjI6NDk6NDYgZGViaWFuIGtlcm5lbDogIFtp
bnZhbGlkYXRlX21hcHBpbmdfcGFnZXMrNjgvMjI0XSBpbnZhbGlkYXRlX21hcHBpbmdfcGFnZXMr
MHg0NC8weGUwDQpTZXAgIDggMjI6NDk6NDYgZGViaWFuIGtlcm5lbDogIFtpbnZhbGlkYXRlX2lu
b2RlX3BhZ2VzKzEzLzMyXSBpbnZhbGlkYXRlX2lub2RlX3BhZ2VzKzB4ZC8weDIwDQpTZXAgIDgg
MjI6NDk6NDYgZGViaWFuIGtlcm5lbDogIFtwcnVuZV9pY2FjaGUrNDYyLzUxMl0gcHJ1bmVfaWNh
Y2hlKzB4MWNlLzB4MjAwDQpTZXAgIDggMjI6NDk6NDYgZGViaWFuIGtlcm5lbDogIFtzaHJpbmtf
aWNhY2hlX21lbW9yeSsyNy8zMl0gc2hyaW5rX2ljYWNoZV9tZW1vcnkrMHgxYi8weDIwDQpTZXAg
IDggMjI6NDk6NDYgZGViaWFuIGtlcm5lbDogIFtzaHJpbmtfc2xhYisyODEvMzg0XSBzaHJpbmtf
c2xhYisweDExOS8weDE4MA0KU2VwICA4IDIyOjQ5OjQ2IGRlYmlhbiBrZXJuZWw6ICBbYmFsYW5j
ZV9wZ2RhdCs0NTEvNDgwXSBiYWxhbmNlX3BnZGF0KzB4MWMzLzB4MWUwDQpTZXAgIDggMjI6NDk6
NDYgZGViaWFuIGtlcm5lbDogIFtrc3dhcGQrMjU0LzI4OF0ga3N3YXBkKzB4ZmUvMHgxMjANClNl
cCAgOCAyMjo0OTo0NiBkZWJpYW4ga2VybmVsOiAgW2F1dG9yZW1vdmVfd2FrZV9mdW5jdGlvbisw
LzY0XSBhdXRvcmVtb3ZlX3dha2VfZnVuY3Rpb24rMHgwLzB4NDANClNlcCAgOCAyMjo0OTo0NiBk
ZWJpYW4ga2VybmVsOiAgW3JldF9mcm9tX2ZvcmsrNi8zMl0gcmV0X2Zyb21fZm9yaysweDYvMHgy
MA0KU2VwICA4IDIyOjQ5OjQ2IGRlYmlhbiBrZXJuZWw6ICBbYXV0b3JlbW92ZV93YWtlX2Z1bmN0
aW9uKzAvNjRdIGF1dG9yZW1vdmVfd2FrZV9mdW5jdGlvbisweDAvMHg0MA0KU2VwICA4IDIyOjQ5
OjQ2IGRlYmlhbiBrZXJuZWw6ICBba3N3YXBkKzAvMjg4XSBrc3dhcGQrMHgwLzB4MTIwDQpTZXAg
IDggMjI6NDk6NDYgZGViaWFuIGtlcm5lbDogIFtrZXJuZWxfdGhyZWFkX2hlbHBlcis1LzMyXSBr
ZXJuZWxfdGhyZWFkX2hlbHBlcisweDUvMHgyMA0KU2VwICA4IDIyOjQ5OjQ2IGRlYmlhbiBrZXJu
ZWw6DQpTZXAgIDggMjI6NDk6NDYgZGViaWFuIGtlcm5lbDogQ29kZTogZmYgNDAgMDQgODMgYzIg
MDQgNDkgNzUgZjUgYjggMDAgZTAgZmYgZmYgMjEgZTAgZmYgNDggMTQgOGINClNlcCAgOCAyMjo0
OTo0NiBkZWJpYW4ga2VybmVsOiAgPDY+bm90ZToga3N3YXBkMFs4XSBleGl0ZWQgd2l0aCBwcmVl
bXB0X2NvdW50IDENCg0K

--=-EC0mJbInqeqG6Oy7kj4r--

--=-I+nmiGV6bRTHLx1FDiqB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/XP5jRGk68b69cdURAp0mAJ4ruffvulSGC8K9LeVTNSxWsmwO9QCfbVt7
hqsgCr1UslLGf+Wux34gC18=
=k32i
-----END PGP SIGNATURE-----

--=-I+nmiGV6bRTHLx1FDiqB--

