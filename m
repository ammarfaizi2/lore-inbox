Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTLUPtF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 10:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTLUPtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 10:49:04 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:17102 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S263840AbTLUPtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 10:49:01 -0500
Date: Sun, 21 Dec 2003 16:49:54 +0100
From: Arnaud Fontaine <arnaud@andesi.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Maciej Zenczykowski <maze@cela.pl>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.23
Message-ID: <20031221154954.GA6727@scrappy>
References: <20031219224402.GA1284@scrappy> <Pine.LNX.4.44.0312200034560.15516-100000@gaia.cela.pl> <20031221075408.GA1444@scrappy> <Pine.LNX.4.58L.0312211238420.6632@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0312211238420.6632@logos.cnet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2003 at 12:39:48PM -0200, Marcelo Tosatti wrote:
> >
> > Hello,
> >
> > In fact, i have ran memtest86 for a long time and after 11 pass, i have
> > stopped it ;). It is enough ?
>=20
> It lists the regions of memory which it finds bad in the screen.
>=20
> Did you see memtest86 report it?
>=20

Sorry, i forgot to tell if i had error. So after 11 pass, i have had no=20
error. I have also test with cpuburn which printed nothing after 30
minutes.

Thanks for your help.
Arnaud Fontaine

--=20
Arnaud Fontaine <arnaud@andesi.org> - http://www.andesi.org/
GnuPG Public Key available on pgp.mit.edu
Fingerprint: D792 B8A5 A567 B001 C342 2613 BDF2 A220 5E36 19D3

--
Think twice before speaking, but don't say "think think click click".

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/5cEivfKiIF42GdMRAsaIAJ9pNZwn5NnPqHHJ3n28YJU8PDqlcACfeu21
lq/CNXKOQpdaFBy5inLxaVw=
=Eg1o
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
