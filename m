Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbTLUT3a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTLUT3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:29:30 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:20139 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S263942AbTLUT31
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:29:27 -0500
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
From: Stan Bubrouski <stan@ccs.neu.edu>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031221105333.GC3438@mail.shareable.org>
References: <1071969177.1742.112.camel@cube>
	 <20031221105333.GC3438@mail.shareable.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OfflOKwlN7CUCsMUPBnf"
Message-Id: <1072034966.1286.119.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 21 Dec 2003 14:29:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OfflOKwlN7CUCsMUPBnf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-12-21 at 05:53, Jamie Lokier wrote:
> Albert Cahalan wrote:
> > What about the obvious Kconfig option?
> >=20
> > config PATENT_1234567890
> >         bool "Patent 1234567890"
> >         default n
> >         help
> >           Say Y here if you have the right to use
> >           patent 1234567890 (the foo patent). Some
> >           countries do not recognise this patent, an
> >           educational or research exemption may apply,
> >           you may be the patent holder, the patent
> >           may have expired, or you may have aquired
> >           rights via licensing. Seek legal help if you
> >           need advice concerning your rights. If unsure,
> >           say N.
>=20
> I expect this was said in jest, but it would be delightful to see this
> done for real.  To the best of my knowlege it's uncharted territory,
> so perhaps what you suggest _would_ be upheld in a court of law as
> permissible?
<SNIP>

No No No No No...do you really think including code for a patented
algorithm(s) is a good idea?  You are still distributing the code and
allowing people to illegally use it in countries where they are not
allowed to.  In essence you are providing a catalyst for them to violate
a patent and making yourself and other liable along the way.  US law is
sick and fucked up, and if someone sues you for patent infringement
you're most likely fucked, because you can never have enough money to
defend yourself...for the sake of us stuck in this so-called free
country (though we can be arrested and jailed without trial?) please do
not include patented algoriths in Linux...

-sb

--=-OfflOKwlN7CUCsMUPBnf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/5fSWQHy9+2ztQiARAikWAKCtmnQoqPb3Ii7vMBwaDAHosj6KTwCfdraG
R6qNG/OchAVMQcJndgZ+5nM=
=I/w7
-----END PGP SIGNATURE-----

--=-OfflOKwlN7CUCsMUPBnf--

