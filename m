Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUFEHDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUFEHDA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 03:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUFEHDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 03:03:00 -0400
Received: from [196.25.168.8] ([196.25.168.8]:37517 "EHLO lbsd.net")
	by vger.kernel.org with ESMTP id S264524AbUFEHC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 03:02:57 -0400
Date: Sat, 5 Jun 2004 09:02:39 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: webvenza@libero.it, linux-kernel@vger.kernel.org
Subject: Re: [HANG] SIS900 + P4 Hyperthread
Message-ID: <20040605070239.GM14247@lbsd.net>
References: <40C0E37C.4030905@lbsd.net> <20040604214721.GC22679@picchio.gall.it> <20040605005033.A26051@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NZtAI5QFBF0GmLcW"
Content-Disposition: inline
In-Reply-To: <20040605005033.A26051@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NZtAI5QFBF0GmLcW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 05, 2004 at 12:50:33AM +0200, Francois Romieu wrote:
> Daniele Venzano <webvenza@libero.it> :
> [...]
> > > When using 2.4.x all is ok with hyperthreading enabled.
> > This is important. The driver has some differences between the two
> > versions, but none of them is releated to SMP. I'll chack again, but if
> > someone with some more smp-karma than me wants to join, he is most
> > welcome...
>=20
> I have not checked the latest version of the driver but 2.6.7-rc2 seems
> to give a Rx ring descriptor to the asic just before the Rx buffer
> address is set. One would expect a different crash though.
>=20
> --
> Ueimor

Any quick fix i can hack?

-Nigel


--NZtAI5QFBF0GmLcW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAwXAPKoUGSidwLE4RAi69AJ9jlTv2+COFabXb+pj5RADP5X7cQACcCJm0
+y4aHBqKynMR31/YVCB+W1k=
=mha5
-----END PGP SIGNATURE-----

--NZtAI5QFBF0GmLcW--
