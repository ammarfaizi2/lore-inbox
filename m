Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267734AbTAMJwO>; Mon, 13 Jan 2003 04:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267751AbTAMJwO>; Mon, 13 Jan 2003 04:52:14 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:26862 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S267734AbTAMJwN>; Mon, 13 Jan 2003 04:52:13 -0500
Subject: Re: [PATCH] Check compiler version, SMP and PREEMPT.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, tridge@samba.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
In-Reply-To: <20030113051434.DC2092C09F@lists.samba.org>
References: <20030113051434.DC2092C09F@lists.samba.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-y4lzfxgIMq2yRPs8/c/a"
Organization: Red Hat, Inc.
Message-Id: <1042451987.1806.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 13 Jan 2003 10:59:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y4lzfxgIMq2yRPs8/c/a
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-01-13 at 06:13, Rusty Russell wrote:
> Linus, please apply if you agree.
>=20
> Tridge reported getting burned by gcc 3.2 compiled (Debian) XFree
> modules not working on his gcc 2.95-compiled kernel.

at least the other way around is detected by traditional modules
nowadays=20

--=-y4lzfxgIMq2yRPs8/c/a
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+Io4TxULwo51rQBIRArtOAKCZplXZshdxnl/cQzF63sWFmzMpKQCfbaBF
o7qK1rtxns9gaeCqDZgS+sg=
=dOtW
-----END PGP SIGNATURE-----

--=-y4lzfxgIMq2yRPs8/c/a--
