Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265510AbUFTVmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUFTVmx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbUFTVmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:42:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46732 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265510AbUFTVmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:42:51 -0400
Subject: Re: [PATCH 0/2] kbuild updates
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
In-Reply-To: <1087767034.14794.42.camel@nosferatu.lan>
References: <20040620211905.GA10189@mars.ravnborg.org>
	 <1087767034.14794.42.camel@nosferatu.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-taEOshTCvUW2EiXEb3aG"
Organization: Red Hat UK
Message-Id: <1087767752.2805.18.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 20 Jun 2004 23:42:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-taEOshTCvUW2EiXEb3aG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Given, but to 'use' the kbuild infrastructure, you must still call it
> via:
>=20
>   make -C _path_to_sources M=3D`pwd`

I see no problem with requiring this though; requiring a correct
makefile is perfectly fine with me, and this is the only and documented
way for 2.6 already.
(And it's also the only way to build modules against Fedora Core 2
kernels by the way)

That's not my reservation to this approach.



--=-taEOshTCvUW2EiXEb3aG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1gTIxULwo51rQBIRAlRfAJ4mFId+VAvSKKA/4tOjGUPrrIihjgCcCL8j
T7dcAZ1jMUj5o/JRCiSoN0M=
=Y0yT
-----END PGP SIGNATURE-----

--=-taEOshTCvUW2EiXEb3aG--

