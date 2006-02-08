Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWBHLjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWBHLjW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 06:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWBHLjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 06:39:22 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:18904 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S964988AbWBHLjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 06:39:21 -0500
Date: Wed, 8 Feb 2006 13:39:18 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net
Subject: Re: [PATCH]  unify pfn_to_page take 2 [19/25] sh funcs
Message-ID: <20060208113918.GB31635@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net
References: <43E98F38.20704@jp.fujitsu.com> <43E98ED6.3020108@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <43E98F38.20704@jp.fujitsu.com> <43E98ED6.3020108@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2006 at 03:25:26PM +0900, KAMEZAWA Hiroyuki wrote:
> SH can use generic funcs.
>=20
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
>=20

On Wed, Feb 08, 2006 at 03:27:04PM +0900, KAMEZAWA Hiroyuki wrote:
> sh64 can use generic funcs.
>=20
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
>=20
Both look fine to me, thanks.

Acked-by: Paul Mundt <lethal@linux-sh.org>

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD6dhm1K+teJFxZ9wRAnbhAJwKhsaOxL/PRGAzHnes3cx5OPGdKwCfVGLB
3Ey2p0IP/Df3zwgQaEfYWR8=
=iG50
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
