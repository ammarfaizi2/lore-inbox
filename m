Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264438AbTDPPGf (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 11:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbTDPPGf 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:06:35 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:30450 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264438AbTDPPGc 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:06:32 -0400
Subject: Re: How to identify contents of /lib/modules/*
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: steve.cameron@hp.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030416020059.GA27314@zuul.cca.cpqcorp.net>
References: <20030416020059.GA27314@zuul.cca.cpqcorp.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CfcURzg0hp1N4LgR8mdJ"
Organization: 
Message-Id: <1050506286.1424.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 16 Apr 2003 17:18:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CfcURzg0hp1N4LgR8mdJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-04-16 at 04:00, Stephen Cameron wrote:
> Hi, here's a problem I'm having, perhaps someone has some smart idea...
>=20
> A certain major linux distribution distributes a number of binary=20
> kernels, errata kernels, which all report the exact same thing=20
> via "uname -r".  These kernels may differ by only a little
> (only the .config file is different in some small way) or by=20
> a lot (binary drivers for one don't work (panic) on another).

this is what modversions are for ;)

--=-CfcURzg0hp1N4LgR8mdJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+nXQubpJDcQVaBT0RAqA7AKCkhOA3z4oALjcGdQVjGfsxg8a2kwCfRO6K
GhHmV7pTv7PAePyJgEXA9L8=
=aAhi
-----END PGP SIGNATURE-----

--=-CfcURzg0hp1N4LgR8mdJ--
