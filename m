Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbUL3Hq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbUL3Hq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 02:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUL3Hq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 02:46:58 -0500
Received: from faye.voxel.net ([69.9.164.210]:18626 "EHLO faye.voxel.net")
	by vger.kernel.org with ESMTP id S261566AbUL3Hqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 02:46:55 -0500
Subject: Re: [PATCH] kernel_read result fixes
From: Andres Salomon <dilinger@voxel.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041229232502.0549b408.akpm@osdl.org>
References: <1103873064.5994.6.camel@localhost>
	 <20041229232502.0549b408.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PKdFjCG99JHr1NYxWn9+"
Date: Thu, 30 Dec 2004 02:46:52 -0500
Message-Id: <1104392812.11411.51.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PKdFjCG99JHr1NYxWn9+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-12-29 at 23:25 -0800, Andrew Morton wrote:
> Andres Salomon <dilinger@voxel.net> wrote:
> >
> > A few potential vulnerabilities were pointed out by Katrina Tsipenyuk i=
n
> >  <http://seclists.org/lists/linux-kernel/2004/Dec/1878.html>.  I haven'=
t
> >  seen any discussion or fixes of the issue yet, so here's a patch
> >  (against 2.6.9).  The fixes are along the same lines as the previous
> >  binfmt_elf fixes.  There's one additional place (inside fs/binfmt_som.=
c)
> >  that a fix could be applied, but since that doesn't compile anyways, I
> >  didn't see a point in patching it.
>=20
> This patch is very wrong.
>=20

Yep, I already followed up saying that.  I assume you're just going
through your inbox after vacation now; it should be there.  :)


--=20
Andres Salomon <dilinger@voxel.net>

--=-PKdFjCG99JHr1NYxWn9+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB07Jr78o9R9NraMQRAuStAKCJX0RH6FLM6nIaEODPbjJFMDk8mgCfUz8c
iJdWs21orz6CZ4utna5GHLc=
=a4vo
-----END PGP SIGNATURE-----

--=-PKdFjCG99JHr1NYxWn9+--

