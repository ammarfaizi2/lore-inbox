Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbVIVMuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbVIVMuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 08:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbVIVMuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 08:50:07 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:17328 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1030286AbVIVMuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 08:50:06 -0400
Date: Thu, 22 Sep 2005 14:50:04 +0200
From: Harald Welte <laforge@netfilter.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       netdev@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/3] netfilter : 3 patches to boost ip_tables performance
Message-ID: <20050922125004.GI26520@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
	netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org,
	Andi Kleen <ak@suse.de>
References: <432EF0C5.5090908@cosmosbay.com> <200509191948.55333.ak@suse.de> <432FDAC5.3040801@cosmosbay.com> <200509201830.20689.ak@suse.de> <433082DE.3060308@cosmosbay.com> <43308324.70403@cosmosbay.com> <4331D290.6070104@cosmosbay.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Content-Disposition: inline
In-Reply-To: <4331D290.6070104@cosmosbay.com>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2005 at 11:37:20PM +0200, Eric Dumazet wrote:
> Patch 3/3 (please apply after Patch 2/3)

Thanks for your patches, again.

> 3) NUMA allocation.

I'll wait with applying this patch until a decision has been made on
merging something like vmalloc_node() to mainline.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMqh8XaXGVTD0i/8RAq6dAJ9WGu576KG8KrPLA3gVYszkO4nxhwCcDMUO
aWNzxgyOy2Ym6vE/LuReTOo=
=Us/a
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--
