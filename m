Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbSKQFkx>; Sun, 17 Nov 2002 00:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267443AbSKQFkx>; Sun, 17 Nov 2002 00:40:53 -0500
Received: from mke-24-209-186-165.wi.rr.com ([24.209.186.165]:20470 "EHLO
	supa.0xd6.org") by vger.kernel.org with ESMTP id <S267436AbSKQFkw>;
	Sun, 17 Nov 2002 00:40:52 -0500
Date: Sat, 16 Nov 2002 23:45:49 -0600
From: "M. R. Brown" <mrbrown@0xd6.org>
To: Dmitri <dmitri@users.sourceforge.net>
Cc: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
Message-ID: <20021117054549.GC16544@0xd6.org>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay> <ar3op8$f20$1@penguin.transmeta.com> <20021115222430.GA1877@tahoe.alcove-fr> <1037400456.1565.38.camel@usb.networkfab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <1037400456.1565.38.camel@usb.networkfab.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Dmitri <dmitri@users.sourceforge.net> on Fri, Nov 15, 2002:

> On Fri, 2002-11-15 at 14:24, Stelian Pop wrote:
>=20
> > Using USB instead of the serial line or the network card would be
> > the best IMHO, because:
> >=20
> > 	* many machines have network cards, but all machines have USB
> > 	  (and it's gonna stay this way for some time)
> > 	 =20
> > 	* the USB stack seems simpler than the net stack +=20
> > 	  (eventualy) pcmcia + network card driver.
> >=20
> > Maybe the 'simpler' USB protocols (usbkbd and usbmouse) could be
> > used for this, I don't know...
>=20
> USB hardware and protocols are master-slave, meaning that you can not
> connect another computer to this one directly. What USB *device* would
> you want to see connected?
>=20

Not true.  Just grab any USB master<->master cable.  There's P2P network
drivers already in the kernel that support most brands of cables.

M. R.

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE91y0NaK6pP/GNw0URAjq1AKDNkmy/4CZRjKktJeEfF6vuuBDpKACgjS1/
ZEfOe75CVbhLm6aBnSqeE9Q=
=uO4v
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
