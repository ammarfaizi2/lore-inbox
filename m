Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbVKILHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbVKILHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 06:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVKILHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 06:07:05 -0500
Received: from onyx.ip.pt ([195.23.92.252]:58499 "EHLO mail.isp.novis.pt")
	by vger.kernel.org with ESMTP id S1030489AbVKILHE (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 06:07:04 -0500
Subject: Re: New Linux Development Model
From: Marcos Marado <marado@isp.novis.pt>
Reply-To: marado@isp.novis.pt
To: pomac@vapor.com
Cc: Linux-kernel@vger.kernel.org, fawadlateef@gmail.com, s0348365@sms.ed.ac.uk,
       hostmaster@ed-soft.at, jerome.lacoste@gmail.com, carlsj@yahoo.com
In-Reply-To: <1131500868.2413.63.camel@localhost>
References: <1131500868.2413.63.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rLbBZiUC9H6A+xDioz3k"
Organization: Novis ISP
Date: Wed, 09 Nov 2005 11:08:16 +0000
Message-Id: <1131534496.8930.15.camel@noori.ip.pt>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rLbBZiUC9H6A+xDioz3k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-11-09 at 02:47 +0100, Ian Kumlien wrote:

> Anyways, I was also miffed that the kernel folks merged a 'ancient'
> version of ipw2200 and ieee802.11, if they had merged something more
> current everything would have worked out of the box and all the cleanups
> would have been easier to cope with. Ie, the intel ppl could release
> straight patches to the in kernel version. I dunno if they have changed
> the way their driver works now.
>=20
> Atm, the 'ancient' ieee802.11 is what breaks the ipw2200 build. So,
> basically all testing of cutting edge kernels gets very tedious due to
> the ieee802.11 package removing the offending .h file and making
> reversing -gitX and applying -gitY a real PITA.

Those are no "ancient" versions, they are the "stable" versions of
ieee80211, ipw2100 and ipw2200. ipw* folks think, and I have to agree,
that for the stable kernel (Linux tree) it makes sense to add the stable
versions of their projects.

For more about their versioning, make sure you read
http://ipw2100.sourceforge.net/#downloads .

--=20
Marcos Marado <marado@isp.novis.pt>
Novis ISP

--=-rLbBZiUC9H6A+xDioz3k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDcdigrpje80Vhea8RAp8XAJwJrl+l/pdPCvRs65IObvG28pWklgCeL/If
38TPRbABeLGbwlHJ+8jvD+M=
=1F14
-----END PGP SIGNATURE-----

--=-rLbBZiUC9H6A+xDioz3k--

