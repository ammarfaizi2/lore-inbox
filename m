Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbSJWUdb>; Wed, 23 Oct 2002 16:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265203AbSJWUda>; Wed, 23 Oct 2002 16:33:30 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:54067 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S265198AbSJWUd3>;
	Wed, 23 Oct 2002 16:33:29 -0400
Date: Wed, 23 Oct 2002 22:39:34 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] CONFIG_TINY
Message-ID: <20021023223934.A30492@jaquet.dk>
References: <20021023215117.A29134@jaquet.dk> <20021023210845.A23157@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021023210845.A23157@infradead.org>; from hch@infradead.org on Wed, Oct 23, 2002 at 09:08:45PM +0100
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2002 at 09:08:45PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 23, 2002 at 09:51:17PM +0200, Rasmus Andersen wrote:
> > o SWAP and BLOCK_DEV as modules
>=20
> modules won't work I guess :)  but allowing to disable them is a good
> idea.  Not that swap depends on the block device code, though.

The module approach was just a happy thought jotted down from an
IRC log. I guess there is a number of reasons that that won't=20
work.=20

I did not meant to imply that SWAP and block was related, just
that both (perhaph) could be made modules.

Thanks for your comments,
  Rasmus

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD4DBQE9twkGlZJASZ6eJs4RAuGnAJiz9Ck53F+6nbXMugUnlqI9kJgyAJ97Y4zo
mc9tsADdoWt+c2lkrsHH9w==
=9Eac
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
