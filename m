Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265664AbUAMWGn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265682AbUAMWGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:06:42 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:7553 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265664AbUAMWGl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:06:41 -0500
Subject: Re: Proposed enhancements to MD
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Scott Long <scott_long@adaptec.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40033D02.8000207@adaptec.com>
References: <40033D02.8000207@adaptec.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6VqlxcTM+CA75SjiDdU0"
Organization: Red Hat, Inc.
Message-Id: <1074031592.4981.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 13 Jan 2004 23:06:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6VqlxcTM+CA75SjiDdU0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-01-13 at 01:34, Scott Long wrote:
> All,
>=20
> Adaptec has been looking at the MD driver for a foundation for their
> Open-Source software RAID stack.

Hi,

Is there a (good) reason you didn't use Device Mapper for this? It
really sounds like Device Mapper is the way to go to parse and use
raid-like formats to the kernel, since it's designed to be independent
of on disk formats, unlike MD.

Greetings,
    Arjan van de Ven

--=-6VqlxcTM+CA75SjiDdU0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBABGvoxULwo51rQBIRAhw4AKCCy0gxYDyoXuylUeB4qKR3jdsgKQCghN6R
yYsNyB0UIwyGAgs4VOAlssU=
=rGKE
-----END PGP SIGNATURE-----

--=-6VqlxcTM+CA75SjiDdU0--
