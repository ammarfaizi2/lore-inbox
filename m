Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268083AbUIFOpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268083AbUIFOpi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 10:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268070AbUIFOpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 10:45:38 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:17066 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S267393AbUIFOpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 10:45:23 -0400
Date: Mon, 6 Sep 2004 16:43:58 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Spam <spam@tnonline.net>
Cc: Valdis.Kletnieks@vt.edu, Frank van Maarseveen <frankvm@xs4all.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040906144358.GC29886@thundrix.ch>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <200409022319.i82NJlTN025039@turing-police.cc.vt.edu> <1076230617.20040903014302@tnonline.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <1076230617.20040903014302@tnonline.net>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Fri, Sep 03, 2004 at 01:43:02AM +0200, Spam wrote:
>   Yes why not? If there was any filesystem drivers for the AudioCD
>   format then it could.
>=20
>   I had such a driver for Windows 9x which would display several
>   folders and files for inserted AudioCD's:
>=20
>   D: (cdrom)
>     Stereo
>       22050
>         Track01.wav
>         Track02.wav
>         ...
>       44100
>         Track01.wav
>         ...
>     Mono
>       22050
>         Track01.wav
>         ...
>       44100
>         Track01.wav
>         ...

So you'd like the kernel to know  about raw CD PCM and RIFF PCM format
and conversion? Great.. That's really Solarisish!

			    Tonnerre


--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBPHet/4bL7ovhw40RAs5/AKCOAE52YmYiqRg2ewFMMSojjGITLwCcCcp4
t8L4rqwZlgRFVfhYgavXo7c=
=1PNu
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
