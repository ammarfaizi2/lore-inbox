Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTD2S7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 14:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbTD2S7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 14:59:09 -0400
Received: from coruscant.franken.de ([193.174.159.226]:49082 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S261564AbTD2S7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 14:59:08 -0400
Date: Tue, 29 Apr 2003 21:07:13 +0200
From: Harald Welte <laforge@netfilter.org>
To: Hanasaki JiJi <hanasaki@hanaden.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: iptables NAT entry times out but connects from firewall
Message-ID: <20030429190713.GE990@sunbeam.de.gnumonks.org>
References: <3EAD6B7C.4090108@hanaden.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ujOy8a1yc0D9aEKa"
Content-Disposition: inline
In-Reply-To: <3EAD6B7C.4090108@hanaden.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux sunbeam 2.4.20-nfpom
X-Date: Today is Sweetmorn, the 43rd day of Discord in the YOLD 3169
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ujOy8a1yc0D9aEKa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2003 at 12:57:16PM -0500, Hanasaki JiJi wrote:
> There is a firewall with two NICs and the below rule to allow an=20
> internal host to connect out to smtp servers on the internet.  Some=20
> hosts have a connection timeout on a connect from $INTERNAL_IP_OF_SMTP=20
> yet connect from the firewall just fine.

this seems to be an iptables usage problem, please follow-up to the
netfilter mailinglist at netfilter@lists.netfilter.org.

for more information, plaese see the netfilter homepage at
http://www.netfilter.org

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--ujOy8a1yc0D9aEKa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+rs1hXaXGVTD0i/8RAkbtAJ94IfElgwzLq7iL9FQEv1DnH//wcgCffgMT
WCGPatZeSMfneeROgbHDMJ0=
=/qi8
-----END PGP SIGNATURE-----

--ujOy8a1yc0D9aEKa--
