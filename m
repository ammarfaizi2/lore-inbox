Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVDKGg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVDKGg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 02:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVDKGg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 02:36:28 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:17793 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261704AbVDKGgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 02:36:21 -0400
Date: Mon, 11 Apr 2005 08:36:03 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Marcin Dalecki <martin@dalecki.de>
Cc: Miles Bader <miles@gnu.org>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050411063603.GA21708@vagabond>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050407074407.GA25194@vagabond> <f74102c2ddfe02b2d98d28e1a25a0634@dalecki.de> <buo4qee6obk.fsf@mctpc71.ucom.lsi.nec.co.jp> <de0dee2e0b49a66479c2c885c0ee50aa@dalecki.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <de0dee2e0b49a66479c2c885c0ee50aa@dalecki.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2005 at 04:56:06 +0200, Marcin Dalecki wrote:
>=20
> On 2005-04-11, at 04:26, Miles Bader wrote:
>=20
> >Marcin Dalecki <martin@dalecki.de> writes:
> >>Better don't waste your time with looking at Arch. Stick with patches
> >>you maintain by hand combined with some scripts containing a list of
> >>apply commands and you should be still more productive then when using
> >>Arch.
> >
> >Arch has its problems, but please lay off the uninformed flamebait (the
> >"issues" you complain about are so utterly minor as to be laughable).
>=20
> I wish you a lot of laughter after replying to an already 3 days old=20
> message,
> which was my final on Arch.

Marcin Dalecki <martin@dalecki.de> complained:
> Arch isn't a sound example of software design. Quite contrary to the=20
> random notes posted by it's author the following issues did strike me=20
> the time I did evaluate it:
> [...]

I didn't comment on this first time, but I see I should have. *NONE* of
the issues you complained about were issues of *DESIGN*. They were all
issues of *ENGINEERING*. *ENGINEERING* issues can be fixed. One of the
issues does not even exist any longer (the diff/patch one -- it now
checks they are the right ones -- and in all other respects it is
*exactly* the same as depending on a library)

But what really matters here is the concept. Arch has a simple concept,
that works well. Others have different concepts, that work well or
almost well too (Darcs, Monotone).

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCWhrTRel1vVwhjGURAuGDAKCLOx+PaXOm5QSjPdFS7YEIDC3KEQCgpGSb
TefGUTnMb3zLmq66isj/6co=
=UUNS
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
