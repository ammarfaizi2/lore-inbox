Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264174AbUEHIDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbUEHIDo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 04:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264175AbUEHIDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 04:03:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18668 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264174AbUEHIDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 04:03:41 -0400
Subject: Re: module-licences / tainting the kernel
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Axel Weiss <aweiss@informatik.hu-berlin.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200405080957.57286.aweiss@informatik.hu-berlin.de>
References: <200405080957.57286.aweiss@informatik.hu-berlin.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-n9XCYozkJRb6ozVXMZs7"
Organization: Red Hat UK
Message-Id: <1084003417.3843.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 08 May 2004 10:03:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-n9XCYozkJRb6ozVXMZs7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Would it be possible to let e.g. LPGL-licenced kernel-modules be loaded=20
> legally?

there are 2 angles here:
1) there already is "GPL with additional rights" which LGPL is just one
form of
and
2) if you mix LGPL with GPL (eg kernel), the LGPL license itself says it
autoconverts to GPL, so you can't even have a LGPL module *loaded*.
(Not saying that your source can't be LGPL but when you link it into the
kernel at runtime it turns GPL)

--=-n9XCYozkJRb6ozVXMZs7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAnJRYxULwo51rQBIRAt7cAJ0YZrhfFXJR4mfyoyXklnLiTZVwmwCdHxJe
ivZ7nEvzNCDIHdpJE5TBZbA=
=92dz
-----END PGP SIGNATURE-----

--=-n9XCYozkJRb6ozVXMZs7--

