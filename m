Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUHCQju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUHCQju (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 12:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266707AbUHCQju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 12:39:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60318 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266703AbUHCQjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 12:39:45 -0400
Subject: Re: [2.6 patch] let AIC7{9,X}XX_BUILD_FIRMWARE depend on
	!PREVENT_FIRMWARE_BUILD
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Nathan Bryant <nbryant@optonline.net>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>, Sam Ravnborg <sam@ravnborg.org>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, Adrian Bunk <bunk@fs.tum.de>,
       James.Bottomley@HansenPartnership.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <410FBDAA.4070907@optonline.net>
References: <20040801185543.GB2746@fs.tum.de>
	 <20040801191118.GA7402@mars.ravnborg.org> <410FA577.4040602@adaptec.com>
	 <410FBDAA.4070907@optonline.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yhWWIc1Lk+oUiaqlBGXd"
Organization: Red Hat UK
Message-Id: <1091550985.2816.10.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 03 Aug 2004 18:36:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yhWWIc1Lk+oUiaqlBGXd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-03 at 18:30, Nathan Bryant wrote:
> Luben Tuikov wrote:
> > Hi Sam,
> >=20
> > You can forward it to Linus and I'll also integrate it
> > to the latest version of the drivers, yet to be integrated
> > to the mainline kernel.
>=20
> Luben -
>=20
> Are the latest drivers going to be available in BitKeeper format before=20
> they get merged?

I'm sure they'll be submitted in small incremental updates which can be
submitted and merged in smaller pieces to keep testability to a
maximum....=20

--=-yhWWIc1Lk+oUiaqlBGXd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBD78JxULwo51rQBIRAo4pAJ4mOfI1nl+QBJTbKnkvRoJjncdIRwCglc+M
Yc4dg59EDjcDt1rOg165ye8=
=9jn4
-----END PGP SIGNATURE-----

--=-yhWWIc1Lk+oUiaqlBGXd--

