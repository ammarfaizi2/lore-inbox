Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUEGGvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUEGGvT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 02:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUEGGvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 02:51:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59779 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262422AbUEGGvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 02:51:16 -0400
Date: Fri, 7 May 2004 08:51:05 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Paul Jakma <paul@clubi.ie>
Cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-ID: <20040507065105.GA10600@devserv.devel.redhat.com>
References: <20040505013135.7689e38d.akpm@osdl.org> <200405051312.30626.dominik.karall@gmx.net> <200405051822.i45IM2uT018573@turing-police.cc.vt.edu> <20040505215136.GA8070@wohnheim.fh-wedel.de> <200405061518.i46FIAY2016476@turing-police.cc.vt.edu> <1083858033.3844.6.camel@laptop.fenrus.com> <Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Fri, May 07, 2004 at 01:37:54AM +0100, Paul Jakma wrote:
> On Thu, 6 May 2004, Arjan van de Ven wrote:
> 
> > Ok I don't want to start a flamewar but... Do we want to hold linux
> > back until all binary only module vendors have caught up ??
> 
> What about normal linux modules though? Eg, NFS (most likely):
> 
> 	https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=121804

NFSv4 has a > 1Kb stack user; Dave Jones has a fix pending for that...

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAmzHYxULwo51rQBIRAumRAJ98yU/uzAwI6Gg6RbPNNSqrQoXBwACdF49k
Skt/DA8j6SRetgq24ddjx04=
=elsR
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
