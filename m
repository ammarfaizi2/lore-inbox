Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266156AbUAVBkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 20:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUAVBkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 20:40:12 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:53955 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S266161AbUAVBkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 20:40:06 -0500
Date: Thu, 22 Jan 2004 14:42:55 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: PATCH: Shutdown IDE before powering off.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074735774.31963.82.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-CscQKynJruZLZSwDH8Wf";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CscQKynJruZLZSwDH8Wf
Content-Type: multipart/mixed; boundary="=-Eu6MQNtNRuTOELqB7ttf"


--=-Eu6MQNtNRuTOELqB7ttf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

Here's a patch Bernard Blackham posted to the Software Suspend mailing
list, which has fixed data-not-being-properly flushed issues for some
people. (Forwarded with Bernard's permission).

Regards,

Nigel
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-Eu6MQNtNRuTOELqB7ttf
Content-Disposition: attachment; filename=ide-shutdown.diff
Content-Type: text/x-patch; name=ide-shutdown.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

ZGlmZiAtcnVOIGxpbnV4LTIuNi4wL2RyaXZlcnMvaWRlL2lkZS5jLm9yaWcgbGludXgtMi42LjAv
ZHJpdmVycy9pZGUvaWRlLmMNCi0tLSBsaW51eC0yLjYuMC9kcml2ZXJzL2lkZS9pZGUuYy5vcmln
CTIwMDMtMTItMTggMTA6NTg6MzguMDAwMDAwMDAwICswODAwDQorKysgbGludXgtMi42LjAvZHJp
dmVycy9pZGUvaWRlLmMJMjAwMy0xMi0yOCAxMDoxODo0Ny4wMDAwMDAwMDAgKzA4MDANCkBAIC0y
NDkzLDYgKzI0OTMsMTEgQEANCiAJcmV0dXJuIDA7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIGlkZV9k
cml2ZV9zaHV0ZG93biAoc3RydWN0IGRldmljZSAqIGRldikNCit7DQorCWdlbmVyaWNfaWRlX3N1
c3BlbmQoZGV2LCA1KTsNCit9DQorDQogaW50IGlkZV9yZWdpc3Rlcl9kcml2ZXIoaWRlX2RyaXZl
cl90ICpkcml2ZXIpDQogew0KIAlzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7DQpAQCAtMjUxOSw2ICsy
NTI0LDcgQEANCiAJZHJpdmVyLT5nZW5fZHJpdmVyLm5hbWUgPSAoY2hhciAqKSBkcml2ZXItPm5h
bWU7DQogCWRyaXZlci0+Z2VuX2RyaXZlci5idXMgPSAmaWRlX2J1c190eXBlOw0KIAlkcml2ZXIt
Pmdlbl9kcml2ZXIucmVtb3ZlID0gaWRlX2RyaXZlX3JlbW92ZTsNCisJZHJpdmVyLT5nZW5fZHJp
dmVyLnNodXRkb3duID0gaWRlX2RyaXZlX3NodXRkb3duOw0KIAlyZXR1cm4gZHJpdmVyX3JlZ2lz
dGVyKCZkcml2ZXItPmdlbl9kcml2ZXIpOw0KIH0NCiANCg==

--=-Eu6MQNtNRuTOELqB7ttf--

--=-CscQKynJruZLZSwDH8Wf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBADyqeVfpQGcyBBWkRAnE4AJ9U3f6mfFpUbi8rveqHBLOpGQgN7ACdFp+C
F7R1YpkgJQZuNe45iVfkic4=
=yx4V
-----END PGP SIGNATURE-----

--=-CscQKynJruZLZSwDH8Wf--

