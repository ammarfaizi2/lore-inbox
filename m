Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265726AbUFIJB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbUFIJB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 05:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265724AbUFIJBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 05:01:33 -0400
Received: from [213.69.232.58] ([213.69.232.58]:37898 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S265719AbUFIJBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 05:01:13 -0400
Date: Wed, 9 Jun 2004 11:03:46 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Chris Wright <chrisw@osdl.org>, Amon Ott <ao@rsbac.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dev@grsecurity.net
Subject: Re: security patches / lsm
Message-ID: <20040609090346.GG601@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Chris Wright <chrisw@osdl.org>, Amon Ott <ao@rsbac.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dev@grsecurity.net
References: <20040122191158.GA1207@schottelius.org> <20040122150937.A8720@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline
In-Reply-To: <20040122150937.A8720@osdlab.pdx.osdl.net>
X-MSMail-Priority: (u_int) -1
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry for the late answer!

For me it looks like rsbac and grsecurity could get included in 2.6.

It looks like Amon did the work necessary to intergrate it into 2.6.
(have a look at http://www.rsbac.org/).

And grsecurity also works nice with 2.6
(http://www.grsecurity.net/download.php).

Who decides whether to integrate them or not?

Nico

Chris Wright [Thu, Jan 22, 2004 at 03:09:37PM -0800]:
> * Nico Schottelius (nico-kernel@schottelius.org) wrote:
> > What about the LSM framework in the kernel and the arguments at
> >    http://www.rsbac.org/lsm.htm
> >    http://www.grsecurity.net/lsm.php
>=20
> It's been fairly functional for something as comprehenseive as SELinux,
> and supports other users as well, LIDS, DTE come to mind.  There are
> probably some improvements we could make from a few of the complaints
> from these projects, however they haven't contacted the lsm list in years.
>=20
> > Are you working together with those maintainers to enable their
> > patches?
>=20
> No.  They've both said they don't want to spend any time on such
> endeavor.  I think it would be time well spent, perhaps you'd like to
> help?
>=20
> thanks,
> -chris
> --=20
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.n=
et

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nerd-hosting.net | http://nico.schotteli.us

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQIVAwUBQMbScLOTBMvCUbrlAQKXYhAAn5stAOdgbQ6v6KYSqojOVi03uAGZg6Ic
VRpa16cu0u1ZXHTApSkAewia4qmKj60yH9qUQwVAjXIilj/vKAVWnzzOmBSN/DLn
5hIvwFZV/vVmD3wVGh+5+fWPB1vlCcdb7fCJ/OuD92H1zCqD9/cHOMeIIHK9rrgK
KpgGCoN9Suz9D6lbGvp9tcul4Nqa75dRyU9ZspbFjBcBWJBBkT3gGPMVB6yXkuid
mA0N3GOTBe9PItGyBoCxUuZRDGUzr+I7iAN+QOQJk83bfq/3s9aqkj2Tl0aRvc5u
6tMemkdFcMCSI18g+HaL3Zmwjygi/wi1GcdElD7QHKoTB9Uze13KHbCYCI0RVTu2
Wi44eh3NEjJeiaV2fp42GoSNoa5eFze3GMB1Hk28UR6jUuzMne7euXVloGZl9nb6
rYjvnAQ5UL6vPAIsAK/tEvGm0Ia1CdE7iQQlzI8cgVUAqEB5sobVVeS970UgXjjj
+sIDi2UMdMpsCBYLc8ulIa1mBPdh9xVpC1nQUKnRDpxM6woenAPTtFApDMNQdWN7
LtmT7AvFDAcoGz0DUa6N+HCC6flI4lwYVaCYzHhP44LZt8NOQ3J+fM5RQToMgGE5
lgOPIrMM+tmQWTnOsNklBz1ax3LuY2tdbVy++3fd7intkrcIXO0B03sRNxVoDLry
39Rb4RVZTbU=
=gZgC
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--
