Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262979AbSJRIlc>; Fri, 18 Oct 2002 04:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263152AbSJRIlc>; Fri, 18 Oct 2002 04:41:32 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:34030 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262979AbSJRIlc>; Fri, 18 Oct 2002 04:41:32 -0400
Subject: Re: 2.5.41 still not testable by end users
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Thomas Molina <tmolina@cox.net>, Steve Parker <steve.parker@netops.co.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3DAF3C36.2065CFD1@digeo.com>
References: <3DAE2691.76F83D1B@digeo.com>
	<Pine.LNX.4.44.0210171717550.18123-100000@dad.molina> 
	<3DAF3C36.2065CFD1@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-B7ASwR8l8x8hQ+ys743z"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2002 10:43:45 +0200
Message-Id: <1034930625.2300.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-B7ASwR8l8x8hQ+ys743z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> request_irq() was changed to use GFP_ATOMIC, so it's "fixed".

Are you sure? Afaik request_irq also changes some files in proc.... are
you sure that is all done atomically ?


--=-B7ASwR8l8x8hQ+ys743z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9r8nAxULwo51rQBIRAhuoAJ44hCcasVSE1ZUKL0j5OUWcTBkfEQCgpIEB
KWEUGdkGrkLkcOyqnorjAR0=
=qmJB
-----END PGP SIGNATURE-----

--=-B7ASwR8l8x8hQ+ys743z--

