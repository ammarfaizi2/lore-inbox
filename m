Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264371AbUG2Lsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUG2Lsa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 07:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUG2Lsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 07:48:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:981 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264371AbUG2Ls0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 07:48:26 -0400
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL and XFS on
	4KSTACKS=n
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Nathan Scott <nathans@sgi.com>,
       "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Steve Lord <lord@xfs.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com,
       Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040729114219.GN2349@fs.tum.de>
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at>
	 <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu>
	 <20040720195012.GN14733@fs.tum.de> <20040729060900.GA1946@frodo>
	 <20040729114219.GN2349@fs.tum.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cM5iABXiyfHOS7eUaigT"
Organization: Red Hat UK
Message-Id: <1091101612.2792.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 13:46:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cM5iABXiyfHOS7eUaigT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > > Mark this combination as BROKEN until XFS is fixed.
> >=20
> > This part is not useful.  We want to hear about problems
> > that people hit with 4K stacks so we can try to address
> > them, and it mostly works as is.
>=20
> 2.6 is a stable kernel series used in production environments.
>=20
> Regarding Linus' tree, it's IMHO the best solution to work around it=20
> this way until all issues are sorted out.
>=20
> Feel free to revert it in -mm later, since there are many brave souls =20
> running -mm you'll still get to hear about problems.

can you then also mark XFS broken in 2.4 entirely?
2.4 has a nett stack of also 4Kb...=20

--=-cM5iABXiyfHOS7eUaigT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBCOOrxULwo51rQBIRAhc4AJ9Jp+/ePsNufUxqo5ymgIAu1yufegCfRuLY
jLyLMBfI7nJcjMBZQf4ivaY=
=eahr
-----END PGP SIGNATURE-----

--=-cM5iABXiyfHOS7eUaigT--

