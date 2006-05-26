Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWEZUwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWEZUwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 16:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWEZUwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 16:52:41 -0400
Received: from junki.org ([194.154.83.175]:5612 "EHLO junki.org")
	by vger.kernel.org with ESMTP id S1751516AbWEZUwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 16:52:41 -0400
Subject: Intercept write to disk
From: Mishael A Sibiryakov <death@junki.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-l2xmuCNsp3qP/ssn712p"
Date: Sat, 27 May 2006 00:52:10 +0400
Message-Id: <1148676730.2094.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-l2xmuCNsp3qP/ssn712p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi.

Probably i have a stupid question but i can't find adequate solution for
it. I want to intercept write to real disk partition or entire disk
(except of swap partition of course). As i understood vfs and Co i think
that i need to work on level between fs driver and disk driver. But it's
unclean for me. Please tell me is it possible and if possible then say
how or put me to some documentation.

I need a offset from start or CHS value with buffer for save it.

--=-l2xmuCNsp3qP/ssn712p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEd2p5ltv4nqCvt/oRAtXeAJkBMjcLxjiIEuthtOL7766dWX7xVACeNpop
KNP5bwtHdOwMTSh34ZiEh7E=
=LXtd
-----END PGP SIGNATURE-----

--=-l2xmuCNsp3qP/ssn712p--

