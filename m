Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUIEL4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUIEL4N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUIEL4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:56:13 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:19879 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266473AbUIEL4G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:56:06 -0400
Date: Sun, 5 Sep 2004 13:54:40 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jamie Lokier <jamie@shareable.org>, Pavel Machek <pavel@suse.cz>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040905115440.GF26560@thundrix.ch>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <41352279.7020307@slaphack.com> <20040901045922.GA512@elf.ucw.cz> <20040901161456.GA31934@mail.shareable.org> <20040901201824.GB11838@atrey.karlin.mff.cuni.cz> <20040901215939.GK31934@mail.shareable.org> <1094079071.1343.25.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Content-Disposition: inline
In-Reply-To: <1094079071.1343.25.camel@krustophenia.net>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Wed, Sep 01, 2004 at 06:51:12PM -0400, Lee Revell wrote:
> FWIW, this is how Windows does it now.  As of XP, 'Find files' has an
> option, enabled by default, to look inside archives.  If you tell it to
> look for a driver in a given directory it will also look inside .cab=20
> and .zip files.  It's extremely useful, I would imagine someone who uses
> XP a lot will come to expect this feature.
>=20
> Of course, no idea how it's implemented, but users like it.

The trick  is that their tools are  aware of it, and  that the library
the programs use supports on-the-fly decompression.

Same applies to Spotlight for Tiger.

			    Tonnerre


--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBOv6A/4bL7ovhw40RAjwgAJ4kjly/uZxD1YbhIYL5cfGaFTXJiQCgk6d6
Vo0dIfmaSPXN/LhSd0V0Jlw=
=I9ym
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--
