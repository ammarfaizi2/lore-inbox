Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261650AbSJFPml>; Sun, 6 Oct 2002 11:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261652AbSJFPml>; Sun, 6 Oct 2002 11:42:41 -0400
Received: from grendel.firewall.com ([66.28.56.41]:58009 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id <S261650AbSJFPmj>; Sun, 6 Oct 2002 11:42:39 -0400
Date: Sun, 6 Oct 2002 17:48:06 +0200
From: Marek Habersack <grendel@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: BK MetaData License Problem?
Message-ID: <20021006154806.GA2524@thanes.org>
Reply-To: grendel@debian.org
References: <3DA02F30.8040904@colorfullife.com> <Pine.LNX.4.44.0210061452400.6237-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210061452400.6237-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2002 at 03:13:24PM +0200, Ingo Molnar scribbled:
>=20
> On Sun, 6 Oct 2002, Manfred Spraul wrote:
>=20
> > Where is the problem? This asks for a permission, not for exclusive
> > rights.
>=20
[snip]
> the commit message on the other hand is the same as eg. SuSE's PR
> announcement of SuSE Linux 20.9, it's metadata connected to their
> publishing of a GPL-ed piece of code, but it's otherwise copyright and
> owned by SuSE. The pure fact that a commit message about a GPL-ed work is
> distributed publicly does not necessarily trigger any licensing of the
> commit message itself.
Perhaps I am being silly at the moment, but wouldn't it suffice in this case
to put a statement in your commit message (I believe it can be automated)
stating that this message and the comitted data are licensed under the GPL?
As much as it would be an annoyance on the long run, it would effectively
protect every message from being abused by BitMover (or anyone else, for
that matter)*?

regards,

marek

* Note that I'm not implying BitMover or anyone else would claim ownership
  of the mentioned message - I'm just following your thread of thinking.

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9oFs2q3909GIf5uoRAtwDAJ4t/KX3Zyj+KUNGBqPXwEy3GeNcYACdG0XF
NzPKzIcolLkfF9qLgyTcMd8=
=kra1
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
