Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317026AbSFFRxZ>; Thu, 6 Jun 2002 13:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317035AbSFFRxY>; Thu, 6 Jun 2002 13:53:24 -0400
Received: from 24-205-207-61.cs-dyn.charterpipeline.net ([24.205.207.61]:37508
	"EHLO tarot.internal.aom.geek") by vger.kernel.org with ESMTP
	id <S317026AbSFFRxX>; Thu, 6 Jun 2002 13:53:23 -0400
Date: Thu, 6 Jun 2002 10:52:59 -0700
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: 3dfx framebuffer driver borked in 2.5.19 kernel
Message-ID: <20020606175259.GB14272@ahrairah.internal.aom.geek>
In-Reply-To: <20020530165031.GA18544@kira.glasswings.com.au> <Pine.LNX.4.10.10205301139260.9282-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: idalton@ferret.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2002 at 11:40:14AM -0700, James Simmons wrote:
>=20
> > With the port to the new fbdev interface in kernel
> > 2.5.19 the system now only displays a few unchanging coloured pixels
> > on the first line of the screen.  The rest of the screen remains black
> > until X11 starts.  I am using append=3D"video=3Dtdfx:1024x768" in LILO.
>=20
> I'm tracking down the bug you are experiencing. Almost done.=20

Does the new interface handle multihead any better? I have a dual tdfx
system..

Am interested in testing patches. Head up?

--=20
Ferret

-- Support your government, give Echelon / Carnivore something to parse --
classfield top-secret government restricted data  information project  CIA
Microsoft terrorist Allah Natasha Gregori destroy destruct attack will own
send Russia bank system compromise  World Trade Center  international rule
presidental elections  policital foreign fnord embassy  takeover democracy
--------------------------------------------------------------------------

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8/6F7e0DNEkH06HMRAvGiAKCCEiiNuCc9vdRbirudy9dUCdAVUACgwijQ
iL4FRjnqxXgL+T7vKMqhLX4=
=a3tI
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
