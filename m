Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUGBUtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUGBUtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 16:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbUGBUtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 16:49:19 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:11228 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S264919AbUGBUtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 16:49:12 -0400
Date: Fri, 2 Jul 2004 16:47:56 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Duncan Sands <baldrick@free.fr>
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>
Subject: Re: [linux-usb-devel] Re: USBDEVFS_RESET deadlocks USB bus.
Message-ID: <20040702204756.GC3447@babylon.d2dc.net>
Mail-Followup-To: Duncan Sands <baldrick@free.fr>,
	linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	"David A. Desrosiers" <desrod@gnu-designs.com>
References: <20040604193911.GA3261@babylon.d2dc.net> <200406072111.32827.baldrick@free.fr> <20040607231348.GB10404@babylon.d2dc.net> <200406082219.41213.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <200406082219.41213.baldrick@free.fr>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 08, 2004 at 10:19:40PM +0200, Duncan Sands wrote:
> > Great, could you send me the patch? (So I have something usable until it
> > gets into mainline and a kernel is released with it.)
>=20
> Sure - I just have to write it first!  It's a bit tricky to do right...

Has there been any progress on this?

I have been looking at the code in question and I am curious as to what
events we are attempting to protect against with the serialize spinlock?

Thanks.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

Stubborness will get you where self-esteem won't let you go.
  -- Queen Of Swords in the SDM.

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA5cn8RFMAi+ZaeAERAnVxAJ92V3VSLu1LH1wxwj52DHW6mAf/kQCfTUSd
CyTaJnU+13H7KQF3kWUnZKk=
=Aolc
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
