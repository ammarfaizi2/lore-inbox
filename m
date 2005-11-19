Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVKSWYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVKSWYI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 17:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVKSWYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 17:24:08 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:59266 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1750920AbVKSWYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 17:24:06 -0500
Date: Sat, 19 Nov 2005 23:23:57 +0100
From: Harald Welte <laforge@netfilter.org>
To: Yasuyuki KOZAKAI <yasuyuki.kozakai@toshiba.co.jp>
Cc: khc@pm.waw.pl, netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: build bug: ipt_CONNMARK.c: undefined reference to `need_ip_conntrack'
Message-ID: <20051119222356.GI24948@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Yasuyuki KOZAKAI <yasuyuki.kozakai@toshiba.co.jp>, khc@pm.waw.pl,
	netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <m364qolfuv.fsf@defiant.localdomain> <200511191930.jAJJUJ2n022269@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
In-Reply-To: <200511191930.jAJJUJ2n022269@toshiba.co.jp>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 20, 2005 at 04:30:18AM +0900, Yasuyuki KOZAKAI wrote:

> Thanks for report. Could you check this patch ?

thanks, applied and forwarded.
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDf6X8XaXGVTD0i/8RAmqUAJ0Ug4nxcHTk0eHIjUCYZG91NIs6/ACghFmn
bcCj4vR6ZGhEJalfLQwuIgc=
=b9Up
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--
