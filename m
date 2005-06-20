Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVFTNhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVFTNhg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 09:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVFTNhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 09:37:36 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:59525 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261238AbVFTNha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 09:37:30 -0400
Date: Mon, 20 Jun 2005 09:19:17 +0200
From: Harald Welte <laforge@netfilter.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Chris Rankin <rankincj@yahoo.com>, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12: connection tracking broken?
Message-ID: <20050620071917.GM9491@obroa-skai.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Chris Rankin <rankincj@yahoo.com>,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <20050618124359.39052.qmail@web52901.mail.yahoo.com> <Pine.LNX.4.61.0506181656250.20828@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7vLGWvOrvbSM0Ba8"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506181656250.20828@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7vLGWvOrvbSM0Ba8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 18, 2005 at 04:57:49PM +0200, Jan Engelhardt wrote:
> You forget about INPUT and OUTPUT. If you drop everything in INPUT, there=
's=20
> nothing to FORWARD.

he was talking about iptables, not ipchains.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--7vLGWvOrvbSM0Ba8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCtm31XaXGVTD0i/8RArpiAKCQ+IEzLA/WSzMyhFcscLqQN6RgQACgjBxA
i9qo/sja6oLo951810LnlCM=
=Aa3m
-----END PGP SIGNATURE-----

--7vLGWvOrvbSM0Ba8--
