Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSEYJQm>; Sat, 25 May 2002 05:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSEYJQm>; Sat, 25 May 2002 05:16:42 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:53219 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314396AbSEYJQV>; Sat, 25 May 2002 05:16:21 -0400
Subject: Re: RTAI/RtLinux
From: Erwin Rol <erwin@muffin.org>
To: Erwin Rol <erwin@muffin.org>
Cc: linux-kernel@vger.kernel.org, RTAI users <rtai@rtai.org>
In-Reply-To: <1022317532.15111.155.camel@rawpower>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-TFlMKOvjVIPBtwy4ym2Z"
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 May 2002 11:16:02 +0200
Message-Id: <1022318162.15111.160.camel@rawpower>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TFlMKOvjVIPBtwy4ym2Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-05-25 at 11:05, Erwin Rol wrote:
> Normally I am not subscribed to the kernel list, but after a msg from
> Karim that there was a "fight" going on about RTAI I read the archives
> and decided that it was important enough to join the discussion.
>=20
> Both Linus and Larry seem to be not very interested in hard-realtime
> Linux additions, this is OK. I mean everybody has his interests and with
> so many Linux users and developers you can't all focus on the same
> thing.
>=20
> But we (RTAI developers, which include Karim and myself) have decided to
> focus on hard-realtime extensions to Linux. And it is than always very
> motivating to hear nobody gives a f*ck about your work or problems,
> because "hey, you don't have a business model that makes sense anyway"
>=20
> For example, first there is said that there is no userspace
> hard-realtime, than Karim corrects that, than there is said that a
> userspace program that uses mlockall is actually a module: with other
> words be quiet and go sit in the corner.
> This seems the same as what happened with  FSMLabs, first they explain
> why userspace hard-realtime is crap, and now they have implemented it
> them self and explain how good it is.=20
>=20
> We have had several discussions with FSMLabs about userspace
> hard-realtime and asked for comments on for example the following
> situation.
>=20
> -
> When i write a RTAI module, that changes the sched_setparam in such a
> way that SCHED_FIFO and SCHED_RR are now hardrealtime. Than a binary
> program that runs on a computer with the RTAI kernel-module loaded
> violates the patent, and on a computer that doesn't have it loaded it
> doesn't violate the patent.=20
> -
> needless to say we never even got a reply on questions like these. When
> you have to believe FSMLabbs, you are not allowed to use non-GPL
> software on a system that has a RTAI module loaded, according to Eben Mo

Some how a small piece of the mail is missing here.=20

... according to Eben Moglen this can't be correct.=20

- Erwin


>=20
> There was also asked about the possibility (and even some person on the
> RTAI list started such a project) to have a *BSD version of RTAI, well
> the answer is simply NO. since *BSD will not accept GPL kernel code, and
> the RTLinux patent doesn't allow no GPL implementations there will be no
> free *BSD with this type of hard-realtime. Of course you can buy the
> FSMLab version, but than you can just as well buy a true RTOS, like
> VxWorks.
>=20
> Also apparently there is the idea that all RTAI developers want to
> become rich by getting the patent out of the way and sell RTAI. I know
> you all know this is simply not true, like most Linux hacker we spend a
> large part of our free time to give the real-time community a usable
> piece of software where they normally have to pay for.=20
> So please don't stamp us as some money sucking bastards that shouldn't
> be allowed to use Linux in the first place.
>=20
> I just hope the linux developers are smart enough to not accept the
> RTLinux into the main kernel, cause someday someone might come up with
> the idea to write something that allows to have userspace programs to be
> hard-realtime, and than you have to stop allowing non GPL userspace
> programs, like for example GLIB( which is LGPL).=20
>=20
> - Erwin Rol , RTAI Developer
>=20
>=20
>=20
>=20
>=20


--=-TFlMKOvjVIPBtwy4ym2Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA871ZSILu3T9PlUj8RAlKdAJ9NvpSspnjwa8WT8UxcPnP1Lj/AqgCgtCDc
rc1dLjZuIfjNDXENMiY5ngA=
=TEx1
-----END PGP SIGNATURE-----

--=-TFlMKOvjVIPBtwy4ym2Z--
