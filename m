Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbVKWBOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbVKWBOr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 20:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVKWBOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 20:14:47 -0500
Received: from zlynx.org ([199.45.143.209]:46349 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S1030297AbVKWBOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 20:14:47 -0500
Subject: Re: Linux 2.6.15-rc2
From: Zan Lynx <zlynx@acm.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>, ak@muc.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0511221642310.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
	 <43829ED2.3050003@mnsu.edu> <20051122150002.26adf913.akpm@osdl.org>
	 <Pine.LNX.4.64.0511221642310.13959@g5.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cQlYw6SZge4pxldu71Kv"
Date: Tue, 22 Nov 2005 18:14:02 -0700
Message-Id: <1132708443.9905.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cQlYw6SZge4pxldu71Kv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-11-22 at 16:50 -0800, Linus Torvalds wrote:
>=20
> On Tue, 22 Nov 2005, Andrew Morton wrote:
>=20
> > Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu> wrote:
> > >
> > >                 from fs/compat_ioctl.c:52,
> > >                  from arch/x86_64/ia32/ia32_ioctl.c:14:
> > > include/linux/ext3_fs.h: In function 'ext3_raw_inode':
> > > include/linux/ext3_fs.h:696: error: dereferencing pointer to incomple=
te type
> >=20
> > This might help?
>=20
> Why does it happen at all, though? And why aren't more people reporting=20
> this? Something strange going on.

I get exactly the same build error on my AMD64 system.  I didn't report
it because I figured that someone else had already seen it.
--=20
Zan Lynx <zlynx@acm.org>

--=-cQlYw6SZge4pxldu71Kv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDg8JaG8fHaOLTWwgRAiEyAJ45yP4956p4/ciz4GqId4wuiOlMDgCgiey1
Di8gYWOd4dWQ82ZZiryciwk=
=qC70
-----END PGP SIGNATURE-----

--=-cQlYw6SZge4pxldu71Kv--

