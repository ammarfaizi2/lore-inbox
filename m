Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUIFI5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUIFI5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 04:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUIFI5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 04:57:51 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:34473 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S267668AbUIFI5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 04:57:36 -0400
Date: Mon, 6 Sep 2004 10:56:14 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Spam <spam@tnonline.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040906085614.GD28697@thundrix.ch>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org> <1591214030.20040902215031@tnonline.net> <20040906074518.GA28697@thundrix.ch> <1873133500.20040906100534@tnonline.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
In-Reply-To: <1873133500.20040906100534@tnonline.net>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Mon, Sep 06, 2004 at 10:05:34AM +0200, Spam wrote:
> Then it is good. Just I see no programs other than Gnome or KDE apps
> that are using them.

Because KDE people  hate Gnome people and vice  versa, and because the
rest of the world just neglects the two races for political reasons.

Maybe   the  Freedesktop  project   should  provide   some  convenient
specification/code to  do it.  Like they  do for HAL  and DBUS (Please
note that this is something  interesting because it does clever things
on hardware without requiring to patch the kernel.)

> > In  case of  marketing it's  up  to the  distributions to  provide
> > something  concise so everyone  can use  their programs  through a
> > coherent namespace. (I.e. port all the apps they ship to gnome-vfs
> > or kio).
>=20
> Do you really believe this will happen?

If the distributors  really want to be able to gain  money, and if the
Free Unix community wants to  gain a significant market share, this is
supposed to  happen. It's  the question of  whether we can  ignore our
childish concept  wars, or if we're  always going to stay  at that low
level we're at now.

Actually, this can't be fixed by putting everything into the kernel.

			    Tonnerre

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBPCYt/4bL7ovhw40RAuYdAJ9/9IaeqcMWfecCIjgFrCpVVYGjxwCeNtrx
zCB78VYSwgBITYpC3Mg8V5M=
=A2HU
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
