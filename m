Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUIEOrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUIEOrb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 10:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUIEOrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 10:47:31 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:60071 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266749AbUIEOr0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 10:47:26 -0400
Date: Sun, 5 Sep 2004 16:42:59 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: David Masover <ninja@slaphack.com>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, Jamie Lokier <jamie@shareable.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
Message-ID: <20040905144259.GP26560@thundrix.ch>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902161130.GA24932@mail.shareable.org> <1094146912.31495.13.camel@shaggy.austin.ibm.com> <4137B9FC.7040708@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iq/fWD14IMVFWBCD"
Content-Disposition: inline
In-Reply-To: <4137B9FC.7040708@slaphack.com>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iq/fWD14IMVFWBCD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Thu, Sep 02, 2004 at 07:25:32PM -0500, David Masover wrote:
> This has further implications -- imagine a desktop, binary distro
> shipped with all files except the very most basic stuff as package
> archives.  They can all be extracted, on demand -- the first time I run
> OpenOffice.org, it's installed.  If there needs to be post-installation,
> that's handled by the .deb plugin (or whatever).

zsh using apt extensions does that.

			Tonnerre

--iq/fWD14IMVFWBCD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBOyXz/4bL7ovhw40RAqu5AKCbcN6/aQuSABp3Jo95nfFpRAHtNgCfUjWH
C1CQglecN2IvazLy146mndg=
=4NOs
-----END PGP SIGNATURE-----

--iq/fWD14IMVFWBCD--
