Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTEDJTw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 05:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTEDJTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 05:19:52 -0400
Received: from dsl-62-3-122-162.zen.co.uk ([62.3.122.162]:7580 "EHLO
	marx.trudheim.com") by vger.kernel.org with ESMTP id S263573AbTEDJTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 05:19:51 -0400
Subject: comparision between signed and unsigned
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QEBvGToj6addAT9UXmKC"
Organization: Trudheim Technology Limited
Message-Id: <1052040732.25950.4.camel@marx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 04 May 2003 10:32:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QEBvGToj6addAT9UXmKC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi list,

Sitting here watching the compile output from 2.4.21-rc1-ac4 and
noticing there is a _lot_ of warnings about comparisions between signed
and unsigned values. The question I have is the following. If all the
signed values were modified to unsigned to fix the warnings, how likely
are things to break? Is there any reason to use signed values unless a
specific reason when negative values are required?

/Anders

--=-QEBvGToj6addAT9UXmKC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+tN4cLYywqksgYBoRAvvNAKCMdnOLllZjIjJu3ri15aSxKv/+ewCbBdUX
RDx23WDufVV1iuWY4mhS7sQ=
=X65q
-----END PGP SIGNATURE-----

--=-QEBvGToj6addAT9UXmKC--

