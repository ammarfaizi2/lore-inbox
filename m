Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135706AbRDSUtt>; Thu, 19 Apr 2001 16:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135704AbRDSUtk>; Thu, 19 Apr 2001 16:49:40 -0400
Received: from hermes.sistina.com ([208.210.145.141]:13070 "HELO sistina.com")
	by vger.kernel.org with SMTP id <S135702AbRDSUtX>;
	Thu, 19 Apr 2001 16:49:23 -0400
Date: Thu, 19 Apr 2001 15:16:33 -0500
From: AJ Lewis <lewis@sistina.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
        linux-openlvm@nl.linux.org
Subject: Re: [linux-lvm] Re: [repost] Announce: Linux-OpenLVM mailing list
Message-ID: <20010419151633.P10345@sistina.com>
In-Reply-To: <20010419142400.E10345@sistina.com> <200104191945.f3JJjKRn015661@webber.adilger.int> <20010419145337.K10345@sistina.com> <3ADF45FC.EE7B2003@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bd2KlmcTHfsQFEJ+"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3ADF45FC.EE7B2003@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Apr 19, 2001 at 04:09:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Bd2KlmcTHfsQFEJ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2001 at 04:09:32PM -0400, Jeff Garzik wrote:
> AJ Lewis wrote:
> > Ok, the issue here is that we're trying to get a release out and so any=
thing
> > that majorly changes the code is getting shunted aside for the moment. =
 It
> > would be stupid to just add everything that comes in on the ML without
> > review.  Linus does the exact same thing.  I've said this before to you
> > Andreas, but apparently you feel that you should have final say on whet=
her
> > your patches go in or not.
>=20
> > As far as getting patches into the stock kernel, we've been sending pat=
ches
> > to Linus for over a month now, and none of them have made it in.  Maybe
> > someone has some pointers on how we get our code past his filters.
>=20
> Read Documentation/SubmittingPatches, and also listen to kernel hackers
> who know the block layer and want to fix lvm.
>=20
> And I wonder, if kernel hackers are saying lvm is broken... why do you
> want to freeze it and ship it in that state?

Hmm...perhaps I didn't make myself clear.  AFAIK Heinz is not putting
cosmetic changes into the CVS.  The team should be putting fixes in.  If
they aren't it's because they are dealing with backlog.

As far as the smaller patches go.  I know.  We're working on it; really we
are.

Regards,
--=20
AJ Lewis
Sistina Software Inc.                  Voice:  612-379-3951
1313 5th St SE, Suite 111              Fax:    612-379-3952
Minneapolis, MN 55414                  E-Mail: lewis@sistina.com
http://www.sistina.com

Current GPG fingerprint =3D 3B5F 6011 5216 76A5 2F6B  52A0 941E 1261 0029 2=
648
Get my key at: http://www.sistina.com/~lewis/gpgkey
 (Unfortunately, the PKS-type keyservers do not work with multiple sub-keys)

-----Begin Obligatory Humorous Quote----------------------------------------
There's nary an animal alive that can outrun a greased Scotsman.
   - Groundskeeper Willie
-----End Obligatory Humorous Quote------------------------------------------

--Bd2KlmcTHfsQFEJ+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE630ehpE6/iGtdjLERAs31AJ4iMbx4Kl8jstHlzTEJU1suADj8vgCeJz2j
rp2T7zAgbXzJLBbfbk72K98=
=tyQj
-----END PGP SIGNATURE-----

--Bd2KlmcTHfsQFEJ+--
