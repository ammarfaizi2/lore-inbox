Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265111AbSJPPmJ>; Wed, 16 Oct 2002 11:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265113AbSJPPmJ>; Wed, 16 Oct 2002 11:42:09 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:34286 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265111AbSJPPmI>; Wed, 16 Oct 2002 11:42:08 -0400
Subject: Re: [patch] mmap-speedup-2.5.42-C3
From: Arjan van de Ven <arjanv@fenrus.demon.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       NPT library mailing list <phil-list@redhat.com>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44.0210160751260.2181-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0210160751260.2181-100000@home.transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-g/FcdP7qi83qpTQR7C1Z"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Oct 2002 17:49:03 +0200
Message-Id: <1034783351.4287.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g/FcdP7qi83qpTQR7C1Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-10-16 at 16:52, Linus Torvalds wrote:
\
> > i think it should be unrelated to the mmap patch. In any case, Andrew
> > added the mmap-speedup patch to 2.5.43-mm1, so we'll hear about this
> > pretty soon.
>=20
> There's at least one Oops-report on linux-kernel on 2.5.43-mm1, where the=
=20
> oops traceback was somewhere in munmap().=20
>=20
> Sounds like there are bugs there.

could be the shared pagetable stuff just as well ;(


--=-g/FcdP7qi83qpTQR7C1Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9rYpvxULwo51rQBIRAmf5AJ44o4IYxJ/0f5WdIYigLBfVYRjU9ACeKdlR
716BgGis7oE5U8atefdMmIg=
=JiNr
-----END PGP SIGNATURE-----

--=-g/FcdP7qi83qpTQR7C1Z--

