Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbTLZIPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 03:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTLZIPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 03:15:39 -0500
Received: from adsl-67-121-154-253.dsl.pltn13.pacbell.net ([67.121.154.253]:59332
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S264890AbTLZIPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 03:15:37 -0500
Date: Fri, 26 Dec 2003 00:15:35 -0800
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: vojtech@suse.cz
Subject: Can't eject a previously mounted CD?
Message-ID: <20031226081535.GB12871@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	vojtech@suse.cz
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vojtech,

I suspect this problem has something to do with my nForce2 motherboard.
When I mount a CD, unmount it, and try to eject it from my drive, the
drive flashes the red 'busy / locked' light and refuses to let me eject
it. I'm using the AMD / nVidia IDE kernel support and the obvious
conclusion is that it's failing to release the device or something. Is
this true?

I suspect the fix would be a one liner.

--=20
Joshua Kwan

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP+vuJaOILr94RG8mAQK5JQ/+PuD/FvdWQp/IN09QzyxpQncbTOB722EP
vv0Y3f5vQpWuNbrFXGvISX6rLNa/NUJhAiouMEZ++vNG6iP7m39MpOAjU04sqCVo
TXqYFRUe40KScyVRBxWiQ1dotk2w2S449nFgaGQt9Rec6ODBK+zxwZ5+w3RH5Q6N
maXwI0m4w5iGWiatfXjqnTBsiLii6V0+S5DbzFaHQuE4lckKfzrRg2Xx80CgzG5V
pUk3/nRLPYf5IXMNFj7f3CUVN1dhY+DibcTYE2cCNrI+w2HxO7EuLkvRY1nI+I6E
R26ql2LMLEKCumHpLrUAept0XfLgBInUsh28oTHDvGBRltfbLAbhCfm8fvkmY+kx
H27CaZcaBySbquz+aTwMGF2MHEqFWAE83Om/deeuaCOr5cavfJyNvRK6AhZzUwBt
KBO0XXXq8sw4zOcmqM9GiR41QZIQPs1qpgvfT3refVMt3rrlYjNum7j4HWeNFJl0
wJix3213G+wmIMJ6MKQFanmPLbDWD/ThUBrtu9itrlYGRLs7BO5WyYupapDCpOtG
fk9DYFQWFekmpa5k1OSQgVyfJGKgqbsav+hgWg6TtrOyoPh1jtHMfhbRNuMJcfWc
mNry8aIsU9UWQG5mMV9t1BHVrWlwjmdV3vVHE3inlC/FEOfhLVPiY7No3NNvl48z
aGrgiw2ssXY=
=TS0s
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
