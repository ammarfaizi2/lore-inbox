Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266382AbUAHXqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 18:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266385AbUAHXqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 18:46:22 -0500
Received: from viriato1.servicios.retecal.es ([212.89.0.44]:57042 "EHLO
	viriato1.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S266382AbUAHXpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 18:45:35 -0500
Subject: [2.6.1-rc2-mm1][BUG] Badness in unblank_screen at
	drivers/char/vt.c:2793
From: Ramon Rey Vicente <ramon.rey@augcyl.org>
Reply-To: ramon.rey@hispalinux.es
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Qckf10apRr9Utl7+cdcn"
Organization: AUGCyL - http://www.augcyl.org
Message-Id: <1073605532.1070.6.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 09 Jan 2004 00:45:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Qckf10apRr9Utl7+cdcn
Content-Type: multipart/mixed; boundary="=-bJfm+zISW7o8VeVa9vO4"


--=-bJfm+zISW7o8VeVa9vO4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--=20
Ram=C3=B3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-bJfm+zISW7o8VeVa9vO4
Content-Disposition: inline; filename=bug2
Content-Transfer-Encoding: base64
Content-Type: text/plain; name=bug2; charset=UTF-8

SmFuICA4IDIzOjEyOjI5IGRlYmlhbiBrZXJuZWw6IEJhZG5lc3MgaW4gdW5ibGFua19zY3JlZW4g
YXQgZHJpdmVycy9jaGFyL3Z0LmM6Mjc5Mw0KSmFuICA4IDIzOjEyOjI5IGRlYmlhbiBrZXJuZWw6
IENhbGwgVHJhY2U6DQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDogIFt1bmJsYW5rX3Nj
cmVlbisyNTAvMjg4XSB1bmJsYW5rX3NjcmVlbisweGZhLzB4MTIwDQpKYW4gIDggMjM6MTI6Mjkg
ZGViaWFuIGtlcm5lbDogIFtidXN0X3NwaW5sb2NrcyszNy85Nl0gYnVzdF9zcGlubG9ja3MrMHgy
NS8weDYwDQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDogIFtkaWUrMTIwLzIyNF0gZGll
KzB4NzgvMHhlMA0KSmFuICA4IDIzOjEyOjI5IGRlYmlhbiBrZXJuZWw6ICBbZG9faW52YWxpZF9v
cCsxNDUvMTYwXSBkb19pbnZhbGlkX29wKzB4OTEvMHhhMA0KSmFuICA4IDIzOjEyOjI5IGRlYmlh
biBrZXJuZWw6ICBbdHJ5X3RvX3VubWFwX29uZSs0NTYvNDgwXSB0cnlfdG9fdW5tYXBfb25lKzB4
MWM4LzB4MWUwDQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDogIFtzbGFiX2Rlc3Ryb3kr
MTcwLzI1Nl0gc2xhYl9kZXN0cm95KzB4YWEvMHgxMDANCkphbiAgOCAyMzoxMjoyOSBkZWJpYW4g
a2VybmVsOiAgW2ZyZWVfcGFnZXNfYnVsayszNTAvNjQwXSBmcmVlX3BhZ2VzX2J1bGsrMHgxNWUv
MHgyODANCkphbiAgOCAyMzoxMjoyOSBkZWJpYW4ga2VybmVsOiAgW2ZyZWVfaG90X2NvbGRfcGFn
ZSsyMjQvMjU2XSBmcmVlX2hvdF9jb2xkX3BhZ2UrMHhlMC8weDEwMA0KSmFuICA4IDIzOjEyOjI5
IGRlYmlhbiBrZXJuZWw6ICBbZXJyb3JfY29kZSs0Ny82NF0gZXJyb3JfY29kZSsweDJmLzB4NDAN
CkphbiAgOCAyMzoxMjoyOSBkZWJpYW4ga2VybmVsOiAgW3RyeV90b191bm1hcF9vbmUrNDU2LzQ4
MF0gdHJ5X3RvX3VubWFwX29uZSsweDFjOC8weDFlMA0KSmFuICA4IDIzOjEyOjI5IGRlYmlhbiBr
ZXJuZWw6ICBbdHJ5X3RvX3VubWFwKzMyMi8zODRdIHRyeV90b191bm1hcCsweDE0Mi8weDE4MA0K
SmFuICA4IDIzOjEyOjI5IGRlYmlhbiBrZXJuZWw6ICBbc2hyaW5rX2xpc3QrNTc5LzE0MDhdIHNo
cmlua19saXN0KzB4MjQzLzB4NTgwDQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDogIFtk
b190aW1lcisxOTcvMjI0XSBkb190aW1lcisweGM1LzB4ZTANCkphbiAgOCAyMzoxMjoyOSBkZWJp
YW4ga2VybmVsOiAgW2RvX3NvZnRpcnErMTQwLzE2MF0gZG9fc29mdGlycSsweDhjLzB4YTANCkph
biAgOCAyMzoxMjoyOSBkZWJpYW4ga2VybmVsOiAgW2NvbW1vbl9pbnRlcnJ1cHQrMjQvMzJdIGNv
bW1vbl9pbnRlcnJ1cHQrMHgxOC8weDIwDQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDog
IFtfX3BhZ2V2ZWNfcmVsZWFzZSsyNC82NF0gX19wYWdldmVjX3JlbGVhc2UrMHgxOC8weDQwDQpK
YW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDogIFtzaHJpbmtfY2FjaGUrNDA5Lzg2NF0gc2hy
aW5rX2NhY2hlKzB4MTk5LzB4MzYwDQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDogIFtz
aHJpbmtfem9uZSsxMDcvMTI4XSBzaHJpbmtfem9uZSsweDZiLzB4ODANCkphbiAgOCAyMzoxMjoy
OSBkZWJpYW4ga2VybmVsOiAgW2JhbGFuY2VfcGdkYXQrMzU5LzQ4MF0gYmFsYW5jZV9wZ2RhdCsw
eDE2Ny8weDFlMA0KSmFuICA4IDIzOjEyOjI5IGRlYmlhbiBrZXJuZWw6ICBba3N3YXBkKzI1NC8y
ODhdIGtzd2FwZCsweGZlLzB4MTIwDQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDogIFth
dXRvcmVtb3ZlX3dha2VfZnVuY3Rpb24rMC82NF0gYXV0b3JlbW92ZV93YWtlX2Z1bmN0aW9uKzB4
MC8weDQwDQpKYW4gIDggMjM6MTI6MjkgZGViaWFuIGtlcm5lbDogIFtyZXRfZnJvbV9mb3JrKzYv
MzJdIHJldF9mcm9tX2ZvcmsrMHg2LzB4MjANCkphbiAgOCAyMzoxMjoyOSBkZWJpYW4ga2VybmVs
OiAgW2F1dG9yZW1vdmVfd2FrZV9mdW5jdGlvbiswLzY0XSBhdXRvcmVtb3ZlX3dha2VfZnVuY3Rp
b24rMHgwLzB4NDANCkphbiAgOCAyMzoxMjoyOSBkZWJpYW4ga2VybmVsOiAgW2tzd2FwZCswLzI4
OF0ga3N3YXBkKzB4MC8weDEyMA0KSmFuICA4IDIzOjEyOjI5IGRlYmlhbiBrZXJuZWw6ICBba2Vy
bmVsX3RocmVhZF9oZWxwZXIrNS8zNl0ga2VybmVsX3RocmVhZF9oZWxwZXIrMHg1LzB4MjQNCkph
biAgOCAyMzoxMjoyOSBkZWJpYW4ga2VybmVsOiANCkphbiAgOCAyMzoxMjoyOSBkZWJpYW4ga2Vy
bmVsOiAgPDY+bm90ZToga3N3YXBkMFs4XSBleGl0ZWQgd2l0aCBwcmVlbXB0X2NvdW50IDENCg0K


--=-bJfm+zISW7o8VeVa9vO4--

--=-Qckf10apRr9Utl7+cdcn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA//eubRGk68b69cdURAh8+AJ9jer8Iy3aW2JnqRSDsrTotJ/CeyQCfb07Q
8lhKFBIUGMgEA0xBkgGpuLY=
=qBAX
-----END PGP SIGNATURE-----

--=-Qckf10apRr9Utl7+cdcn--

