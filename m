Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWERUMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWERUMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 16:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWERUMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 16:12:40 -0400
Received: from ns0.rackplans.net ([65.39.167.209]:61656 "EHLO
	mtl.rackplans.net") by vger.kernel.org with ESMTP id S1750799AbWERUMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 16:12:39 -0400
Date: Thu, 18 May 2006 16:12:24 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
X-X-Sender: gmack@mtl.rackplans.net
To: linux cbon <linuxcbon@yahoo.fr>
cc: Thierry Vignaud <tvignaud@mandriva.com>, helge.hafting@aitel.hist.no,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
In-Reply-To: <20060518193108.23173.qmail@web26601.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.64.0605181606360.20390@mtl.rackplans.net>
References: <20060518193108.23173.qmail@web26601.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658624935-899114881-1147983144=:20390"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658624935-899114881-1147983144=:20390
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE


You have also just made it easy for the rest of us to tell that you don't=
=20
actually follow linux GUI stuff very much at all.  If you had you would=20
have known that the X folks finally went too far and forced a long needed=
=20
fork of the X code so the real work is being done on X.org=20
now and these days most of the good linux distros have changed over. =20

This is *not* a recent event.

Welcome to my killfile, please find a less annoying hobby for yourself.

=09Gerhard




On Thu, 18 May 2006, linux cbon wrote:

> Date: Thu, 18 May 2006 21:31:08 +0200 (CEST)
> From: linux cbon <linuxcbon@yahoo.fr>
> To: Thierry Vignaud <tvignaud@mandriva.com>
> Cc: helge.hafting@aitel.hist.no, Valdis.Kletnieks@vt.edu,
>     linux-kernel@vger.kernel.org
> Subject: Re: replacing X Window System !
>=20
>  --- Thierry Vignaud <tvignaud@mandriva.com> a =E9crit :
>=20
> > linux cbon <linuxcbon@yahoo.fr> writes:
> >=20
> > > Why dont we have "good" 3D support in X ?
> >=20
> > no documentation how to program nvidia 3d chips?
> > or for the very latest ati chips?
> > or from the XYZ vendor?
> > ....
>=20
>=20
> What do you think about this :
>=20
> http://marc.theaimsgroup.com/?l=3Dopenbsd-misc&m=3D114738577123893&w=3D2
>=20
> But let me be clear -- the X developers are a bunch of
> shameless vendor-loving lapdogs who sure are taking
> their time at solving this > 10 year old problem!=20
> They spend way more time chasing the latest vendor
> binary loaded device driver, than they do solving this
> obvious
> problem.  (Translation: They don't want to change how
> X works, because it would break the vendor binary
> drivers from ATI and NVIDIA.  That is part of what
> happens when X developers get jobs at vendors).
>=20
> They've had 10 years, and yet every year they get more
> entrenched in the entirely insecure model of "gigantic
> process running as root, which accesses registers like
> mad".
>=20
> This problem is ENTIRELY the X group's fault!  They
> have failed us. Ten years ago they were laughing at
> Microsoft for moving their video subsystem into their
> kernel, but now the joke is on the X developers,
> because what Microsoft did solved all these driver
> security problems!
>=20
> This is 100% an X server bug.  It is not a hardware
> bug, and it is not an operating system bug.
>=20
>=20
> and this
>=20
> http://marc.theaimsgroup.com/?l=3Dopenbsd-misc&m=3D114233317926101&w=3D2
>=20
> Some of our architectures use a tricky and horrid
> thing to allow X to run.  This is due to modern PC
> video card architecture containing a large quantity of
> PURE EVIL.  To get around this evil the X developers
> have done some rather expedient things, such as
> directly accessing the cards via IO registers,
> directly from userland.  It is hard to see how they
> could have done other -- that is how much evil the
> cards contain.
>=20
>=20
> > "belong to the OS" !=3D "belong in the kernel"
> > and where do you put the boundary of the OS? most
> > people don't say
> > that the OS is only the kernel...
>=20
> Dont play with words. You know I meant graphics do
> belong to the kernel. I didnt mean graphics belong to
> gnu tools.
>=20
>=20
> > like if xorg wasn't trying to improve x11 status
> > (slowly trying to
> > isolate priviliged stuff, introducing xcb, ...)
>=20
> See above.
>=20
>=20
> > > What is your opinion ?=20
> >=20
> > stop troll^h^h^h^h^h thread?
>=20
> If I am a troll, then who are Theo or Linus ?
>=20
>=20
>=20
>=20
> Thanks
>=20
>=20
> =09
>=20
> =09
> =09=09
> _________________________________________________________________________=
__=20
> Faites de Yahoo! votre page d'accueil sur le web pour retrouver directeme=
nt vos services pr=E9f=E9r=E9s : v=E9rifiez vos nouveaux mails, lancez vos =
recherches et suivez l'actualit=E9 en temps r=E9el.=20
> Rendez-vous sur http://fr.yahoo.com/set
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
--658624935-899114881-1147983144=:20390--
