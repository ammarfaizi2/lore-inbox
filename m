Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbUAPTBs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbUAPTBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:01:48 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:46991 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265258AbUAPTBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:01:46 -0500
Subject: Re: [PATCH] add sysfs class support for vc devices [10/10]
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20040115201358.75ffc660.akpm@osdl.org>
References: <20040115204048.GA22199@kroah.com>
	 <20040115204111.GB22199@kroah.com> <20040115204125.GC22199@kroah.com>
	 <20040115204138.GD22199@kroah.com> <20040115204153.GE22199@kroah.com>
	 <20040115204209.GF22199@kroah.com> <20040115204241.GG22199@kroah.com>
	 <20040115204259.GH22199@kroah.com> <20040115204311.GI22199@kroah.com>
	 <20040115204329.GJ22199@kroah.com> <20040115204356.GK22199@kroah.com>
	 <20040115201358.75ffc660.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KLoD51gdwzZh/EdeiQWZ"
Message-Id: <1074279897.23742.754.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 16 Jan 2004 21:04:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KLoD51gdwzZh/EdeiQWZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-16 at 06:13, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > This patch add sysfs support for vc char devices.
> >=20
> >  Note, Andrew Morton has reported some very strange oopses with this
> >  patch, that I can not reproduce at all.  If anyone else also has
> >  problems with this patch, please let me know.
>=20
> It seems to have magically healed itself :(
>=20
> Several people were hitting it.  We shall see.

Might it be due to the vt-locking-fixes patch?


--=20
Martin Schlemmer

--=-KLoD51gdwzZh/EdeiQWZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBACDXZqburzKaJYLYRAi4uAJ9Jyj7Wc0e3jk7WuqyoLuw8ctsingCfU9Qo
btj2AqAKv5gnyxeOkYB4yAI=
=O51n
-----END PGP SIGNATURE-----

--=-KLoD51gdwzZh/EdeiQWZ--

