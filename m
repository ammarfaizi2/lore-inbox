Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbTLYIfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 03:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbTLYIfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 03:35:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42175 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264144AbTLYIff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 03:35:35 -0500
Date: Thu, 25 Dec 2003 09:35:29 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Subject: Re: Question on LFS in Redhat
Message-ID: <20031225083529.GC29678@devserv.devel.redhat.com>
References: <20031223151042.GE9089@vnl.com> <1072193917.5262.1.camel@laptop.fenrus.com> <20031223235827.GK9089@vnl.com> <20031224084903.GB20976@devserv.devel.redhat.com> <20031225010925.GG4987@vnl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <20031225010925.GG4987@vnl.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 25, 2003 at 01:09:25AM +0000, Dale Amon wrote:
> On Wed, Dec 24, 2003 at 09:49:03AM +0100, Arjan van de Ven wrote:
> > You really shouldn't be running a 2.4.16 kernel (not without the latest
> > security patches for such a kernel from a distro) given the amount of s=
ecurity issues
> > fixed since... and since I don't think any distro ever shipped 2.4.16 (=
some
> > shipped 2.4.17, a bunch shipped 2.4.18 but even RH doesn't do patches f=
or
> > that 2.4.18 tree anymore since they have been obsoleted by 2.4.20 and n=
ewer
> > kernels).
>=20
> Not really my choice... and from what you say I'd better
> not *touch* their stock kernel if I a project for which I=20
> specced that box happens.
>=20
> Also, fresh feedback from the Consensys is that:
>=20
> 	"Just to be precise - As of today the kernel=20
> 	 is 2.4.18-i59smp #1"

can you ask them for the full source of this (including that of derived
works they include in it) ? I'd be curious what stuff they include

> So that is a little better but still a little out
> of date. I'm not terribly worried about the local
> exploit because you don't tend to want to allow external
> login accounts on things on your SAN's...

you forgot the remote hash-collision DoS issues in 2.4.18 etc etc


--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/6qFQxULwo51rQBIRAhvSAKCQSVp0y5QyvtDUF7kDQHP20VrS4gCgn2z6
8426A0LeP6G10zfj6IwAdPY=
=xP2V
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
