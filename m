Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVAEUGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVAEUGm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVAEUGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:06:42 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10426 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262577AbVAEUGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:06:35 -0500
Date: Wed, 5 Jan 2005 15:05:26 -0500
To: prism54-devel@prism54.org, prism54-users@prism54.org
Cc: Netdev <netdev@oss.sgi.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, mcgrof@studorgs.rutgers.edu
Subject: Open hardware wireless cards
Message-ID: <20050105200526.GL5159@ruslug.rutgers.edu>
Mail-Followup-To: prism54-devel@prism54.org,
	prism54-users@prism54.org, Netdev <netdev@oss.sgi.com>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	Jean Tourrilhes <jt@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Content-Disposition: inline
In-Reply-To: <20050105192447.GJ5159@ruslug.rutgers.edu>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 05, 2005 at 02:24:47PM -0500, Luis R. Rodriguez wrote:
<-- snip -->

> As far as support for the new chipsets goes -- sorry -- we won't be able
> to support it as I don't think even Conexant has a final well tested
> linux source base ready for 2.6. And even if we are given a source base
> there is nothing we can do to get around the need for the closed-source=
=20
> softmac libs that it relies on. As much as I'd like to support it, I
> don't want to get a headache to support something I cannot modify so I
> won't be willing to support a half-opened driver as the atheros driver.

I'd also like to add...

For those of you frustrated about our current wireless driver situation
in open platforms --

I think we probably will have this trouble with most modern hardware for a =
while
(graphics cards, wireless driver, etc). A lot of has to do with patent
infringement issues, "intellectual property" protection, and other
business-oriented excuses.

What I think we probably will have to do is just work torwards seeing if
we can come up with our own open wireless hardware. I know there was
a recent thread on lkml about an open video card -- anyone know where
that ended up?

If we can't come up with our own project to work on open hardware we can
also just see if its feasible to purchase hardware companies on the
verge of going backrupt and buy them out and release the specs/etc (a la
blender). Can someone do the math here? I'm lazy.

	Luis

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB3EiGat1JN+IKUl4RAt6mAJ9gbrBRF/ua2WuCBHLQcrpy012SxQCgjAlq
HLlowOyG5hYmToywmmfBsNA=
=g6/K
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
