Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265907AbUAQFAj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 00:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUAQFAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 00:00:38 -0500
Received: from adsl-67-124-157-189.dsl.pltn13.pacbell.net ([67.124.157.189]:28579
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265907AbUAQFAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 00:00:37 -0500
Date: Fri, 16 Jan 2004 21:00:32 -0800
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Mouse issues in 2.6
Message-ID: <20040117050032.GC24433@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I previously brought this up before but it was smothered in the
2.6.1-mm2 thread (or something like that. Even I forget.)

I'm using a USB mouse connected to my computer and X is only reading
=66rom /dev/input/mice. However, I will receive spurious double-click
events out of completely nowhere. My mouse does not appear to move way
too fast (I have experienced it on my laptop) or anything obvious like
that. I am not using anything other than hid, input, and ohci-hcd for
the mouse.

Any ideas?

--=20
Joshua Kwan

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBQAjBbqOILr94RG8mAQJrRg//XYzU/WJtKHSJUzeq7sTWx8OVqivFAb6b
HiKvPN6yorWTxrTKRnBbKt01Xm0o5xTFHmusu3KQiNAsDkS0frYYwhrg0pXHYmPx
Au+6f3jMOh/2Svv6nTxJWFK9380lMLQNsZxUNsPCRW4Yv1YKdedzmZPob87yX+GL
jx9g3x0z8P1aH7uLb0L8bjVxWdrnc2Z/O0/CSmtzAGAxe0mykKL8Dw48HrYnvsRe
6+DX3Fg6nGXu7KonUz8ESs12w1rxFePTPlfB8ouSSXAyx5DPDtn1SvM3gMf+uxXq
Ddq7TQ2bsHRH1fpqByggLGEFmftOa7LEXDSW7yK6nnWXz44ke5ZNn3UVSEwW6OJm
OQ0XPzUxd9qOc10oaAS2GKe/aqKe/rW/XcaP+8aMXLKT3oS5SLfMk+dezOK+uR8u
UF6WcdT3E0N5rX0fmcq3DsTQVXssreomgrZXlfpxADHwAvRv21jPWYAnr11+no4Y
q65JIYsTNDF+tg/rItwoHPuCI2PVDHrgjVaRPzACT1XNbZEsAP7nPi8u6yxQ0HPl
EsOxk9N/Ddhpa1LJJP3e0Rrd1JuwtW6wAFA/5RdEntY3vD/24kVhZX8CEtpJxCBp
5dBdRGZGMnZshQGKuklMwinQNSu5dV5FKix03xxccMdZi3506l4N9+uXva7PZtYr
7sp0pB/wNt8=
=Ltrx
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
