Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbTBEUAT>; Wed, 5 Feb 2003 15:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbTBEUAR>; Wed, 5 Feb 2003 15:00:17 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:42418 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264790AbTBET7u>; Wed, 5 Feb 2003 14:59:50 -0500
Subject: Cerberus
From: Paul Larson <plars@linuxtestproject.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ioTJsajNzJyDim0olZQU"
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Feb 2003 14:06:24 -0600
Message-Id: <1044475584.30331.135.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ioTJsajNzJyDim0olZQU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I saw a comment late last week that someone was seeing cerberus crash
instantaneously with 2.5 on UP machines, so I decided to try to
reproduce this problem.  I got the latest version of ceerbuerus and put
it on a single processor pIII-866 256MB ram, linux-2.5.59 kernel.=20
Newburn has been running for just under 5 days now without so much as a
hiccup.

1. Has anyone had first hand experience with this instability?

2. If so, were you just running the default newburn, or something else?=20
Please let me know if you did something different that caused it to
crash.

Thanks,
Paul Larson


--=-ioTJsajNzJyDim0olZQU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj5Bbr8ACgkQbkpggQiFDqfWQACfShTJWXcsJnQqP5R5kcq8kwQF
kwoAn1z8ssSoWfcp8yfkkTfpts29Pm59
=HM0S
-----END PGP SIGNATURE-----

--=-ioTJsajNzJyDim0olZQU--

