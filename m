Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263271AbUFBQPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbUFBQPp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbUFBQPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:15:45 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:3309 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263271AbUFBQPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:15:43 -0400
Date: Wed, 2 Jun 2004 10:15:41 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Alasdair G Kergon <agk@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/5: Device-mapper: kcopyd
Message-ID: <20040602161541.GB15785@schnapps.adilger.int>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040602154129.GO6302@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <20040602154129.GO6302@agk.surrey.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 02, 2004  16:41 +0100, Alasdair G Kergon wrote:
> kcopyd
>=20
> --- diff/drivers/md/kcopyd.c	1969-12-31 18:00:00.000000000 -0600
> +++ source/drivers/md/kcopyd.c	2004-06-01 19:51:31.000000000 -0500
> @@ -0,0 +1,667 @@
> +/*
> + * Copyright (C) 2002 Sistina Software (UK) Limited.
> + *
> + * This file is released under the GPL.
> + */

It might be nice to have a brief comment here explaining what this is
and how it is supposed to be used.

Cheers, Andreas

PS - It isn't really nice to exclude yourself from the reply-to list.
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAvf0tpIg59Q01vtYRAmVOAJ4xRy+fM9c/pWUBONIJwieSD+Q80wCdEeIA
4sw9WmhBkCbGKNp25knA9QU=
=Q+3K
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
