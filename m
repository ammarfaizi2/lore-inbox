Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVACMCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVACMCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 07:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVACMCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 07:02:13 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:14809 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261429AbVACMCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 07:02:09 -0500
Date: Mon, 3 Jan 2005 13:01:40 +0100
From: Martin Waitz <tali@admingilde.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Jesper Juhl <juhl-lkml@dif.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] whitespace cleanups in fs/cifs/file.c
Message-ID: <20050103120140.GX31835@admingilde.org>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Jesper Juhl <juhl-lkml@dif.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>,
	samba-technical <samba-technical@lists.samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost> <1104104286.16545.7.camel@localhost.localdomain> <Pine.LNX.4.61.0412290048150.3528@dragon.hygekrogen.localhost> <20041229015716.GB29323@wohnheim.fh-wedel.de> <20041229095129.GI24603@wiggy.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KC+fneiph5CALyUl"
Content-Disposition: inline
In-Reply-To: <20041229095129.GI24603@wiggy.net>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KC+fneiph5CALyUl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Dec 29, 2004 at 10:51:30AM +0100, Wichert Akkerman wrote:
> If they are on a single line grep will find the return type as well
> which is extremely convenient.

If they are on separate lines, grep ^function won't return every single use.
And -B 1 will show the return type as well.

But well, it's personal taste.

--=20
Martin Waitz

--KC+fneiph5CALyUl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFB2TQkj/Eaxd/oD7IRAjLzAJ4qgMsBfBgVtPfEN5pMENSuHjc7JgCdFRSB
6A1Boe4bnHtxZUJR70dnt6s=
=5pXM
-----END PGP SIGNATURE-----

--KC+fneiph5CALyUl--
