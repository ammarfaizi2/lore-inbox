Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbVITVBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbVITVBH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 17:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbVITVBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 17:01:06 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:40116 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S965155AbVITVBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 17:01:04 -0400
Date: Tue, 20 Sep 2005 14:00:57 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Arrr! Linux v2.6.14-rc2
Message-ID: <20050920210057.GC4982@one-eyed-alien.net>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org> <200509201025.36998.gene.heskett@verizon.net> <BAYC1-PASMTP04AB35B0A82E89B341AB0BAE950@cez.ice> <200509201657.59407.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <200509201657.59407.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

~/bin is in many people's paths in many distributions.

Matt

On Tue, Sep 20, 2005 at 04:57:59PM -0400, Gene Heskett wrote:
> On Tuesday 20 September 2005 11:20, Sean wrote:
> >On Tue, September 20, 2005 10:25 am, Gene Heskett said:
> >> Humm, what are they holding out for, more ram or more cpu?:-)
> >>
> >> FWIW, http://master.kernel.org doesn't show it either just now.
> >
> >Gene,
> >
> >While kernel.org snapshots will no doubt be working again shortly, you
> >might want to consider using git.  It reduces the amount you have to
> >download for each release a lot.
> >
> >It's really easy to grab a copy of git and use it to grab the kernel:
> >
> >mkdir kernel
> check
> >cd kernel
> check
> >wget http://kernel.org/pub/software/scm/git/git-core-0.99.7.tar.bz2
> check
> >tar -xvjf git-core-0.99.7.tar.bz2
> check
> >cd git-core-0.99.7
> check
> >make install
> check
> >cd ..
> >
> >git clone \
> >rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
> >linux
>=20
> Well, things marched right along till I got to the line for git clone
> etc.
>=20
> [root@coyote kernel]# git clone
> rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> linux
> bash: git: command not found
>=20
> Humm, back up & find it put git stuff in /root/bin  ?????
>=20
> [root@coyote kernel]# /root/bin/git clone \
> rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>  linux
> /root/bin/git-clone: line 2: git-init-db: command not found
> * git clone [-l [-s]] [-q] [-u <upload-pack>] <repo> <dir>
>=20
> So why did it put it in /root/bin?  It's there, but not in my $PATH.
> And theres no "make uninstall" to clean up the install so I might be
> able to cleanly fix the miss-fire...  Murphy rides again..
>=20
> [...]
>=20
> --=20
> Cheers, Gene
> "There are four boxes to be used in defense of liberty:
>  soap, ballot, jury, and ammo. Please use in that order."
> -Ed Howdershelt (Author)
> 99.35% setiathome rank, not too shabby for a WV hillbilly
> Yahoo.com and AOL/TW attorneys please note, additions to the above
> message by Gene Heskett are:
> Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I'm just trying to think of a way to say "up yours" without getting fired.
					-- Stef
User Friendly, 10/8/1998

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMHiJHL9iwnUZqnkRAlNYAJ4yPNEmPcBjgVwZ/Zily6V3wywRjQCgp1qg
9hTjXV9gNbUIrfDTNvCuX2k=
=MNdP
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
