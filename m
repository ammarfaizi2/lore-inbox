Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264511AbTLCIi6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 03:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbTLCIi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 03:38:58 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:35968 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264511AbTLCIi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 03:38:57 -0500
Subject: Re: Red Hat AS 2.1 crash.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Eduardo E. Silva" <esilva@silvex.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45084.12.9.207.208.1070424568.squirrel@24.199.16.170>
References: <45084.12.9.207.208.1070424568.squirrel@24.199.16.170>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0C8sEJsrKwB7ot4eUu/U"
Organization: Red Hat, Inc.
Message-Id: <1070440691.5223.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 03 Dec 2003 09:38:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0C8sEJsrKwB7ot4eUu/U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-12-03 at 05:09, Eduardo E. Silva wrote:
> Hello, while mousing around we ran a command
>=20
> find / -type f -exec grep pass {} \;
>=20
> on a Red Hat Advanced Server 2.1 using kernel  2.4.9-e.12smp based rpm fr=
om
> Red Hat. Well the machine panic when grep hit /proc/kmsg.

sounds like you're better off filing a bug with us (Red Hat) than on
lkml ... see http://bugzilla.redhat.com=20

--=-0C8sEJsrKwB7ot4eUu/U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/zaDzxULwo51rQBIRAqJoAKCrgl9jB3vU5SVRlrDh2sTNAqlXMgCfQ65X
OyBWE9SGxX1Q5z7aJyMwJxo=
=n4+o
-----END PGP SIGNATURE-----

--=-0C8sEJsrKwB7ot4eUu/U--
