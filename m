Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbTLPH7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 02:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbTLPH7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 02:59:04 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:10634 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264365AbTLPH7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 02:59:00 -0500
Subject: Re: 'bad: scheduling while atomic!', preempt kernel, 2.6.1-test11,
	reading an apparently duff DVD-R
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Toad <toad@amphibian.dyndns.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20031215174908.GA29901@amphibian.dyndns.org>
References: <20031215135802.GA4332@amphibian.dyndns.org>
	 <Pine.LNX.4.58.0312150715410.1488@home.osdl.org> <3FDDD923.30509@pobox.com>
	 <20031215174908.GA29901@amphibian.dyndns.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Mzmq00v2cNx4vVbiqhcU"
Message-Id: <1071561657.4995.21.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Dec 2003 10:00:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Mzmq00v2cNx4vVbiqhcU
Content-Type: multipart/mixed; boundary="=-NG+Xdnc8423WYxI6RpkF"


--=-NG+Xdnc8423WYxI6RpkF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-12-15 at 19:49, Toad wrote:

> I've been completely unable to get cdrtools to compile... The version in
> debian is 2.0a19, which works with IDE-SCSI, and doesn't work without
> it. The RPM from the oss-dvd extension site doesn't work either without
> IDE-SCSI. Nor does dvd+rwtools. Anyone attempting to write DVDs will
> have real problems if IDE-SCSI is removed, judging by this experience.

You might try this patch to get the latest 2.01 beta compiled against
2.6 headers.


Cheers,

--=20
Martin Schlemmer

--=-NG+Xdnc8423WYxI6RpkF
Content-Disposition: attachment; filename=cdrtools-2.01-kernel25-support.patch
Content-Type: text/x-patch; name=cdrtools-2.01-kernel25-support.patch;
	charset=iso-8859-1
Content-Transfer-Encoding: base64

LS0tIGNkcnRvb2xzLTIuMDEvbGlic2NnL3Njc2ktbGludXgtc2cuYy5vcmlnCTIwMDMtMDItMDUg
MjE6MDE6MzEuMDAwMDAwMDAwICswMjAwDQorKysgY2RydG9vbHMtMi4wMS9saWJzY2cvc2NzaS1s
aW51eC1zZy5jCTIwMDMtMDItMDUgMjE6MTY6MzMuMDAwMDAwMDAwICswMjAwDQpAQCAtNjYsNiAr
NjYsMTEgQEANCiAjaWYgTElOVVhfVkVSU0lPTl9DT0RFID49IDB4MDEwMzFhIC8qIDxsaW51eC9z
Y3NpLmg+IGludHJvZHVjZWQgaW4gMS4zLjI2ICovDQogI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA+
PSAweDAyMDAwMCAvKiA8c2NzaS9zY3NpLmg+IGludHJvZHVjZWQgc29tZXdoZXJlLiAqLw0KIC8q
IE5lZWQgdG8gZmluZSB0dW5lIHRoZSBpZmRlZiBzbyB3ZSBnZXQgdGhlIHRyYW5zaXRpb24gcG9p
bnQgcmlnaHQuICovDQorI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA+PSAweDAyMDUwMCAvKiAyLjUu
eCBicmVha3MgdGhpbmdzIGFnYWluICovDQorI2RlZmluZSBfX0tFUk5FTF9fDQorI2luY2x1ZGUg
PGFzbS90eXBlcy5oPg0KKyN1bmRlZiBfX0tFUk5FTF9fDQorI2VuZGlmDQogI2luY2x1ZGUgPHNj
c2kvc2NzaS5oPg0KICNlbHNlDQogI2luY2x1ZGUgPGxpbnV4L3Njc2kuaD4NCg==

--=-NG+Xdnc8423WYxI6RpkF--

--=-Mzmq00v2cNx4vVbiqhcU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/3ru4qburzKaJYLYRAs4NAJwMRfMYiLy1q6I9MSugc3Cgsz7BXgCfX3RO
XQKX3DCU3NU6D0lSXIGIKVA=
=Fz6Z
-----END PGP SIGNATURE-----

--=-Mzmq00v2cNx4vVbiqhcU--

