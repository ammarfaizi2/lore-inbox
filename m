Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266850AbUHTMyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUHTMyX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 08:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266846AbUHTMyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 08:54:23 -0400
Received: from cantor.suse.de ([195.135.220.2]:491 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266839AbUHTMyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 08:54:21 -0400
Date: Fri, 20 Aug 2004 14:54:16 +0200
From: Kurt Garloff <garloff@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, Chris Mason <mason@suse.com>,
       Olaf Kirch <okir@suse.de>, antisthenes@inbox.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bio_uncopy_user mem leak
Message-ID: <20040820125416.GB12396@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
	Chris Mason <mason@suse.com>, Olaf Kirch <okir@suse.de>,
	antisthenes@inbox.ru, linux-kernel@vger.kernel.org
References: <1092909598.8364.5.camel@localhost> <412489E5.7000806@kolivas.org> <1092923494.12138.1667.camel@watt.suse.com> <20040819195521.GC12363@tpkurt.garloff.de> <41256DC9.7070500@kolivas.org> <20040819233155.68c1411e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
In-Reply-To: <20040819233155.68c1411e.akpm@osdl.org>
X-Operating-System: Linux 2.6.8-1-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Aug 19, 2004 at 11:31:55PM -0700, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> >
> >  Andrew did you threaten to make a 2.6.8.2 since 2.6.8{,.1} cannot safe=
ly=20
> >  burn an audio cd?
>=20
> Uh, I guess that depends on how rested Linus feels when he returns.  I
> think there's a fairly significant networking fix too.  As I said: we'll =
see.

I must have overlooked the network thing. But in internal testing we do=20
see problems with 2.6.8, which seem to be related to networking and/or=20
NFS.

Care to work out?

Regards,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBJfR4xmLh6hyYd04RArsbAKDWMSdgRkXLItR2fVwnTHxLkuORdQCgqp2r
6tMYKmffJuG9dpbqBFmJCV0=
=6/24
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
