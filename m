Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSKKUDN>; Mon, 11 Nov 2002 15:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261177AbSKKUDL>; Mon, 11 Nov 2002 15:03:11 -0500
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:45258 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S261173AbSKKUDI>; Mon, 11 Nov 2002 15:03:08 -0500
Date: Mon, 11 Nov 2002 21:09:43 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: 2.5.47: Uninitialized timer in bttv code
Message-Id: <20021111210943.57e10a14.us15@os.inf.tu-dresden.de>
In-Reply-To: <3DCFF14F.3BAB81A6@digeo.com>
References: <20021111182641.104131b6.us15@os.inf.tu-dresden.de>
	<3DCFF14F.3BAB81A6@digeo.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.5claws117 (GTK+ 1.2.10; Linux 2.5.47)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.,Ijn8H.CcFzI7s"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.,Ijn8H.CcFzI7s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2002 10:05:03 -0800 Andrew Morton (AM) wrote:

AM> Here you go.
AM> 
AM> I need to do another full pass across the tree to pick up the dynamically
AM> allocated timers.

Thanks, works like a charm.

Regards,
-Udo.

--=.,Ijn8H.CcFzI7s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE90A6KnhRzXSM7nSkRAocQAJ9JDq711JsKNu749tddRBcMW4GgMQCggt6k
HdRcpG32PL8+x+RxK2aY4kE=
=7K+a
-----END PGP SIGNATURE-----

--=.,Ijn8H.CcFzI7s--
