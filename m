Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262784AbTCVOuf>; Sat, 22 Mar 2003 09:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262785AbTCVOuf>; Sat, 22 Mar 2003 09:50:35 -0500
Received: from B56ba.pppool.de ([213.7.86.186]:45264 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S262784AbTCVOud>; Sat, 22 Mar 2003 09:50:33 -0500
Subject: Re: Release of 2.4.21
From: Daniel Egger <degger@fhm.edu>
To: John Bradford <john@grabjohn.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200303220827.h2M8R4YW000282@81-2-122-30.bradfords.org.uk>
References: <200303220827.h2M8R4YW000282@81-2-122-30.bradfords.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1FxlajAyiZK62vj3l1tu"
Organization: 
Message-Id: <1048344868.15199.73.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 22 Mar 2003 15:54:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1FxlajAyiZK62vj3l1tu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sam, 2003-03-22 um 09.27 schrieb John Bradford:

> So why did you trim the part of my quote that said that production
> systems should always be backed up anyway?

You consider normal desktop systems "production system"? Interesting...
The best on can hope for a desktop system is a regular becakup of
important work files to CD-R; we're more talking about a sector-wise
harddisk backup here which is not even common for server systems (no,
I'm not talking about RAID here) let alone Joe users system.=20

For instance I do have a RAID and a regular rsync backup on my
production system here. That's still not enough for trying development
kernels on real data which might fry the filesystem because it'd be
fried on the mirrored harddrives at the same time and the rsynced copy
is not enough to fully recover the system.

> It's not exactly much work to put a different disk in a machine.

Yeah, though not something Joe user could do. And honestly this is not
something someone would do "just for fun", because it's still a lot of
trouble for a minor intent.

> With a notebook, it might be 30-45 minutes work dismantling it,

You certainly must be kidding. Dismantling my PowerBook is hardly
possible at all without killing it and the harddrive is quite hard to
replace. This is more like a 2h work and something I'd rather do once
in its lifetime for the sake of a bigger harddrive instead of trying
a development kernel.

>  but on a typical desktop, about 2 minutes, and on a rackmount server, pr=
obably
> 60 seconds.

Right. Let's see. It took me about 20 minutes to swap the CPU in this
"desktop" machine here, 15 minutes of that were used to dismantle the
system, pull the mounted motherboard (with all PCI cards in the slots,
my case luckily allows for that) and reassemble those parts. This action
is necessary to get to the right hand side screws which fasten the
harddrive.

It's not even realistic to assume that simply opening the case, and
reconnecting a loosely hanging around harddrive will just take 2
minutes.

--=20
Servus,
       Daniel

--=-1FxlajAyiZK62vj3l1tu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+fHkkchlzsq9KoIYRAvsLAJ9BUYMAaj40Yqfg4lZz3y7cjDl+NACeMItQ
k9o3a+Z/I4oq0iaG22MSrew=
=FcqQ
-----END PGP SIGNATURE-----

--=-1FxlajAyiZK62vj3l1tu--

