Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293215AbSB1Wfx>; Thu, 28 Feb 2002 17:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310178AbSB1Wdr>; Thu, 28 Feb 2002 17:33:47 -0500
Received: from panacea.canonical.org ([209.115.72.61]:3076 "HELO
	panacea.canonical.org") by vger.kernel.org with SMTP
	id <S310203AbSB1W37>; Thu, 28 Feb 2002 17:29:59 -0500
Date: Thu, 28 Feb 2002 17:29:58 -0500
From: Jason Cook <jasonc@reinit.org>
To: Peter Hutnick <peter@fpcc.net>
Cc: John Jasen <jjasen1@umbc.edu>, linux-kernel@vger.kernel.org
Subject: Re: wvlan_cs in limbo?
Message-ID: <20020228172958.A10716@panacea.canonical.org>
Mail-Followup-To: Peter Hutnick <peter@fpcc.net>,
	John Jasen <jjasen1@umbc.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.31L.02.0202252302120.5307822-100000@irix2.gl.umbc.edu> <200202260533.WAA30955@perth.fpcc.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202260533.WAA30955@perth.fpcc.net>; from peter@fpcc.net on Mon, Feb 25, 2002 at 10:31:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Peter Hutnick (peter@fpcc.net) wrote:
> On Monday 25 February 2002 09:03 pm, John Jasen wrote:
> > On Mon, 25 Feb 2002, Peter Hutnick wrote:
> > > I can't figure out which end is up with wvlan_cs.  Not in the kernel =
yet
> > > . . . but pcmcia-cs package is not for use with 2.4.
> > >
> > > Could someone give me a hint?
> >
> > I don't understand why you think that pcmcia-cs is not for use in 2.4. I
> > use it on my laptop, which was just recently moved to 2.4.17.
>=20

=46rom what I understand the wvlan_cs driver is being phased out and
replaced by the much improved orinoco_cs driver.

--=20
Jason Cook                 |  GnuPG Fingerprint: D531 F4F4 BDBF 41D1 514D
GNU/Linux Engineering Lead |                     F930 FD03 262E 5120 BEDD
evolServ Technology        |  Home page: http://reinit.org

Whip me.  Beat me.  Make me maintain AIX.

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjx+r2YACgkQ/QMmLlEgvt24jACfUtwftxt2jTiKxVmZYR3y1kgt
grUAniv3XZj1B24vmGSLtcsQJeEWwMR/
=J1em
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
