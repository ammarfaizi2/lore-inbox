Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbUKPPAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbUKPPAI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 10:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbUKPO6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:58:52 -0500
Received: from irulan.endorphin.org ([212.13.208.107]:57357 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261995AbUKPO6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:58:11 -0500
Subject: Re: GPL version, "at your option"?
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20041116143546.GA4398@harddisk-recovery.com>
References: <1100614115.16127.16.camel@ghanima>
	 <20041116143546.GA4398@harddisk-recovery.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-m+Y3WCsq6qP6ru4rP2ED"
Date: Tue, 16 Nov 2004 15:58:09 +0100
Message-Id: <1100617089.16127.20.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-m+Y3WCsq6qP6ru4rP2ED
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-11-16 at 15:35 +0100, Erik Mouw wrote:
> On Tue, Nov 16, 2004 at 03:08:35PM +0100, Fruhwirth Clemens wrote:
> > I'm about to submit a patch for a new cipher mode called LRW, adding ne=
w
> > code/files to the crypto tree. My question is, especially to the
> > maintainers: Are you going to accept code covered by the terms:
> >=20
> >  * This program is free software; you can redistribute it and/or modify
> >  * it under the terms of the GNU General Public License as published by
> >  * the Free Software Foundation, version 2 of the License.
>=20
> There's already quite some code that's only licensed with GPLv2. Look
> for example at arch/arm/common/dmabounce.c which does the same as you
> want but with slightly different words:

Thanks, I wasn't sure, what to grep for.=20

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-m+Y3WCsq6qP6ru4rP2ED
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBmhWBW7sr9DEJLk4RAv/8AKCGeLu1zMLUODTYnWw4c4hAapSzMgCffDzd
4gBTNaf2dHo+WjIksHaGksA=
=nwo8
-----END PGP SIGNATURE-----

--=-m+Y3WCsq6qP6ru4rP2ED--
