Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWDKJNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWDKJNx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 05:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWDKJNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 05:13:52 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:27595 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932386AbWDKJNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 05:13:52 -0400
Date: Tue, 11 Apr 2006 11:03:56 +0200
From: Harald Welte <laforge@netfilter.org>
To: Patrick McHardy <kaber@trash.net>
Cc: Nix <nix@esperi.org.uk>, vherva@vianova.fi, linux-kernel@vger.kernel.org,
       netfilter@lists.netfilter.org, davem@davemloft.net
Subject: Re: Linux 2.6.17-rc1: /sbin/iptables does not find kernel netfilter
Message-ID: <20060411090356.GJ5167@rama.linbit>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Patrick McHardy <kaber@trash.net>, Nix <nix@esperi.org.uk>,
	vherva@vianova.fi, linux-kernel@vger.kernel.org,
	netfilter@lists.netfilter.org, davem@davemloft.net
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org> <20060408200915.GN1686@vianova.fi> <44388908.6070602@trash.net> <20060409074313.GZ15954@vianova.fi> <20060409144416.GO1686@vianova.fi> <20060409144534.GN29797@vianova.fi> <87psjqg2nt.fsf@hades.wkstn.nix> <4439385B.6010908@trash.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BEa57a89OpeoUzGD"
Content-Disposition: inline
In-Reply-To: <4439385B.6010908@trash.net>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 09, 2006 at 06:37:47PM +0200, Patrick McHardy wrote:

> But it does show you all the new options. Admittedly, it would
> have been better to automatically select the new options when
> needed,=20

I spent a long time trying to do this with Kconfig, including
suggestions from Rusty, but couldn't get it to work at all.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEO3D8XaXGVTD0i/8RAqY4AKCoA03noKLFWahqTa59WwRt7HugkgCfaFvM
UgJrkwY6JMMy7k9uAkXcbeE=
=hSbd
-----END PGP SIGNATURE-----

--BEa57a89OpeoUzGD--
