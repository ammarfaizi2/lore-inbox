Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUIEMCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUIEMCY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbUIEMCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:02:23 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:24231 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266511AbUIEMBw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:01:52 -0400
Date: Sun, 5 Sep 2004 13:58:54 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Spam <spam@tnonline.net>
Cc: Christer Weinigel <christer@weinigel.se>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040905115854.GH26560@thundrix.ch>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org> <m3eklm9ain.fsf@zoo.weinigel.se> <20040905111743.GC26560@thundrix.ch> <1215700165.20040905135749@tnonline.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Content-Disposition: inline
In-Reply-To: <1215700165.20040905135749@tnonline.net>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Sun, Sep 05, 2004 at 01:57:49PM +0200, Spam wrote:
>   What if I do not use emacs, but vim, mcedit, gedit, or some other
>   editor? It doesn't seem logical to have to patch every application
>   that uses files.

We would have to do that in  either case, so let's patch them to do it
in a nonintrusive way. And as to reading and writing inside tar files,
write and/or  use a really nice  userspace library to do  it. (As does
MacOS/X, as does KDE, etc.)

			    Tonnerre

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBOv99/4bL7ovhw40RAudJAJ0S2rtySdsDnt/pPeTU8Ezl8Fr7MACghviu
e4LjgCsAhKbrZaoeZJIlEMY=
=7Xq2
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--
