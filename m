Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUHWUQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUHWUQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUHWUNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:13:51 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:26100 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267323AbUHWTAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:00:53 -0400
Subject: Re: [PATCH 2.4] gcc-3.4 more fixes
From: Jon Oberheide <jon@oberheide.org>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
In-Reply-To: <4129F0C5.3040309@ttnet.net.tr>
References: <4129F0C5.3040309@ttnet.net.tr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gMgRExu0zbr7+3bWmeLo"
Date: Mon, 23 Aug 2004 15:07:32 -0400
Message-Id: <1093288052.17313.11.camel@dionysus>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gMgRExu0zbr7+3bWmeLo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-08-23 at 16:27 +0300, O.Sezer wrote:
>  > Ozkan,
>  >
>  > This are just warning fixes right?
>  >
>  > I dont like this patches, that is, I'm not confident about them.
>  >
>  >  Let the warnings be.
>=20
> For gcc-3.4 they're warnings. For gcc-3.5 they'll cause compiler
> failures (that's what mikpe says on cset-1.1490, too)

Correct, l-value casts are treated as errors in 3.5.

"The cast-as-lvalue, conditional-expression-as-lvalue and compound-
expression-as-lvalue extensions, which were deprecated in 3.3.4 and 3.4,
have been removed." - http://gcc.gnu.org/gcc-3.5/changes.html

Regards,
Jon Oberheide

--=20
Jon Oberheide <jon@oberheide.org>
GnuPG Key: 1024D/F47C17FE
Fingerprint: B716 DA66 8173 6EDD 28F6  F184 5842 1C89 F47C 17FE

--=-gMgRExu0zbr7+3bWmeLo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD4DBQBBKkB0WEIcifR8F/4RAnuQAJYhGd+qsMrjc8wlBbINh4wQ7cXAAKCiktc+
dNXpyKnYprAbC642TNbe+g==
=P2JD
-----END PGP SIGNATURE-----

--=-gMgRExu0zbr7+3bWmeLo--

