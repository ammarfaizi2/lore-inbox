Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTLNNZs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 08:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbTLNNZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 08:25:48 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:132 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261411AbTLNNZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 08:25:46 -0500
Subject: Re: PROBLEM: Kernel pging problem
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: stepka@tris.sk
Cc: linux-kernel@vger.kernel.org, marian.stepka@onsemi.com
In-Reply-To: <200312141328.22811.mstepka@orangemail.sk>
References: <200312141328.22811.mstepka@orangemail.sk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5LBY0V34hEs1sHnjdmyF"
Organization: Red Hat, Inc.
Message-Id: <1071408325.5233.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 14 Dec 2003 14:25:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5LBY0V34hEs1sHnjdmyF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I reinstall my system from RedHat 9 to Fedora Core 1 with latest availabl=
e=20
> kernel update from RedHat. I'm using VPN client software which taint the=20
> kernel but I hope this information could be usefull for kernel developmen=
t=20
> and that is reason why I'm posting it. I will include copy of this messag=
e to=20
> proprietary VPN software developers.

the oops points to a problem in the networking side of things, which
thus is most likely caused by your binary only VPN module...

--=-5LBY0V34hEs1sHnjdmyF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/3GTFxULwo51rQBIRAuzyAJkBiC6Mvn57X2riCw0M6heWBpII6ACghrSz
pGm8oZ7y8W91l4K3s7qb1fo=
=wKMp
-----END PGP SIGNATURE-----

--=-5LBY0V34hEs1sHnjdmyF--
