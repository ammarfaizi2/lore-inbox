Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271377AbTHDErd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 00:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271378AbTHDErd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 00:47:33 -0400
Received: from adsl-67-121-153-186.dsl.pltn13.pacbell.net ([67.121.153.186]:44496
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S271377AbTHDErc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 00:47:32 -0400
Date: Sun, 3 Aug 2003 21:47:28 -0700
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm3-1: Badness in class_dev_release followed by 5 NFS server hangs
Message-ID: <20030804044728.GC5786@triplehelix.org>
References: <20030803135641.49d6316e.akpm@osdl.org> <200308040953.42110.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <200308040953.42110.mflt1@micrologica.com.hk>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2003 at 11:10:08AM +0800, Michael Frank wrote:
> OK, What about the NFS hangs there are more now, also some short in durat=
ion=20
>=20
> Aug  4 04:22:02 mhfl4 kernel: nfs: server mhfl2 not responding, still try=
ing
> Aug  4 04:22:02 mhfl4 kernel: nfs: server mhfl2 OK
> Aug  4 04:23:59 mhfl4 kernel: nfs: server mhfl2 not responding, still try=
ing
> Aug  4 04:23:59 mhfl4 kernel: nfs: server mhfl2 OK

Interesting, I also see *many* of these on my laptop running
2.6.0-test2-mm2. The NFS server is running 2.4.21.

-Josh

--=20
Joshua Kwan

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/LeVgT2bz5yevw+4RAgF0AKC9LWu9565wNQEsMnDL4zSGVx7DrgCdFJ5w
T2FyeeZ2TTgf+mT5VqE9MvA=
=HpMP
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
