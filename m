Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUIFGGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUIFGGu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 02:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUIFGGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 02:06:50 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:16654 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S266252AbUIFGGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 02:06:47 -0400
Date: Mon, 6 Sep 2004 01:06:45 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New proposed DRM interface design
Message-ID: <20040906060645.GB4255@dbz.icequake.net>
Mail-Followup-To: DRI Devel <dri-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4139B03A.6040706@tungstengraphics.com> <20040904122057.GC26419@redhat.com> <4139C8A3.6010603@tungstengraphics.com> <9e47339104090408362a356799@mail.gmail.com> <4139FEB4.3080303@tungstengraphics.com> <9e473391040904110354ba2593@mail.gmail.com> <1094386050.1081.33.camel@localhost.localdomain> <9e47339104090508052850b649@mail.gmail.com> <1094393713.1264.7.camel@localhost.localdomain> <9e473391040905083326707923@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <9e473391040905083326707923@mail.gmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Sun, Sep 05, 2004 at 11:33:53AM -0400, Jon Smirl wrote:
>=20
> Then how am I going to merge fbdev and DRM so that we don't have two
> drivers fighting over the same hardware? I was planning on adding
> pieces of the existing fbdev code to DRM in order to implement printk
> from the kernel. It seems silly for me to rewrite 10,000 lines of code
> just to make it BSD licensed when BSD isn't even going to use the
> code.

Is the code in question attributed to a single developer or to a horde?
I only have a 2.4 kernel handy, so I can't check.

If it's a single developer or just a few, you could ask them for
permission to put it under a less restrictive license.  Petr Vandrovec
gave that permission for his components of the matroxfb code.

A lot of times the FB people don't really care about the license and
slap GPL on it just because that's the default thing to do for code
going into the Linux kernel.  It doesn't necessarily mean that they
would only grant permission for the code to be used in GPL scenarios.

--=20
Ryan Underwood, <nemesis@icequake.net>

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBO/51IonHnh+67jkRAkq3AJkBV7v4WYITsFmQ9TYsLFZkd9HGCQCfRppW
o6PrjCeMCGy+rUHmXYmKQ6Q=
=zhlW
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
