Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264452AbTCXSSu>; Mon, 24 Mar 2003 13:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264456AbTCXSSt>; Mon, 24 Mar 2003 13:18:49 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:8692 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S264452AbTCXSSs>; Mon, 24 Mar 2003 13:18:48 -0500
Subject: Re: ancient block_dev patch
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Christoph Hellwig <hch@infradead.org>
Cc: davej@codemonkey.org.uk, akpm@zip.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <20030324181636.A22228@infradead.org>
References: <200303241642.h2OGg735008305@deviant.impure.org.uk>
	 <20030324181636.A22228@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fx9xEKuP5/2ahrfmVzvI"
Organization: Red Hat, Inc.
Message-Id: <1048530588.1636.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 24 Mar 2003 19:29:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fx9xEKuP5/2ahrfmVzvI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-03-24 at 19:16, Christoph Hellwig wrote:
> On Mon, Mar 24, 2003 at 04:41:54PM +0000, davej@codemonkey.org.uk wrote:
> > Andrew,
> >  What became of this patch ? Is it needed ?
>=20
> It's not needed but a nice speedup for certain loads.  IIRC one of them
> was INN directly using blockdevices

and certain dvd players

--=-fx9xEKuP5/2ahrfmVzvI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+f06cxULwo51rQBIRAuswAJ9xpLRUdiLDPMSWPGeoyi9zT1VbzwCdFVwN
Gh98QWW3VhrdcgoZR6nYj88=
=kK5j
-----END PGP SIGNATURE-----

--=-fx9xEKuP5/2ahrfmVzvI--
