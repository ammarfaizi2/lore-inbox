Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTLUTdk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTLUTdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:33:40 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:63147 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S264095AbTLUTdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:33:38 -0500
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
From: Stan Bubrouski <stan@ccs.neu.edu>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1072018574.5225.5.camel@laptop.fenrus.com>
References: <Xine.LNX.4.44.0312210833030.3044-100000@thoron.boston.redhat.com>
	 <1072018574.5225.5.camel@laptop.fenrus.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oI2nRb9NDQBs7l68H223"
Message-Id: <1072035217.1286.123.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 21 Dec 2003 14:33:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oI2nRb9NDQBs7l68H223
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-12-21 at 09:56, Arjan van de Ven wrote:
> > > I expect this was said in jest, but it would be delightful to see thi=
s
> > > done for real.  To the best of my knowlege it's uncharted territory,
> > > so perhaps what you suggest _would_ be upheld in a court of law as
> > > permissible?
> > >=20
> >=20
> > This approach would turn Linux into proprietary software.
>=20
> how so?
> How is adding speed improvements to the code that may not be allowed in
> ONE country make linux proprietary? We can't just rip out each and every
> feature that ANY goverment or country in the world declares illegal/not
> allowed to be used. CONFIG_USA and the like only provide a hint/helper
> for those who want to use it in geographies where certain restrictions
> are imposed by law on what software is allowed to do (without paying
> third parties that is).  Now of course it's a problem if the kernel
> wouldn't function at all with CONFIG_USA is set (although perfectly ok
> within the gpl afaics), but for additional performance improvements ?

What about the legal ramifications in the US of distributing code using
an algorithm that is covered by a patent without permission.  What are
we gonna just not distribute the kernel in the US at all?  Cause that's
the only way to safely do what you all keep blathering about without a
license.  By putting the code in the kernel you are putting us in the US
at risk, someone could argue you are giving people a means to violate a
patent in the US...not something you want to be doing!

-sb

--=-oI2nRb9NDQBs7l68H223
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/5fWRQHy9+2ztQiARAvBfAJ9GgawpHIkBskNn4JvspyMHiOVj9gCg3amv
nyaECVMWh8fjOTU3oQuTdIc=
=i4xu
-----END PGP SIGNATURE-----

--=-oI2nRb9NDQBs7l68H223--

