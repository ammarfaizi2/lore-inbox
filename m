Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267439AbUGWH4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267439AbUGWH4b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 03:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267442AbUGWH4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 03:56:31 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:38890 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S267439AbUGWH4S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 03:56:18 -0400
Date: Fri, 23 Jul 2004 08:56:09 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
Subject: Re: Interesting race condition...
Message-ID: <20040723075609.GB13737@selene>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	"Barry K. Nathan" <barryn@pobox.com>, Rob Landley <rob@landley.net>,
	linux-kernel@vger.kernel.org
References: <200407222204.46799.rob@landley.net> <20040723073300.GA4502@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <20040723073300.GA4502@ip68-4-98-123.oc.oc.cox.net>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 23, 2004 at 12:33:00AM -0700, Barry K. Nathan wrote:
> On Thu, Jul 22, 2004 at 10:04:46PM -0500, Rob Landley wrote:
> > Seems like some kind of race condition, dunno if it's in Fedore Core 1's ps
> > or the 2.6.7 kernel or what...
> 
> I've seen this too, on Fedora Core 2 and pretty recent (within the last
> 2 weeks) fc-devel. Hard enough to reproduce (and not enough of a bother
> IMO) that I haven't filed it in Bugzilla though.
> 
> (Now that you mention Fedora Core, I can't remember seeing this with any
> other distributions.)

   I've seen it on Debian unstable/sid, running a 32-bit userspace on
a 64-bit amd64 2.6.6 from kernel.org.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
    --- There is no dark side to the Moon, really. As a matter of ---    
                          fact,  it's all dark.                          

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBAMSZssJ7whwzWGARAgZ6AJ94EUJtCz5pwdBumR5U22WIkhJnswCaA8qK
GGkbm4aEKyJXQCVfi71TvZg=
=IoHH
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
