Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbTIVFpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 01:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbTIVFpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 01:45:33 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:10965 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262986AbTIVFpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 01:45:31 -0400
Date: Mon, 22 Sep 2003 08:45:11 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Robert Love <rml@tech9.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Chris Rivera <cmrivera@ufl.edu>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE]  slab information utility
Message-ID: <20030922054511.GH4938@actcom.co.il>
References: <1064199786.1199.29.camel@boobies.awol.org> <20030922051754.GF4306@holomorphy.com> <1064208319.8888.248.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RwxaKO075aXzzOz0"
Content-Disposition: inline
In-Reply-To: <1064208319.8888.248.camel@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RwxaKO075aXzzOz0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2003 at 01:25:19AM -0400, Robert Love wrote:
> On Mon, 2003-09-22 at 01:17, William Lee Irwin III wrote:
>=20
> > I wrote something I called this earlier on; I'll withdraw any claim of
> > mine on the name since this utility is clearly superior to it and I'd
> > rather endorse it than my own creation.
>=20
> Sweet.  Hope you like it.  I think its very valuable during all sorts of
> kernel debugging (or even simple administrating), because everything is
> tied into the slab layer but /proc/slabinfo, while useful information,
> is impossible to grok.

I used to have a patch that implemented a /sysfs/slab/ layer, where=20
you could get all of the /proc/slabinfo information via sysfs
conveniently. Sadly, it went to wherever bad harddisks go when they
die. Since I need it for a different endeavour, I'll ressurect it
eventually. That should make the parsing in slabinfo a lot simpler.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--RwxaKO075aXzzOz0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/boxnKRs727/VN8sRApUqAJ9yaQEvnpbt4ubePGJ8/5mvHMJ7DQCdGYCH
fbUYSqrwGQKS4/5poKXoPWs=
=78RD
-----END PGP SIGNATURE-----

--RwxaKO075aXzzOz0--
