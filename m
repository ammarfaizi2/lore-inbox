Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264855AbUE2NRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUE2NRG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUE2NQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:16:41 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:6590 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S264798AbUE2NPW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:15:22 -0400
Date: Sat, 29 May 2004 14:15:10 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Larry McVoy <lm@work.bitmover.com>, Vojtech Pavlik <vojtech@suse.cz>,
       bitkeeper-announce@work.bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: bk-3.2.0 released
Message-ID: <20040529131510.GB13999@selene>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Larry McVoy <lm@work.bitmover.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	bitkeeper-announce@work.bitmover.com, linux-kernel@vger.kernel.org
References: <20040518233238.GC28206@work.bitmover.com> <20040529095419.GB1269@ucw.cz> <20040529130436.GA20605@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20040529130436.GA20605@work.bitmover.com>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 29, 2004 at 06:04:36AM -0700, Larry McVoy wrote:
> On Sat, May 29, 2004 at 11:54:20AM +0200, Vojtech Pavlik wrote:
> > On Tue, May 18, 2004 at 04:32:38PM -0700, Larry McVoy wrote:
> > > BK/Pro 3.2.0 has been released and is in the BK download area,
> > > 
> > >     http://bitmover.com/download
> > 
> > Any chance of a native x86-64 version? 
> 
> We don't have any x86-64 machines but we could get one.  I asked about this
> a while back and people told me that there was no point, the x86 one worked
> perfectly.  Can you tell me what having a native one would gain?  If there
> is any gain we'll do it.

   It'll allow BK to be run on machines which have a pure 64-bit
userspace (for example, Debian's current amd64 port), without having
to resort to a 32-bit chroot to run the 32-bit BK binary.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
         --- Nothing right in my left brain. Nothing left in ---         
                             my right brain.                             

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAuIzessJ7whwzWGARAitwAJ9ez20ib+P8pGLL+qOWdkRKEufjXQCfU9FB
nU9zHWy8gceIbEtwmWiW6O0=
=Tjxs
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
