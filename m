Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbTFMJtg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 05:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbTFMJtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 05:49:36 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:2288 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265295AbTFMJtf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 05:49:35 -0400
Subject: Re: Pentium M (Centrino) cpufreq device driver (please test me)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Anders Karlsson <anders@trudheim.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1055497273.5162.49.camel@dhcp22.swansea.linux.org.uk>
References: <1055371846.4071.52.camel@localhost.localdomain>
	 <1055406614.2551.6.camel@tor.trudheim.com> <20030612145335.GA14795@suse.de>
	 <1055497273.5162.49.camel@dhcp22.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-x0ZP8QPOaJaIQOMA10P/"
Organization: Red Hat, Inc.
Message-Id: <1055498590.7088.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 13 Jun 2003 12:03:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-x0ZP8QPOaJaIQOMA10P/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-06-13 at 11:41, Alan Cox wrote:
> On Iau, 2003-06-12 at 15:53, Dave Jones wrote:
> > cpufreq inclusion into 2.4 probably won't happen. There is an older
> > patch in -ac, but has no-one is updating the 2.4 cpufreq branch any
> > more, it's lacking quite a lot of fixes that have gone into 2.5.
>=20
> Its basically up to someone who uses the 2.4 one and wants to backport
> the updates for athlon/centrino etc. Candidates can apply online 8)

I sent you a patch before to do this.......

--=-x0ZP8QPOaJaIQOMA10P/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+6aFexULwo51rQBIRAitdAJ0RJhxS+lU1xwwcnkf2qQxrWLwy7QCfauXU
RWl2r+f7FBiir+FlqqwizX4=
=puw7
-----END PGP SIGNATURE-----

--=-x0ZP8QPOaJaIQOMA10P/--
