Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUIELTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUIELTb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266310AbUIELTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:19:31 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:4263 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266308AbUIELTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:19:20 -0400
Date: Sun, 5 Sep 2004 13:17:43 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Christer Weinigel <christer@weinigel.se>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040905111743.GC26560@thundrix.ch>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org> <m3eklm9ain.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <m3eklm9ain.fsf@zoo.weinigel.se>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Wed, Sep 01, 2004 at 01:02:24AM +0200, Christer Weinigel wrote:
> I can see the argument for having the equivalent of Content-type or
> Content-transfer-encoding as a named stream though.

Why having them as  named streams if we can get them  as xattrs for no
additional pain? (Since fileutils would  have to be changed anyway, we
can even make cp copy and emacs update xattrs.)

			    Tonnerre

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBOvXW/4bL7ovhw40RAgEoAJ0UOEVKG2hNAA2tIfGa7HPNH/lf4QCfT4Jg
OkQzpbws19klhIWDmxBGLd0=
=nJQC
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
