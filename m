Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbTJJRrn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 13:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbTJJRrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 13:47:43 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:38131 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263068AbTJJRrl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 13:47:41 -0400
Subject: Re: original redhat config
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Daniel Harker <danielharker@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Sea2-F11XoZl0fqWcH800005aac@hotmail.com>
References: <Sea2-F11XoZl0fqWcH800005aac@hotmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-t4aimzYlJgJHExlpTi+a"
Organization: Red Hat, Inc.
Message-Id: <1065808049.5433.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Fri, 10 Oct 2003 19:47:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t4aimzYlJgJHExlpTi+a
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-10-10 at 19:36, Daniel Harker wrote:
> ut I just don't have the time.
>=20
> My question:  Is there a way (without reinstalling) to get the make=20
> menuconfig to use exactly what redhat configured for my system?  So that =
my=20
> mouse, soundcard, and network card work? I pretty much want it to be the=20
> exact same kernel configuration but with the bootsplash patch.

the config file we use is stored in the /boot directory
(and if you install the kernel-source RPM it's also in
/usr/src/linux-2.4.20-20.9/configs)


--=-t4aimzYlJgJHExlpTi+a
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/hvCwxULwo51rQBIRAlELAJoDY/TdGOhQdygGmCtXHOeJAp5LZgCfWBv0
qbTWbQhbVXImXqVv8FhMviA=
=7zRx
-----END PGP SIGNATURE-----

--=-t4aimzYlJgJHExlpTi+a--
