Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTJNU1G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 16:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTJNU1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 16:27:06 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:32385 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262098AbTJNU1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 16:27:04 -0400
Subject: Re: mouse driver bug in 2.6.0-test7?
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: 4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20031014201354.GA10458@ucw.cz>
References: <3F8C3A99.6020106@opensound.com>
	 <1066159113.12171.4.camel@tux.rsn.bth.se> <20031014193847.GA9112@ucw.cz>
	 <3F8C56B3.1080504@opensound.com>  <20031014201354.GA10458@ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-y81dh/QtIJz25Pyp1UHc"
Message-Id: <1066163220.12165.11.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 14 Oct 2003 22:27:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y81dh/QtIJz25Pyp1UHc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-14 at 22:13, Vojtech Pavlik wrote:

> > I'd recommend that you make the sample rate a module config option so t=
hat
> > users may be able to tweak this for their systems.
>=20
> It already is. Only the code to make it a kernel command line parameter
> (when psmouse is compiled into the kernel) is missing.

If you fix that I'd be happy and I'll stop sending that patch over and
over again... :)

--=20
/Martin

--=-y81dh/QtIJz25Pyp1UHc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/jFwUWm2vlfa207ERAj+KAJ0VQ4Eh/Zhes2eM6RbqmcU8XcvvMwCfZ46y
OiKVBo/0yrA2zFJN3K/V1jo=
=vD6d
-----END PGP SIGNATURE-----

--=-y81dh/QtIJz25Pyp1UHc--
