Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268998AbUHZOHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268998AbUHZOHf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268937AbUHZOEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:04:07 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:53654 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S268972AbUHZOCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:02:20 -0400
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
From: Christophe Saout <christophe@saout.de>
To: Rik van Riel <riel@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.44.0408260952230.26316-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0408260952230.26316-100000@chimarrao.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-f/zgBaXUVBVdKW8WeC3r"
Date: Thu, 26 Aug 2004 16:02:02 +0200
Message-Id: <1093528922.11694.41.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f/zgBaXUVBVdKW8WeC3r
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 09:52 -0400 schrieb Rik van Riel:

> > That's your opinion. reiser4 seems to work very well.
>=20
> Have you tried /bin/cp, or a backup+restore ?
>=20
> What happened to your file streams ?

1. I wasn't talking about reiser4 plugins, not about the
   file-as-a-directory thing or file streams
2. reiser4 doesn't currently have those
3. I don't really like file streams

:-)

But I'm using ACLs on a server and had to forward-port an rsync patch to
make full backups using rsync possible. That's not really better.


--=-f/zgBaXUVBVdKW8WeC3r
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLe1aZCYBcts5dM0RAuFwAJ4nm0ZkE8Cd5yP8yMwoco1sH1jHLwCgkfRO
7ByUg/+SA5E9S3tIdnNLk/o=
=ytd6
-----END PGP SIGNATURE-----

--=-f/zgBaXUVBVdKW8WeC3r--

