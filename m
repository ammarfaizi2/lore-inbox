Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267546AbSLSGtT>; Thu, 19 Dec 2002 01:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267553AbSLSGtT>; Thu, 19 Dec 2002 01:49:19 -0500
Received: from dhcp31182033.columbus.rr.com ([24.31.182.33]:25609 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id <S267546AbSLSGtR>; Thu, 19 Dec 2002 01:49:17 -0500
From: "Joseph Fannin" <jhf@rivenstone.net>
Date: Thu, 19 Dec 2002 01:34:45 -0500
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Notification hooks
Message-ID: <20021219063445.GA30990@zion.rivenstone.net>
Mail-Followup-To: Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20021216171218.GV504@hopper.phunnypharm.org> <20021216171925.GC15256@suse.de> <20021216092415.E432@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20021216092415.E432@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2002 at 09:24:15AM -0800, Larry McVoy wrote:
> On Mon, Dec 16, 2002 at 05:19:25PM +0000, Dave Jones wrote:
> > On Mon, Dec 16, 2002 at 12:12:18PM -0500, Ben Collins wrote:
> >  > Linus, is there anyway I can request a hook so that anything that
> >  > changes drivers/ieee1394/ in your repo sends me an email with the di=
ff
> >  > for just the files in that directory, and the changeset log? Is this
> >  > something that bkbits can do?
> >  >=20
> >  > I'd bet lots of ppl would like similar hooks for their portions of t=
he
> >  > source.
> >=20
> > It'd be nice if the bkbits webpage had a "notify me" interface for files
> > in Linus' repository. This way not just the maintainers, but folks
> > interested in changes in that area can also see the changes.
>=20
> Just for linux.bkbits.net or for the openlogging tree?  To remind people,=
=20
> linux.bkbits.net has Linus/Marcelo trees but openlogging.org has the=20
> union of all trees anywhere in the world.  And openlogging doesn't have
> contents, it just has comments. =20

    Sorry to hijack this thread like this, but I can't find a better
forum for it.

    Several times I have browsed linux source trees at bkbits.net and
found a changeset I have wanted to have as a patch.  I can search for
the changeset, and read the commit messages, and even read the patch
on the screen, but there is no good way to download that patch as a
file (viewing the page source doesn't help because the patch has html
markup interspersed with it).

    The only way to get the patch is to either 'scrape' the screen
with copy and paste and try to fix the broken whitespace or to use bk
to clone the entire tree and extract the patch via bk export.  It's a
real pain, and for no good reason I can see.

    Would it be possible to add a link to the bkbits.net pages to an
un-marked up changeset patch?  It would be great to have this for
trees other than linux.bkbits.net too -- like Dave Jones'
agpgart.bkbits.net for example.

--=20
Joseph Fannin
jhf@rivenstone.net

"That's all I have to say about that." -- Forrest Gump.

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+AWiFWv4KsgKfSVgRAi6MAJ9w4PdtItcJnIMZvQutP00siPUVDQCeM45r
PMFQicHgNt+NrvI8If28MXU=
=WNNS
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
