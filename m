Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUI0QWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUI0QWF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUI0QWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:22:05 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:409 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S265971AbUI0QWA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:22:00 -0400
Subject: Re: [gamin] [RFC][PATCH] inotify 0.10.0 [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org, rml@ximian.com,
       viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       iggy@gentoo.org
In-Reply-To: <1096250524.18505.2.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-K7GOYdbSkI2m+MBJcqXt"
Date: Mon, 27 Sep 2004 18:21:00 +0200
Message-Id: <1096302060.11535.54.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-K7GOYdbSkI2m+MBJcqXt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-09-26 at 22:02 -0400, John McCutchan wrote:

Hi,

> -cleaned up the events (me)
> 	- remove IN_CREATE, IN_DELETED, IN_RENAME and IN_MOVE
> 	- added IN_CREATE_SUBDIR, IN_CREATE_FILE, IN_DELETE_SUBDIR,
> 	  IN_DELETE_FILE, IN_DELETE_SELF, IN_MOVED_FROM and IN_MOVED_TO

I have just looked quickly at the inotify backend this weekend, so not
really clued up yet, so excuse the stupid question:  Does this mean
inotify is now up to par with dnotify/poll feature wise?  Or should we
still look at getting inotify backend to use poll?


--=20
Martin Schlemmer

--=-K7GOYdbSkI2m+MBJcqXt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBWD3sqburzKaJYLYRAu8/AJ9U0xCeWig1ggys1qQwW0m0CU4qUwCfZeS+
30PNQHdl21VPRSfC5nCXj/4=
=WAHE
-----END PGP SIGNATURE-----

--=-K7GOYdbSkI2m+MBJcqXt--

