Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbTLVLKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 06:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbTLVLKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 06:10:07 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:46722 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264441AbTLVLKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 06:10:01 -0500
Subject: Re: [test] exec-shield  vs. paxtest 0.9.5 horrible results
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Gabor MICSKO <gmicsko@szintezis.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <1072090466.1471.4.camel@gmicsko03>
References: <1072090466.1471.4.camel@gmicsko03>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RreqdAs7o6DMOaMLzb4C"
Organization: Red Hat, Inc.
Message-Id: <1072091389.5223.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 22 Dec 2003 12:09:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RreqdAs7o6DMOaMLzb4C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-12-22 at 11:54, Gabor MICSKO wrote:
> gmicsko03:/home/trey/devel/exploit/paxtest-0.9.5# uname -a
> Linux gmicsko03 2.6.0 #1 Thu Dec 18 12:32:44 CET 2003 i686 GNU/Linux

applications have the option to disable exec-shield themselves for them.
pax-test at one point did this deliberately (in order to simulate glibc
2.2 behavior according to the author); are you using a version of
paxtest that does this ?


--=-RreqdAs7o6DMOaMLzb4C
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/5tD9xULwo51rQBIRAuj8AJ9nC20YdpnChWdDyeU1+VSzVMX/qACcCTMR
gTm1uS6m14fE0kV1qrc7u1k=
=y4U6
-----END PGP SIGNATURE-----

--=-RreqdAs7o6DMOaMLzb4C--
