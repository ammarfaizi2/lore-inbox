Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbSKERSl>; Tue, 5 Nov 2002 12:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbSKERSl>; Tue, 5 Nov 2002 12:18:41 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:37359 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264976AbSKERSi>; Tue, 5 Nov 2002 12:18:38 -0500
Subject: Re: 2.5 vi .config ; make oldconfig not working
From: Arjan van de Ven <arjanv@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021105171409.GA1137@suse.de>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> 
	<20021105171409.GA1137@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-wAFVIbkLOkgVeT/aE2hR"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 18:26:35 +0100
Message-Id: <1036517201.5601.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wAFVIbkLOkgVeT/aE2hR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-11-05 at 18:14, Jens Axboe wrote:

> axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
> 641:CONFIG_NFSD_V4=3Dy
> axboe@burns:[.]linux-2.5-deadline-rbtree $ vi .config
> axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
> 641:CONFIG_NFSD_V4=3Dn

=3Dn never worked...

# CONFIG_NFSD_V4 is not set


--=-wAFVIbkLOkgVeT/aE2hR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9x/9KxULwo51rQBIRAroxAJ9eYr3nkLGnbSHwh1foNcgWtyyZjACglVtp
CXcVROg2Kx+qa7Q1/lMv+L4=
=hcfI
-----END PGP SIGNATURE-----

--=-wAFVIbkLOkgVeT/aE2hR--

