Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271808AbRH1Qhe>; Tue, 28 Aug 2001 12:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271817AbRH1QhY>; Tue, 28 Aug 2001 12:37:24 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:23978 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S271808AbRH1QhO>; Tue, 28 Aug 2001 12:37:14 -0400
Date: Tue, 28 Aug 2001 11:36:55 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB UHCI broken again w/ visor
Message-ID: <20010828113655.U16752@draal.physics.wisc.edu>
In-Reply-To: <20010828013239.N16752@draal.physics.wisc.edu> <20010828083537.B7376@kroah.com> <20010828105330.S16752@draal.physics.wisc.edu> <20010828090126.A7544@kroah.com> <20010828110846.T16752@draal.physics.wisc.edu> <20010828091808.A7679@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4nn+A2p41ba1mxGd"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010828091808.A7679@kroah.com>; from greg@kroah.com on Tue, Aug 28, 2001 at 09:18:08AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4nn+A2p41ba1mxGd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greg KH [greg@kroah.com] wrote:
> On Tue, Aug 28, 2001 at 11:08:46AM -0500, Bob McElrath wrote:
> >=20
> > I tried the visor first, and saw this behavior.  (without even insmoding
> > the usb-storage driver)  I tried it several times, with the same
> > results.  Only this morning before sending my message did I try the
> > usb-storage to see if it was broken too.
>=20
> And usb-storage worked?
> Maybe it's a problem in your visor.  Does a soft reset of it fix it?

Yes.  *sigh*  Never again will I buy this palm/visor volatile RAM
non-rechargable B&W no memory protection piece of crap.  I wonder how
well those Agendas work...

Thanks.  Sorry for bothering you.

> > Maybe related:
> > Why would /proc/bus/usb be always empty?
>=20
> Did you mount usbdevfs there?  See http://www.linux-usb.org/FAQ.html#gs3

No.  I thought that was no longer necessary?  Anyway it works now.

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--4nn+A2p41ba1mxGd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuLyKYACgkQjwioWRGe9K3mlACgh3k7esjfNJ0m8mxw1JNaEAWA
GF8AoNfahjY+Huyro7CvVMn2rj4581cV
=SZp0
-----END PGP SIGNATURE-----

--4nn+A2p41ba1mxGd--
