Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270722AbTGNVvX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270726AbTGNVvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:51:23 -0400
Received: from dsl-217-155-72-205.zen.co.uk ([217.155.72.205]:3858 "EHLO
	nicole.computer-surgery.co.uk") by vger.kernel.org with ESMTP
	id S270722AbTGNVvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:51:21 -0400
Date: Mon, 14 Jul 2003 23:06:01 +0100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dan Aloni <da-x@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: auto-bk-get
Message-ID: <20030714220601.GA31384@computer-surgery.co.uk>
References: <20030710184429.GA28366@callisto.yi.org> <3F0DD5F6.5060302@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <3F0DD5F6.5060302@pobox.com>
User-Agent: Mutt/1.3.28i
X-GPG-Fingerprint: ADAD DF3A AE05 CA28 3BDB  D352 7E81 8852 817A FB7B
X-GPG-Key: 1024D/817AFB7B (wwwkeys.uk.pgp.net)
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2003 at 05:09:10PM -0400, Jeff Garzik wrote:
> Dan Aloni wrote:
> >For kernel developers which are BitKeeper users,=20
> >
> >auto-bk-get is an on-demand 'bk get' libc wrapper tool.
> [snip]
>
> No offense, but, it would probably be easier to fix the few remaining=20
> places where the makefile system does not automatically check out the fil=
es.
>=20
> It works great for everything except the Kconfig stuff, IIRC.

I played about with this a long time ago at the beginning of
2.5, so was attempt to do this with the old build system which
didn't had a few awkward bits, and then I was distracted by userspace=20
stuff.

What I did I put here ( http://www.sandman.uklinux.net/odds/index.html )
it might be of use - though as I recall correctly most of the=20
code was taken from  patch(1). So it's nothing special.

TTFN
--=20
Roger. 	                        Home| http://www.sandman.uklinux.net/
Master of Peng Shui.      (Ancient oriental art of Penguin Arranging)
Work|Independent Systems Consultant | http://www.firstdatabase.co.uk/
So what are the eigenvalues and eigenvectors of 'The Matrix'? --anon

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/EylJfoGIUoF6+3sRAlQXAJ407+jI2l27DklR8l3tGa+ofpWgwACeJ5nk
kidPnZ0miJkokYWS1StzNKc=
=Tkei
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
