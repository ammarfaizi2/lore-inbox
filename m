Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTJ1WWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTJ1WWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:22:49 -0500
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:42909 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S261782AbTJ1WWr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:22:47 -0500
Subject: Re: CPU-Test similar to Memtest?
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031028160550.GA855@rdlg.net>
References: <20031028160550.GA855@rdlg.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZrbSHT+NPHkpyC02PGli"
Organization: Linux Networx
Message-Id: <1067379433.6281.575.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 28 Oct 2003 15:17:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZrbSHT+NPHkpyC02PGli
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-28 at 09:05, Robert L. Harris wrote:
> I'm going to run MEMTEST today when I get home and get a chance to make
> a bootable CD

Memtest86 is good, but it isn't as good as it could be.  Many times I
have seen it run 24 hours without error even though the the system has
bad memory.

>  but I'm wondering if there might be a "CPUTEST" or such
> utility anyone knows of that'll poke and prod a dual athalon real well
> and make sure I don't have a flaky cpu.

Run Linpack (or other computationally intensive program) while
monitoring ECC errors with either
http://www.anime.net/~goemon/linux-ecc/files/
or
ftp://ftp.lnxi.com/pub/bluesmoke


--=20
Thayne Harbaugh
Linux Networx

--=-ZrbSHT+NPHkpyC02PGli
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/nurpfsBPTKE6HMkRAl+8AJ9AviU/zpTafOvV1nDh3GLfjrh9jgCdHzH0
URqGGj0Gr1vy7txuRKXRo+w=
=HORO
-----END PGP SIGNATURE-----

--=-ZrbSHT+NPHkpyC02PGli--

