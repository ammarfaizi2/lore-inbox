Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265258AbUENLku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbUENLku (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 07:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbUENLku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 07:40:50 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:37322 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265258AbUENLks
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 07:40:48 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (6/6): network driver.
Date: Fri, 14 May 2004 13:40:04 +0200
User-Agent: KMail/1.6.1
References: <20040513191539.GG2916@mschwid3.boeblingen.de.ibm.com> <20040513204421.A15306@infradead.org>
In-Reply-To: <20040513204421.A15306@infradead.org>
Cc: "Frank Pavlic" <pavlic@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_XALpAPllwCf3ubH";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405141340.07207.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_XALpAPllwCf3ubH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 13 May 2004 21:44, Christoph Hellwig wrote:
> On Thu, May 13, 2004 at 09:15:39PM +0200, Martin Schwidefsky wrote:
> > [PATCH] s390: network device driver.
> >=20
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
>=20
> Btw, what about the s390/ipv6 releated patch suse is carrying around
> but which apparently never escaped to a public list?

I think that must be the support for virtualized ethernet cards
that was last discussed in early 2003:

http://marc.theaimsgroup.com/?t=3D104550859900002&r=3D1&w=3D2

Something like this required for using ipv6 on Linux in z/VM, but so
far no one has come up with an implementation that is fit for inclusion.
If you have a clever idea how to do this in a cleaner way, please tell.

	Arnd <><

--Boundary-02=_XALpAPllwCf3ubH
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBApLAX5t5GS2LDRf4RAvIlAJ48swshJQnYombvcMabq/PGb2IpJgCdGaqZ
Hlfbc9P/o3IC2OFX8+28Sl4=
=DeVh
-----END PGP SIGNATURE-----

--Boundary-02=_XALpAPllwCf3ubH--
