Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSEYQaf>; Sat, 25 May 2002 12:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314889AbSEYQae>; Sat, 25 May 2002 12:30:34 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:38098 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314835AbSEYQad>; Sat, 25 May 2002 12:30:33 -0400
Subject: Re: RTAI/RtLinux
From: Erwin Rol <erwin@muffin.org>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org, RTAI users <rtai@rtai.org>
In-Reply-To: <20020525090537.G28795@work.bitmover.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-0/bN7KDIfxqAdRrAEote"
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 May 2002 18:30:29 +0200
Message-Id: <1022344229.29849.301.camel@rawpower>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0/bN7KDIfxqAdRrAEote
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-05-25 at 18:05, Larry McVoy wrote:
> On Sat, May 25, 2002 at 11:05:32AM +0200, Erwin Rol wrote:
> > Both Linus and Larry seem to be not very interested in hard-realtime
> > Linux additions, this is OK.=20
>=20
> I'm interested in hard realtime.  I'm extremely uninterested in changes=20
> to the mainline source base in order to get them.  That's exactly why
> I like the RT/Linux approach so much, it is the least invasive to the
> kernel and - surprise - also has the best performance.
>=20

If you take a look at RTAI's history you will see that RTAI has been
using a HAL and a very small kernel patch long before RTLinux started
using that.  =20


> If people were to learn that real time and multi-user throughput are=20
> by definition mutually exclusive, I'd be a lot happier.  As it is,
> we have the SGI/Montevista crowd cramming their stuff into the kernel
> and each "little" thing makes the kernel a less pleasant place to be
> and brings it one step closer to the point when it gets abandoned=20
> like ever other OS in the history of our field.
>=20
> > Also apparently there is the idea that all RTAI developers want to
> > become rich by getting the patent out of the way and sell RTAI.=20
>=20
> So the thing I have a problem with is that Victor says that all GPL
> is fine.  You say you are all GPL.  So far, no problem.  Yet you keep
> coming back and saying there is a problem, that Linux is going to
> be out of the running as a real time platform because of the patent.
> I don't get it, why should the patent prevent Linux from being used?
> All it does is say "if you aren't making money, we aren't making money,
> if you are making money, we want a cut".  That seems OK to me, in fact,
> it seems more than OK.  It seems like someone who is trying to help
> those who are helping others and charge those who are charging others.
> That's smart, that's good.  It means that FSMlabs will be here 20 years
> from now, still supporting this stuff, whereas all the "we'll survive
> off of support" people will have long since gone under.

It is not so OK if you keep in mind that this "if you make money, we
want a part of it" is backed by a questionable patent. And if FSMLAbs
still will be there in 20 years is not something you or I can predict,
they might be bought by some large embedded firm tomorrow and the patent
with it, and as far as i understand the patent license this means it is
void when that happens.

- Erwin
=20

> --=20
> ---
> Larry McVoy            	 lm at bitmover.com           http://www.bitmover=
.com/lm=20


--=-0/bN7KDIfxqAdRrAEote
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA877wlILu3T9PlUj8RAi2qAJ9vptl13cjFhqFMOfZ5SYcIqmfoJQCeNkCU
68D0wbDRQIHK1gZev5So1vI=
=WAj2
-----END PGP SIGNATURE-----

--=-0/bN7KDIfxqAdRrAEote--
