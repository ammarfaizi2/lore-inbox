Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbTLSWnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 17:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTLSWnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 17:43:16 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:997 "EHLO postfix3-1.free.fr")
	by vger.kernel.org with ESMTP id S263662AbTLSWnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 17:43:14 -0500
Date: Fri, 19 Dec 2003 23:44:02 +0100
From: Arnaud Fontaine <arnaud@andesi.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.23
Message-ID: <20031219224402.GA1284@scrappy>
References: <20031218085621.GA8283@scrappy> <Pine.LNX.4.44.0312180946550.4547-100000@logos.cnet> <20031218130601.GA11274@scrappy> <20031218190809.GB6438@matchmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20031218190809.GB6438@matchmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2003 at 11:08:09AM -0800, Mike Fedyk wrote:
> > On Thu, Dec 18, 2003 at 09:47:42AM -0200, Marcelo Tosatti wrote:
> > >=20
> > > Andrew,=20
> > >=20
> > > This is likely to be bad memory.
> > >=20
> > > Can you try memtest86 on the box ?=20
> >=20
> > Before install Debian GNU/Linux Woody on this box, i have ran memtest
> > with a bootable media and have no error after 13 pass. But i have added
> > memory after. It comes from an other PC running perfectly with this. So
> > i think it could come from the memory but if you want i can launch
> > memtest again this night ;).
>=20
> There is a difference between memtest and memtest86.  memtest86 tests all=
 of
> your memory, and memtest can only test the userspace memory it can lock.

Hello,

So i have just tested to run memtest86 on my box and i have had no error
with this. I have also tested cpuburn without any result. Have you some
others ideas ?

Thanks for your help.
Arnaud Fontaine

--=20
Arnaud Fontaine <arnaud@andesi.org> - http://www.andesi.org/
GnuPG Public Key available on pgp.mit.edu
Fingerprint: D792 B8A5 A567 B001 C342 2613 BDF2 A220 5E36 19D3

--
=2E.. A solemn, unsmiling, sanctimonious old iceberg who looked like he
was waiting for a vacancy in the Trinity.
		-- Mark Twain

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/438yvfKiIF42GdMRAr1uAJ94OfAVzpzMcDzqiPfvm+nt3vgO8QCglOry
5VojpzTm1IZSEdX8ITQ2qzw=
=IMfw
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
