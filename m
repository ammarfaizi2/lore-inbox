Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUBYSoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbUBYSoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:44:37 -0500
Received: from smtp.golden.net ([199.166.210.31]:54800 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S261731AbUBYSoL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:44:11 -0500
Date: Wed, 25 Feb 2004 13:44:07 -0500
From: Paul Mundt <lethal@linux-sh.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: make help ARCH=xx fun
Message-ID: <20040225184407.GA24226@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Tom Rini <trini@kernel.crashing.org>,
	"James H. Cloos Jr." <cloos@jhcloos.com>,
	linux-kernel@vger.kernel.org
References: <m3y8qwv78e.fsf@lugabout.jhcloos.org> <20040222095021.GB2266@mars.ravnborg.org> <20040224215548.GF1052@smtp.west.cox.net> <20040225190049.GB2474@mars.ravnborg.org> <20040225180858.GW1052@smtp.west.cox.net> <20040225183038.GA24041@linux-sh.org> <20040225183934.GX1052@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20040225183934.GX1052@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2004 at 11:39:34AM -0700, Tom Rini wrote:
> > Simply just matching on *defconfig should be fine. I already changed th=
is on
> > matching defconfig-* for sh to get around matching SCCS.
>=20
> Would you mind changing to foo_defconfig from defconfig-foo ?  Then you
> get the make foo_defconfig rule for free.
>=20
Yes, I plan on doing this in the next sh update. I did the defconfig-foo st=
uff
before foo_defconfig existed, that's the only reason it's different at this
point..


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAPOz31K+teJFxZ9wRAgMvAJ9sVqIgOCNohyVa/KDUN637KMdIrgCfRa+k
1yjMactM4zkBDJ3XALlI2pU=
=uW5l
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
