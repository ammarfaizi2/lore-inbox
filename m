Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUIELgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUIELgC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUIELfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:35:52 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:11943 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266425AbUIELfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:35:18 -0400
Date: Sun, 5 Sep 2004 13:33:58 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: David Masover <ninja@slaphack.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040905113358.GE26560@thundrix.ch>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <41352279.7020307@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline
In-Reply-To: <41352279.7020307@slaphack.com>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Tue, Aug 31, 2004 at 08:14:33PM -0500, David Masover wrote:
> It's not about the kernel, it's about the interface.  And see my other mail:
> 	cat foo.zip/README
> 	less foo.zip/contents/bar.c
> is a lot easier than
> 	lynx http://google.com/search?q=zip
> 	emerge zip
> 	man zip
> 	unzip foo.zip
> 	cat bar.c
> which already assumes quite a lot of expertise.

Most distros ship Ziv's packer by default.

telnet dict.org 2628
DEFINE * "creeping featurism"
QUIT

				Tonnerre

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBOvmm/4bL7ovhw40RAr2oAJ9yvYgR+KAVz2Oh5Mh3aIonhg0G2ACcCcYZ
sCebYJtMT9IdjwovMQjrhbA=
=W4DV
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
