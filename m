Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268617AbRHBDh7>; Wed, 1 Aug 2001 23:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268618AbRHBDhu>; Wed, 1 Aug 2001 23:37:50 -0400
Received: from c1608841-a.fallon1.nv.home.com ([65.5.95.44]:36736 "EHLO
	tarot.aom.geek") by vger.kernel.org with ESMTP id <S268617AbRHBDhj>;
	Wed, 1 Aug 2001 23:37:39 -0400
Date: Wed, 1 Aug 2001 20:37:14 -0700
To: "Nadav Har'El" <nyh@math.technion.ac.il>
Cc: linux-kernel@vger.kernel.org, agmon@techunix.technion.ac.il
Subject: Re: SMP possible with AMD CPUs?
Message-ID: <20010801203714.B2530@ferret.dyndns.org>
In-Reply-To: <20010801230441.A19396@leeor.math.technion.ac.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <20010801230441.A19396@leeor.math.technion.ac.il>
User-Agent: Mutt/1.3.18i
From: idalton@ferret.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2001 at 11:04:41PM +0300, Nadav Har'El wrote:
[snip]
> By the way, here's a fragment from the outdated (1999) SMP-HOWTO at
> http://www.phy.duke.edu/brahma/smp-faq/smp-howto-3.html explaining why SMP
> wasn't possible in kernel 2.2 and contemporary AMD processors:
>=20
>      1.  Can I use my Cyrix/AMD/non-Intel CPU in SMP?
>=20
>          Short answer: no.
>=20
>          Long answer: Intel claims ownership to the APIC SMP scheme, and
>          unless a company licenses it from Intel they may not use it. The=
re
>          are currently no companies that have done so. (This of course can
>          change in the future) FYI - Both Cyrix and AMD support the non-
>          proprietary OpenPIC SMP standard but currently there are no
>          motherboards that use it.

Hmmm.. I seem to recall Tyan once built a board that did OpenPIC, and I
think Fry's (funky computer/consumer electronics store in Western US)
carried it for a month or two. Just rumour?

--=20
Ferret

I will be switching my email addresses from @ferret.dyndns.org to
@mail.aom.geek on or after September 1, 2001, but not until after
Debian's servers include support. 'geek' is an OpenNIC TLD. See
http://www.opennic.unrated.net for details about adding OpenNIC
support to your computer, or ask your provider to add support to
their name servers.

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7aMrpe0DNEkH06HMRAsJiAKCYZghsVxiS5bhzJAX3zsJrYRIQhQCfQ5bu
Qz9goNznUEBnYJuD2SQLe/c=
=P9Ie
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
