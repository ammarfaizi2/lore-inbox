Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265083AbUFGXN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUFGXN7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 19:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUFGXN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 19:13:59 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:214 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S265083AbUFGXNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 19:13:54 -0400
Date: Mon, 7 Jun 2004 19:13:48 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Duncan Sands <baldrick@free.fr>
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>
Subject: Re: [linux-usb-devel] Re: USBDEVFS_RESET deadlocks USB bus.
Message-ID: <20040607231348.GB10404@babylon.d2dc.net>
Mail-Followup-To: Duncan Sands <baldrick@free.fr>,
	linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	"David A. Desrosiers" <desrod@gnu-designs.com>
References: <20040604193911.GA3261@babylon.d2dc.net> <200406070905.41145.baldrick@free.fr> <20040607154310.GA10404@babylon.d2dc.net> <200406072111.32827.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <200406072111.32827.baldrick@free.fr>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 07, 2004 at 09:11:32PM +0200, Duncan Sands wrote:
> > With the device not sending us any more data until it receives the
> > write, and the write not getting to send until the bulk read finishes or
> > the device goes away.
> >=20
> > With the predictable annoyance this causes, of course.
>=20
> This is my fault.  I will fix it.

Great, could you send me the patch? (So I have something usable until it
gets into mainline and a kernel is released with it.)
>=20
> Ciao,
>=20
> Duncan.
>=20

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

<nonlinear> .net is microsofts perverted version of a java networked
             environment uglified for windows-specific crap
	-- nonlinear in #opengl

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxPasRFMAi+ZaeAERAmRKAJ9K+zrs6NYa37PVjBNlDCUcNG2lOQCeLeJ1
8zq+n5hgO3AYH9VHcu9dhVI=
=jBgK
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
