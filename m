Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTFOSyY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbTFOSyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:54:24 -0400
Received: from bgp01038448bgs.sothwt01.mi.comcast.net ([68.43.98.24]:18855
	"EHLO fire-eyes.dynup.net") by vger.kernel.org with ESMTP
	id S262636AbTFOSyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:54:14 -0400
Subject: 2.5.70 / 2.5.71 - Problem at Uncompressing Linux... OK
From: fire-eyes <sgtphou@fire-eyes.dynup.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yv3CeMXX+RFI71P2kGQ5"
Message-Id: <1055704091.10275.22.camel@fire-eyes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 15 Jun 2003 15:08:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yv3CeMXX+RFI71P2kGQ5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I am just beginning to experiment with 2.5, my appologies if I have
missed something. If there are other resources that could have answered
this question, I eagerly await suggestions.

With both 2.5.70 and 2.5.71, when the machine boots, it gets to
"Uncompressing Linux... OK", and then it stops there. Disk activity is
clearly still going on. After a short time, I can ping it, or other
network activity. If I try to ssh into it, I am asked my password. After
hitting enter, nothing happens. I can try this repeatedly to no avail.

Am I missing something fundamental here?

Thank you for your time.


Please CC me, as I am not (yet?) subscribed to the list

--=-yv3CeMXX+RFI71P2kGQ5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+7MQa+yxhoW3DHu4RAqojAJ4xRi/SPz0NXjZc2kbcSpPOmfAvdACcDQYn
6IDkNc9IUG5rCLuz7vF371s=
=HL1j
-----END PGP SIGNATURE-----

--=-yv3CeMXX+RFI71P2kGQ5--
