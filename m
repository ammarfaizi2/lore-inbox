Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUCLWsr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 17:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbUCLWsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 17:48:47 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:29826 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S262322AbUCLWso
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 17:48:44 -0500
Date: Fri, 12 Mar 2004 22:48:41 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Mickael Marchand <marchand@kde.org>
Cc: linux-kernel@vger.kernel.org, Joe Thornber <thornber@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.4-mm1
Message-ID: <20040312224841.GA613@selene>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Mickael Marchand <marchand@kde.org>, linux-kernel@vger.kernel.org,
	Joe Thornber <thornber@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Andi Kleen <ak@muc.de>
References: <1ysXv-wm-11@gated-at.bofh.it> <20040312082214.GO18345@reti> <20040312094951.GP18345@reti> <200403121311.46975.marchand@kde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <200403121311.46975.marchand@kde.org>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 12, 2004 at 01:11:46PM +0100, Mickael Marchand wrote:
> just tested, it works just fine :)
> no more errors,
> dmsetup version and dmsetup ls work nicely

   I concur -- this seems to be working now. Many thanks.

> > In which case the following ugly patch should fix things.  Mickael,
> > any chance you could test this please ?
> >
> > - Joe

   Eww... that's a really horrid-looking patch. I'm not complaining
right now, though. :)

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
   --- Hey, Virtual Memory! Now I can have a *really big* ramdisk! ---   

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAUj5JssJ7whwzWGARAoIGAJwMFXkUGGeR1kUgTHMX/Gjj7k5n5QCgpNhS
lfCZk1v61QVB0USm/pNZmvQ=
=y/vq
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
