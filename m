Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278437AbRJ3V6n>; Tue, 30 Oct 2001 16:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278465AbRJ3V6Y>; Tue, 30 Oct 2001 16:58:24 -0500
Received: from pscgate.progress.com ([192.77.186.1]:25771 "EHLO
	pscgate.progress.com") by vger.kernel.org with ESMTP
	id <S278472AbRJ3V6F>; Tue, 30 Oct 2001 16:58:05 -0500
Subject: Re: What is standing in the way of opening the 2.5 tree?
From: "Sujal Shah" <sshah@progress.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0110301335230.9312-100000@methlab.23.org>
In-Reply-To: <Pine.LNX.4.30.0110301335230.9312-100000@methlab.23.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-gI/7I0fTaLJXARVwh0VM"
X-Mailer: Evolution/0.16.99+cvs.2001.10.29.22.54 (Preview Release)
Date: 30 Oct 2001 16:59:25 -0500
Message-Id: <1004479166.31041.13.camel@pcsshah>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gI/7I0fTaLJXARVwh0VM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2001-10-30 at 16:39, lost wrote:
> sounds like more complication to me.  i personally think both do a great
> job at getting the job done.  sure there are problems with any source
> tree.  but adding more version numbers and turning kernels over to other
> people doesnt seem like the solution for making anything more stable.
[SNIP]

For my .02, I completely disagree with you.  I'll explain in a minute.

> On 30 Oct 2001, Thomas Hood wrote:
[SNIP]
> > Having suggested, this, I'll remind everyone that Linus
> > and Alan can do whatever the hell the like.  Which is
> > what I like about Linux.
> >

This has to be a strength, to be honest.  I'd take this further by
proposing something else.

<Flame Retardant Suit>

To be honest, I think that any x.y.z kernel is "unstable."  As we move
into a situation with an even larger installed base, I think you're
going to see a third tier become more evident: a) unstable, b) stable,
c) vendor supported.  Quite frankly, if I'm making recommendations to
customers and clients for a linux installation, I typically recommend
for them to go with a vendor supplied kernel and manage it through the
vendor.

So, while I don't appreciate "massive" VM changes in the middle of my
own testing and development :-), I always treat every new kernel
iteration as potentially "unstable" and operate on the "if it ain't
broke, don't fix it" principle on my daily use boxes (unless something
in a Linus or AC changelog looks too tempting ;-)

One can hope that the number of people reading this list plus those
keeping up with most kernel releases know what they're doing, and are a
far smaller number than those people running vendor supplied kernels and
installations.  If this isn't true today, I hope it is true at some
point in the future.

Just my opinion,

Sujal

> > --
> > Thomas Hood
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>=20
> 			************************
>  "If you want a picure of the future, imagine a boot smashing a human fac=
e"
> 						      - 1984, George Orwell
>  email: lost@23.org * website: http://www.23.org/~lost
> 			************************
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
---- Sujal Shah ---- PSC Labs (Progress Software) ----=20

Now Playing: none

--=-gI/7I0fTaLJXARVwh0VM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA73yK9rdegDpOByoARAtGeAJ97iqBK5rz763vQHwVBKZmWuV/WTQCfedvS
PImTcuIcWXzBpsspZvcA4gg=
=2s20
-----END PGP SIGNATURE-----

--=-gI/7I0fTaLJXARVwh0VM--

