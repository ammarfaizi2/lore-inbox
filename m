Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261863AbTCTTeG>; Thu, 20 Mar 2003 14:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261883AbTCTTeG>; Thu, 20 Mar 2003 14:34:06 -0500
Received: from smtp-out.comcast.net ([24.153.64.115]:33789 "EHLO
	smtp.comcast.net") by vger.kernel.org with ESMTP id <S261863AbTCTTeD>;
	Thu, 20 Mar 2003 14:34:03 -0500
Date: Thu, 20 Mar 2003 14:44:48 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: Re: 2.5.65 performance
In-reply-to: <20030319173808.7fb1c204.akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Message-id: <20030320194448.GC25197@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=7gGkHNMELEOhSGF6;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.3i
References: <200303192317.22103.cb-lkml@fish.zetnet.co.uk>
 <20030319173808.7fb1c204.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2003 at 05:38:08PM -0800, Andrew Morton wrote:
> Charles Baylis <cb-lkml@fish.zetnet.co.uk> wrote:
> > I'm getting quite a lot of audio skips with this one. 2.5.64-mm8=20
was the=20
> > last one I tested and it was very good.
> > 2.5.64-mm8 works fine with pretty much any thud load I throw at it,=20
but thud=20
> > 3 is enough to cause some skips with 2.5.65-mm2. Thud 5 causes=20
serious=20
> > starvation problems to the whole desktop.
> Please test 2.5.65 base.

doing normal desktop things (gnome, jboss, mozilla, apt-get updates,
etc) i've noticed audio skips on occassion that i had not seen in
kernels previous to 2.5.65.

i'm not going to complain though, because mozilla seems to start
quicker, and my jboss start time has dropped from 1m:10s average to
40s.  very cool!
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ehowCGPRljI8080RAk7oAJwMuNjurornTS24P0K8DpesC4M6GgCggW88
Djzxx2hM9n5qgUL5oRQ/kL0=
=lkPP
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
