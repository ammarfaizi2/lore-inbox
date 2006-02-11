Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWBKWRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWBKWRA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 17:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWBKWRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 17:17:00 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:17054 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S1750759AbWBKWQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 17:16:59 -0500
Date: Sat, 11 Feb 2006 23:16:48 +0100
From: Nico Golde <nico@ngolde.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Getting cpu frequency
Message-ID: <20060211221648.GB12602@ngolde.de>
References: <20060211204733.GA7813@ngolde.de> <20060211213748.GD8337@redhat.com> <20060211214207.GB19045@ngolde.de> <20060211221309.GE8337@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20060211221309.GE8337@redhat.com>
X-Editor: VIM - Vi IMproved 6.4 (2005 Oct 15, compiled Jan 15 2006 19:02:40)
X-Mailer: Mutt-ng http://www.muttng.org
X-Operating-System: Debian GNU/Linux sid
X-My-Homepage: http://www.ngolde.de
User-Agent: mutt-ng/devel-r556 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Dave Jones <davej@redhat.com> [2006-02-11 23:15]:
> On Sat, Feb 11, 2006 at 10:42:07PM +0100, Nico Golde wrote:
>  > Hallo Dave,
>  >=20
>  > * Dave Jones <davej@redhat.com> [2006-02-11 22:38]:
>  > > On Sat, Feb 11, 2006 at 09:47:34PM +0100, Nico Golde wrote:
>  > >  > Hi,
>  > >  > at the moment I try to get the current cpu frequency
>  > >  > P.S. Please CC me, I am not subsribed, thanks
>  > >=20
>  > > Are you trying to do this from a userspace program ?
>  > > If so, this isn't going to work.
>  >=20
>  > Yes I am.
>=20
> Read it from sysfs or /proc/cpuinfo.

Thats exactly what I dont wanted to do and thought its=20
possible without reading a file. So it seems to be not,=20
thank you will use sysfs to get the information.
Regards Nico

--=20
Nico Golde - JAB: nion@jabber.ccc.de | GPG: 0x73647CFF
http://www.ngolde.de | http://www.muttng.org | http://grml.org
Forget about that mouse with 3/4/5 buttons -
gimme a keyboard with 103/104/105 keys!

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD7mJQHYflSXNkfP8RAn+MAJ9rQKT8rby/OuOIOr0JAMvp8oDcWgCgqxDQ
ydstX50ugiD9rZYLhb6cS0w=
=b9jf
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
