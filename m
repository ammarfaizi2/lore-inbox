Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTELHKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 03:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTELHKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 03:10:40 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:43820 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S261968AbTELHKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 03:10:38 -0400
Subject: Re: Two RAID1 mirrors are faster than three
From: Anders Karlsson <anders@trudheim.com>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030512054130.GA1318@stingr.net>
References: <200305112212_MC3-1-386B-32BF@compuserve.com>
	 <3EBF24A8.1050100@tequila.co.jp>
	 <1052716203.4100.10.camel@tor.trudheim.com>
	 <20030512054130.GA1318@stingr.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BHBxc2eS74haA56Xez5B"
Organization: Trudheim Technology Limited
Message-Id: <1052724195.3521.5.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 12 May 2003 08:23:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BHBxc2eS74haA56Xez5B
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-05-12 at 06:41, Paul P Komkoff Jr wrote:

> Replying to Anders Karlsson:
> > downtime on it. You then quiesce the database, split off the second cop=
y
> > from the mirror, mount that as a separate filesystem and back that up
> > while the original with its first copy has already stepped back into
> > full use.
>=20
> Why do not use snapshots for this?

Snapshots was not around then. AFAIK snapshotting in the LVM is a recent
thing. I know people were doing backups by splitting off the 2nd copy in
a mirror some eight years ago.

/Anders

--=-BHBxc2eS74haA56Xez5B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+v0vjLYywqksgYBoRAvZZAJ46Np8Oq0c5hWtqt+3E/UW1xYc5XACeOXuw
QyfPpHTbvt1fhRwGaytYslo=
=Ttj4
-----END PGP SIGNATURE-----

--=-BHBxc2eS74haA56Xez5B--

