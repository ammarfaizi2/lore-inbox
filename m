Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUAZBsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 20:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUAZBsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 20:48:16 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:52194 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S265285AbUAZBsL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 20:48:11 -0500
Date: Mon, 26 Jan 2004 14:48:21 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: [OOPS] Linux-2.6.1 suspend/resume
In-reply-to: <20040126022540.315c4f8c@argon.inf.tu-dresden.de>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1075081701.10885.18.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-QiRmnC5LWYUs5XvE3GK8";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <20040126022540.315c4f8c@argon.inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QiRmnC5LWYUs5XvE3GK8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

Those don't look like oopses. Rather, they're call traces resulting from
scheduling while atomic. You should have a working system at the
conclusion of what you're recorded.

Regards,

Nigel

--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-QiRmnC5LWYUs5XvE3GK8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAFHHkVfpQGcyBBWkRAgFZAJ4pr8JVSw7G9KvyATgeUlML0khi9ACeKHch
5pe25OUWKjkyMi9ld+4iRZ0=
=J/M+
-----END PGP SIGNATURE-----

--=-QiRmnC5LWYUs5XvE3GK8--

