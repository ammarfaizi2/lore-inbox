Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbVIVN2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbVIVN2h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVIVN2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:28:37 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:37861 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1030299AbVIVN2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:28:36 -0400
Date: Thu, 22 Sep 2005 15:28:34 +0200
From: Harald Welte <laforge@netfilter.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ip_conntrack_pptp: fix endian sparse warnings
Message-ID: <20050922132833.GM26520@sunbeam.de.gnumonks.org>
References: <20050921170539.GA10537@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aYrjF+tKt+ApYAdb"
Content-Disposition: inline
In-Reply-To: <20050921170539.GA10537@mipter.zuzino.mipt.ru>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aYrjF+tKt+ApYAdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

btw, where can I get the latest sparse release?

linux-2.6.14-rc2/Documentation/sparse.txt still points to a dead
directory at
http://www.codemonkey.org.uk/projects/git-snapshots/sparse/
which now seems to be 404.

Are there no snapshots available?  Didn't anyone convre the bitkeeper
repository to git or something else?  I'm a bit puzzled.

Thanks!
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--aYrjF+tKt+ApYAdb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMrGBXaXGVTD0i/8RAiKmAJ4tvlmQ1aD8EI1gFda5SZsaeSnkoQCggfPS
ExY3IukxbqTMiErfHpyH9NM=
=GHIE
-----END PGP SIGNATURE-----

--aYrjF+tKt+ApYAdb--
