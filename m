Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVK2RnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVK2RnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 12:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVK2RnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 12:43:24 -0500
Received: from ns.snowman.net ([66.92.160.21]:62605 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id S932229AbVK2RnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 12:43:23 -0500
Date: Tue, 29 Nov 2005 12:44:04 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Chris Shoemaker <c.shoemaker@cox.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Michael Krufky <mkrufky@m1k.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc3
Message-ID: <20051129174404.GQ6026@ns.snowman.net>
Mail-Followup-To: Chris Shoemaker <c.shoemaker@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Michael Krufky <mkrufky@m1k.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <438C0124.3030700@m1k.net> <Pine.LNX.4.64.0511290808510.3177@g5.osdl.org> <438C80DD.7050809@m1k.net> <Pine.LNX.4.64.0511290835220.3177@g5.osdl.org> <20051129172534.GA4514@pe.Belkin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FWsKKOMrHBxzpZBm"
Content-Disposition: inline
In-Reply-To: <20051129172534.GA4514@pe.Belkin>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.24ns.3.0 (i686)
X-Uptime: 12:43:41 up 171 days,  9:56,  8 users,  load average: 0.08, 0.09, 0.12
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FWsKKOMrHBxzpZBm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Chris Shoemaker (c.shoemaker@cox.net) wrote:
> I doubt gdb is in rc.d scripts.  My wild uninformed guess would be
> that some process (maybe xinit?) hit a SEGV and had its own signal
> handler installed that tried to call gdb and attach to the crashing
> process.  I could imagine something like that being useful for
> generating nice userspace stack traces to send to the developers.  I
> think I've seen something similar in some builds.

Not sure if it's relevent, but I think samba does this too...

	Stephen

--FWsKKOMrHBxzpZBm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDjJNkrzgMPqB3kigRAos4AJ9Za2I9KOmC+KR27/2PYvZToB0KZgCfSOPC
eJv6rbXMKYOloZvgi+fDmo8=
=jQL6
-----END PGP SIGNATURE-----

--FWsKKOMrHBxzpZBm--
