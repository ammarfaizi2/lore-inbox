Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbTLIJgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266179AbTLIJgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:36:50 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:13954 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263963AbTLIJgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:36:46 -0500
Subject: Re: ACPI global lock macros
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Paul Menage <menage@google.com>
Cc: agrover@groveronline.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <3FD59441.2000202@google.com>
References: <3FD59441.2000202@google.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5mPuSqYGK/AtJOUNx7a3"
Organization: Red Hat, Inc.
Message-Id: <1070962573.5223.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 09 Dec 2003 10:36:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5mPuSqYGK/AtJOUNx7a3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-09 at 10:22, Paul Menage wrote:
> Hi Andy,
>=20
> The ACPI_ACQUIRE_GLOBAL_LOCK() macro in include/asm-i386/acpi.h looks a=20
> little odd:

maybe the odd thing is that it exists at all?
(eg why does ACPI need to have it's own locking primitives...)

--=-5mPuSqYGK/AtJOUNx7a3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/1ZeMxULwo51rQBIRAp66AKCfETUoMHAFHUqrURd40Vr/Rr58VgCeJvkp
goeDjc/qFd+iX3VLVRwGuQc=
=dGep
-----END PGP SIGNATURE-----

--=-5mPuSqYGK/AtJOUNx7a3--
