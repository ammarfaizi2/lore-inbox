Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265530AbUGMQ6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbUGMQ6q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 12:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265510AbUGMQ6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 12:58:46 -0400
Received: from alhambra.mulix.org ([192.117.103.203]:7657 "EHLO
	granada.merseine.nu") by vger.kernel.org with ESMTP id S265530AbUGMQ6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 12:58:43 -0400
Date: Tue, 13 Jul 2004 19:58:24 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Ricky Beam <jfbeam@bluetronic.net>,
       "Eric D. Mudama" <edmudama@bounceswoosh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org
Subject: Re: SATA disk device naming ?
Message-ID: <20040713165824.GD11450@granada.merseine.nu>
References: <Pine.GSO.4.33.0407131221000.25702-100000@sweetums.bluetronic.net> <Pine.LNX.4.44.0407131812340.30340-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407131812340.30340-100000@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 13, 2004 at 06:15:04PM +0100, Tigran Aivazian wrote:

> I assumed that "LABEL=3D/" thing is a RedHat-specific kernel's feature bu=
t=20
> never bothered to check.

This is a common misconception. The LABEL magic is actually done by
nash, which is part of RH's (and others) mkinitrd package. This also
means that LABEL relies on having a working initrd.=20

I have a short writeup of my understanding of how this works at
http://www.livejournal.com/users/mulix/84768.html. All AFAIUI,
corrections welcome.=20

Cheers,=20
Muli=20


--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA9BSwKRs727/VN8sRAnwBAJ0QrwiAeqzg/SYENU8zpvi26jYFvgCePqBp
RnWPh77bohLpPZ0aqshCs2E=
=7Slm
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
