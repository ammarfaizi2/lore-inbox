Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTJOLpU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 07:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTJOLpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 07:45:20 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:36817 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262794AbTJOLpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 07:45:15 -0400
Date: Wed, 15 Oct 2003 13:45:14 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Message-ID: <20031015114514.GC20846@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031014143047.GA6332@ncsu.edu> <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q3hTxzd42jkGoc1w"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--q3hTxzd42jkGoc1w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-14 18:27:05 +0200, Maciej Zenczykowski <maze@cela.pl>
wrote in message <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>:

> errnum->string. I'd expect that between 10-15% of the uncompressed kernel=
=20
> is currently pure text.

Right. For a real lowmem system (4MB RAM) I defined printk to a no-op
and gained 90K at the compressed image IIRC. This was 2.2.x, though.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--q3hTxzd42jkGoc1w
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jTNKHb1edYOZ4bsRAkJ1AJsGJqO1ROA8VYMMUbvhf8GGfBkEhgCeKgLl
hkDiA8IHqWZm61CxU3qTnHo=
=al3p
-----END PGP SIGNATURE-----

--q3hTxzd42jkGoc1w--
