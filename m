Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUFZHSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUFZHSm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 03:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266014AbUFZHSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 03:18:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41157 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263626AbUFZHSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 03:18:40 -0400
Subject: Re: 32-bit dma allocations on 64-bit platforms
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: davidm@hpl.hp.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16605.1055.383447.805653@napali.hpl.hp.com>
References: <20040623183535.GV827@hygelac> <40D9D7BA.7020702@pobox.com>
	 <16605.1055.383447.805653@napali.hpl.hp.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2QOR+p/SZSxE0EqL6M9Z"
Organization: Red Hat UK
Message-Id: <1088234187.2805.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 26 Jun 2004 09:16:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2QOR+p/SZSxE0EqL6M9Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-26 at 07:05, David Mosberger wrote:
> >>>>> On Wed, 23 Jun 2004 15:19:22 -0400, Jeff Garzik <jgarzik@pobox.com>=
 said:
>=20
>   Jeff> swiotlb was a dumb idea when it hit ia64, and it's now been propa=
gated
>   Jeff> to x86-64 :(
>=20
> If it's such a dumb idea, why not submit a better solution?

the real solution is an iommu of course, but the highmem solution has
quite some merit too..... I know you disagree with me on that one
though.

--=-2QOR+p/SZSxE0EqL6M9Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA3SLLxULwo51rQBIRArdfAKCnJUgdRiy2G6Rlr8M5dl9fK8VDkQCggm6b
EWactQ8PsjyA0h2K8cLGLn8=
=Ojts
-----END PGP SIGNATURE-----

--=-2QOR+p/SZSxE0EqL6M9Z--

