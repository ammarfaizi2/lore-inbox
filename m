Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270379AbTG1R4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 13:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270380AbTG1R43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 13:56:29 -0400
Received: from pc-62-31-11-105-bf.blueyonder.co.uk ([62.31.11.105]:13497 "HELO
	prozac") by vger.kernel.org with SMTP id S270379AbTG1R41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 13:56:27 -0400
Subject: Re: [PATCH] Remove module reference counting.
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, arjanv@redhat.com,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030727193919.832302C450@lists.samba.org>
References: <20030727193919.832302C450@lists.samba.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SQXoV26y1/4tXc6LUrl2"
Message-Id: <1059415901.19143.3.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 28 Jul 2003 19:11:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SQXoV26y1/4tXc6LUrl2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-07-27 at 20:34, Rusty Russell wrote:
> I guess it's back to fixing up reference counting in the rest of the
> kernel.  It's not hard, it's just not done. 8(

Do you know which subsystems and modules are definately broken wrt.
refcounting? And also which ones are un-fixable / wont-fix and why.

Maybe someone will step up to the plate if you name and shame...

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D


--=-SQXoV26y1/4tXc6LUrl2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/JWddkbV2aYZGvn0RAkquAJ9cYFMXHO/y/Bs4YZus5eEx+XTJqQCfQHkJ
bo1DguH3ER4+IwsQJyQWTIM=
=tZn6
-----END PGP SIGNATURE-----

--=-SQXoV26y1/4tXc6LUrl2--

