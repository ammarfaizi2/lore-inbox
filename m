Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUB2TUo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 14:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbUB2TUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 14:20:44 -0500
Received: from theshire.demon.nl ([82.161.26.30]:39469 "EHLO
	hal.shire.sytes.net") by vger.kernel.org with ESMTP id S262109AbUB2TUk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 14:20:40 -0500
Date: Sun, 29 Feb 2004 20:20:34 +0100
From: Robbert Haarman <lkml@inglorion.net>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6 Build System and Binary Modules
Message-ID: <20040229192034.GB8057@shire.sytes.net>
References: <20040229183143.GA8057@shire.sytes.net> <Pine.LNX.4.58.0402291940110.22146@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402291940110.22146@alpha.polcom.net>
X-PGP-Key: http://www.inglorion.net/pubkey.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 29, 2004 at 07:42:45PM +0100, Grzegorz Kulewski wrote:
> > How do I get it to link in the .o file, without making it look for the =
like-named .c file?
>=20
> I do not know if it will help You, but take a look at how makefile of new=
=20
> nvidia driver is built... (patches from minion.de or newest driver from=
=20
> nvidia.com)

Thanks, I got it now. Now just to see what I can do about missing __generic=
_copy_to_user and ..._from_user. :-)

---
"One of the common denominators I have found is that expectations rise abov=
e that which is expected."
	-- George W. Bush

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAQjuCDgDISEp7l6ERAtKcAJ9FNfWCdM9qVIxJcFvtCcFXWyyBcACeIiCx
9hkTRrWQA85o6a6m4FvwWSM=
=olM1
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
