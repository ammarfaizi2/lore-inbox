Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbTCCKT5>; Mon, 3 Mar 2003 05:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbTCCKT5>; Mon, 3 Mar 2003 05:19:57 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:48622 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S262796AbTCCKT4>; Mon, 3 Mar 2003 05:19:56 -0500
Subject: Re: [PATCH] cciss: add passthrough ioctl
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm@digeo.com
In-Reply-To: <200303030506.h2356wM27352@hera.kernel.org>
References: <200303030506.h2356wM27352@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wyppg4FA26/kBmdgMdVI"
Organization: Red Hat, Inc.
Message-Id: <1046687413.1435.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 03 Mar 2003 11:30:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wyppg4FA26/kBmdgMdVI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-03-03 at 05:38, Linux Kernel Mailing List wrote:
> ChangeSet 1.1058, 2003/03/02 20:38:36-08:00, akpm@digeo.com
>=20
> 	[PATCH] cciss: add passthrough ioctl
> =09
> 	Patch from Stephen Cameron <steve.cameron@hp.com>
> =09
> 	Add new big passthrough ioctl to allow large buffers.  Used by e.g.  onl=
ine
> 	array controller firmware flash utility.

WHY?

didn't 2.5 have a generic method of doing this instead of weird per
driver ioctls ?

--=-wyppg4FA26/kBmdgMdVI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+Yy61xULwo51rQBIRAm+ZAJ4zeFsj99IEgSfW4wKgR7yNAVoKvQCgkNvG
a5ggK/lWvd0YRBdG5wK0904=
=Qc+B
-----END PGP SIGNATURE-----

--=-wyppg4FA26/kBmdgMdVI--
