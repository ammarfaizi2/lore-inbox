Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTEZPnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 11:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTEZPnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 11:43:08 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:10487 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261365AbTEZPnH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 11:43:07 -0400
Subject: Re: [RFC] HZ entry in /proc/sys/kernel
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
In-Reply-To: <1053950030.2028.4.camel@nalesnik.localhost>
References: <1053950030.2028.4.camel@nalesnik.localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-an2qrUAvlGu6MbammIQ7"
Organization: Red Hat, Inc.
Message-Id: <1053951356.32566.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (1.3.3-2) (Preview Release)
Date: 26 May 2003 14:15:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-an2qrUAvlGu6MbammIQ7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-05-26 at 13:53, Grzegorz Jaskiewicz wrote:
> I have seen few scripts allready that are assuming HZ=3D=3D100.
> Afaik this value is different in 2.5/2.4 for the same arch.

No it's not actually.
The userspace interface is constant/stable and in units of HZ=3D100 even
though the kernel HZ might be different.


--=-an2qrUAvlGu6MbammIQ7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+0gV8xULwo51rQBIRAlWRAJ0fKwYOdFSXjun/1Lc50TpHwtBzwgCcDs03
MIJK9LZXfrWkcNVOL00XCvw=
=NqMy
-----END PGP SIGNATURE-----

--=-an2qrUAvlGu6MbammIQ7--
