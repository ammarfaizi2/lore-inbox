Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbTE2L0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 07:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTE2L0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 07:26:36 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:60398 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262170AbTE2L0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 07:26:35 -0400
Subject: Re: must-fix list, v5
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "David S. Miller" <davem@redhat.com>
Cc: pavel@suse.cz, ak@suse.de, akpm@digeo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030529.042615.55727031.davem@redhat.com>
References: <p73wuga6rin.fsf@oldwotan.suse.de>
	 <20030529.023203.41634240.davem@redhat.com>
	 <20030529112517.GC1215@elf.ucw.cz>
	 <20030529.042615.55727031.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Wd972/nByYjuldETZM+m"
Organization: Red Hat, Inc.
Message-Id: <1054208379.5223.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (1.3.3-2) (Preview Release)
Date: 29 May 2003 13:39:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Wd972/nByYjuldETZM+m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-05-29 at 13:26, David S. Miller wrote:
>    From: Pavel Machek <pavel@suse.cz>
>    Date: Thu, 29 May 2003 13:25:17 +0200
>   =20
>    What is copy_in_user?
>=20
> Both source and destination pointers are in userspace.

sys_memcpy() ?


--=-Wd972/nByYjuldETZM+m
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+1fF7xULwo51rQBIRAgYlAKCc7UnGbh5Z+FKSmRhsaLvdPbEH+wCfavAw
MAQeyPgM1TMQ7vh90/kyn3I=
=j0B8
-----END PGP SIGNATURE-----

--=-Wd972/nByYjuldETZM+m--
