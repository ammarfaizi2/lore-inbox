Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270523AbRIFNKt>; Thu, 6 Sep 2001 09:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270634AbRIFNKk>; Thu, 6 Sep 2001 09:10:40 -0400
Received: from tank.panorama.sth.ac.at ([193.170.53.11]:31250 "EHLO
	tank.panorama.sth.ac.at") by vger.kernel.org with ESMTP
	id <S270523AbRIFNKY>; Thu, 6 Sep 2001 09:10:24 -0400
Date: Thu, 6 Sep 2001 15:10:33 +0200
From: Peter Surda <shurdeek@panorama.sth.ac.at>
To: linux-kernel@vger.kernel.org
Cc: Daniel Egger <egger@suse.de>
Subject: Re: (solved) memcpy to videoram eats too much CPU on ATI cards
Message-ID: <20010906151033.I27619@shurdeek.cb.ac.at>
In-Reply-To: <E15bRy4-0004Va-00@the-village.bc.nu> <200108272140.XAA20798@cave.bitwizard.nl> <20010828000127.M17545@shurdeek.cb.ac.at> <20010906081842.D27619@shurdeek.cb.ac.at> <999776228.10893.17.camel@sonja>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8/pVXlBMPtxfSuJG"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <999776228.10893.17.camel@sonja>; from egger@suse.de on Thu, Sep 06, 2001 at 01:37:07PM +0200
X-Operating-System: Linux shurdeek 2.4.3-20mdk
X-Editor: VIM - Vi IMproved 6.0z ALPHA (2001 Mar 24, compiled Mar 26 2001 12:25:08)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8/pVXlBMPtxfSuJG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2001 at 01:37:07PM +0200, Daniel Egger wrote:
> > Just to end this thread in a victorous manner ;-), thanks to Michel D=
=E4nzer
> > <michdaen@iiic.ethz.ch> and me, there is now a working implementation of
> > busmastered video transfers for the r128 driver, and it has been submit=
ted to.=20
> > all relevant lists and maintainers.
> I kept on checking the relevant mailinglist and project CVSes but failed =
to
> find the described implementation, would you please provide additional hi=
nts
> where to get it?
dri-devel should have it, as well as livid-gatos (which unfortunately seems=
 to
have full disks and is offline at the moment).

For very lazy ones I found a link to the annoucement in dri-devel:
http://www.geocrawler.com/lists/3/SourceForge/680/0/6536416/

> Servus,
>        Daniel
Mit freundlichen Gr=FC=DFen

Peter Surda (Shurdeek) <shurdeek@panorama.sth.ac.at>, ICQ 10236103, +436505=
122023

--
   "One world, one web, one program"  -- Microsoft promotional ad
         "Ein Volk, ein Reich, ein Fuehrer"  -- Adolf Hitler

--8/pVXlBMPtxfSuJG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7l3XJzogxsPZwLzcRAir1AKCHtf1tLBlCjvZbufgpPbxUBfsM+ACffV7c
v/Q6f/loWZ3+eGoiqbaCAPI=
=GSyC
-----END PGP SIGNATURE-----

--8/pVXlBMPtxfSuJG--
