Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUILXsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUILXsc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 19:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUILXrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 19:47:31 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:60430 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S264299AbUILXqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 19:46:25 -0400
Date: Mon, 13 Sep 2004 01:46:19 +0200
From: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.be>
To: linux-kernel@vger.kernel.org
Subject: Re: iMac G3 IPv6 issue
Message-ID: <20040912234619.GD11293@caladan.roxor.be>
Reply-To: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.be>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040912133936.GA11099@caladan.roxor.be> <1095011851.4995.54.camel@localhost.localdomain> <20040912155850.0e8fd0b5.davem@davemloft.net> <20040912231730.GC11293@caladan.roxor.be> <20040912162847.109f1629.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline
In-Reply-To: <20040912162847.109f1629.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 12, 2004 at 04:28:47PM -0700, David S. Miller wrote:
> On Mon, 13 Sep 2004 01:17:31 +0200
> Aur=E9lien G=C9R=D4ME <ag@roxor.be> wrote:
>=20
> > The board is this:
> > 0002:02:0f.0 Ethernet controller: Apple Computer Inc. UniNorth GMAC (Sun
> > GEM)
> >=20
> > So, it is Apple stuff wrapping a Sun GEM chip. The issue may come from
> > that. Anyway, I am going to dig in the source code to find out.
>=20
> It would be interesting if some other iMac users can reproduce
> this too.

If it is reproducible on this board (actually, it is built-in on
this machine), then it is really specific to this one. PowerBooks and
iBooks have also Sun GEM, and it does not occur.

> BTW, your signature is quite huge, could you trim it down
> or (alternatively) not attach it when posting to this list?
> Thanks a lot.

I am sorry, please accept my apologies if I have bothered you or
others with it. ;)

Bests.

--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBRN/LkFH2kwPhoXIRAhbmAJ46fr0CYoitN3gkzAv0PdPS3ezWOwCff3MF
JxKMVi4Pqh30GhF3B2gYk7Y=
=ZQSh
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--
