Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUI0Q0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUI0Q0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUI0Q0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:26:40 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:22414 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S266249AbUI0Q0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:26:25 -0400
Subject: Re: [gamin] [RFC][PATCH] inotify 0.10.0 [u]
From: "Martin Schlemmer [c]" <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org, rml@ximian.com,
       viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       iggy@gentoo.org
In-Reply-To: <1096250524.18505.2.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ftKIBhWPsmJ7bO9NAtL7"
Date: Mon, 27 Sep 2004 18:25:32 +0200
Message-Id: <1096302332.11535.63.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ftKIBhWPsmJ7bO9NAtL7
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


--=-ftKIBhWPsmJ7bO9NAtL7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBWD77qburzKaJYLYRAsKoAJ0RX91/dP94gpSzHa4BgMxsQUjqwACdEqyU
sWEqQtFK6Zj4Y6O3ZEgI0w0=
=coZI
-----END PGP SIGNATURE-----

--=-ftKIBhWPsmJ7bO9NAtL7--

