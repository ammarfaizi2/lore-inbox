Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWBGXO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWBGXO3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWBGXO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:14:28 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:38878 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1030240AbWBGXO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:14:28 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 8 Feb 2006 09:11:02 +1000
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, Jim Crilly <jim@why.dont.jablowme.net>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602071940.53843.nigel@suspend2.net> <20060207230245.GD2753@elf.ucw.cz>
In-Reply-To: <20060207230245.GD2753@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart87652145.B6CoSVqagO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602080911.08090.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart87652145.B6CoSVqagO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello.

On Wednesday 08 February 2006 09:02, Pavel Machek wrote:
> > > > Personally I agree with you on suspend2, I think this is something =
that
> > > > needed to Just Work yesterday, and every day it doesn't work we are
> > > > losing users... but who am I to talk, I'm not the one who will have=
 to
> > > > maintain it.
> > >=20
> > > It does just work in mainline now. If it does not please open bug
> > > account at bugzilla.kernel.org.
> > >=20
> > > If mainline swsusp is too slow for you, install uswsusp. If it is
> > > still too slow for you, mail me a patch adding LZW to userland code
> > > (should be easy).
> >=20
> > <horrified rebuke>
> >=20
> > Pavel!
> >=20
> > Responses like this are precisely why you're not the most popular kerne=
l=20
> > maintainer. Telling people to use beta (alpha?) code or fix it
>=20
> I do not *want* to be the most popular maintainer. That is your place ;-).
>=20
> > themselves=20
> > (and then have their patches rejected by you) is no way to maintain a p=
art=20
> > of the kernel. Stop being a liability instead of an asset!
>=20
> Ugh?
>=20
> Lee is a programmer. He wants faster swsusp, and improving uswsusp is
> currently best way to get that. It may be alpha/beta quality, but
> someone has to start testing, and Lee should be good for that (played
> with realtime kernels etc...). Actually it is in good enough state
> that I'd like non-programmers to test it, too.

Ok. So Lee might be ok to test uswsusp. But this is your approach
regardless of who is emailing you. You consistently tell people to fix
problems themselves and send you a patch. That's not what a maintainer
should do. They're supposed to maintain, not get other people to do the
work. They're supposed to be helpful, not a source of anxiety. You might be
the maintainer of swsusp in name, but you're not in practice. Please, lift
your game!
=20
Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart87652145.B6CoSVqagO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6SkMN0y+n1M3mo0RAijXAJ45NUrynA0w7TArPTk3RqbrJ55AyACcDAP4
7dsd0mPAVTACkfAHy53NM00=
=SzSe
-----END PGP SIGNATURE-----

--nextPart87652145.B6CoSVqagO--
