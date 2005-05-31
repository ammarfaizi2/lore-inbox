Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVEaIIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVEaIIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 04:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVEaIIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 04:08:45 -0400
Received: from downeast.net ([12.149.251.230]:43510 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261353AbVEaIIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 04:08:16 -0400
From: Patrick McFarland <pmcfarland@downeast.net>
To: Erik Slagter <erik@slagter.name>
Subject: Re: Playing with SATA NCQ
Date: Tue, 31 May 2005 04:05:36 -0400
User-Agent: KMail/1.8
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
       Michael Thonke <iogl64nx@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
References: <20050526140058.GR1419@suse.de> <429B9E68.6080205@rtr.ca> <1117525689.3108.19.camel@localhost.localdomain>
In-Reply-To: <1117525689.3108.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1182965.hnyEn4gE1E";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505310405.43869.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1182965.hnyEn4gE1E
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 31 May 2005 03:48 am, Erik Slagter wrote:
> On Mon, 2005-05-30 at 19:14 -0400, Mark Lord wrote:
> > > libata software supports PATA, but no distribution ships with libata
> > > PATA support enabled (nor should they!).
> >
> > (K)Ubuntu does, and it works very well, thanks.
>
> So that's two... Does it also show your (pata) harddisk as /dev/sda?

Ubuntu and Kubuntu are both the same distro, thankyouverymuch. I'm running=
=20
Ubuntu, and it does _not_ show pata drives as /dev/s*, only has /dev/h*.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart1182965.hnyEn4gE1E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD4DBQBCnBrX8Gvouk7G1cURAjxsAJoDZ6jQueAH/9+nDP930gvEDb8rqwCY2yBN
jHS83eOm31IgYHzgOoIIOQ==
=3lXw
-----END PGP SIGNATURE-----

--nextPart1182965.hnyEn4gE1E--
