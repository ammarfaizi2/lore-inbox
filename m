Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264235AbUEXKXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbUEXKXC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 06:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUEXKXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 06:23:02 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:23510 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S264235AbUEXKXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 06:23:00 -0400
Date: Mon, 24 May 2004 20:22:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic addition of virtual disks on PPC64 iSeries
Message-Id: <20040524202226.6b0acab6.sfr@canb.auug.org.au>
In-Reply-To: <20040524014901.04530a24.akpm@osdl.org>
References: <20040524162039.5f6ca3e0.sfr@canb.auug.org.au>
	<20040523232920.2fb0640a.akpm@osdl.org>
	<20040524184126.11aeffd3.sfr@canb.auug.org.au>
	<20040524014901.04530a24.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__24_May_2004_20_22_26_+1000_.Y3KtUOJ.om8le1D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__24_May_2004_20_22_26_+1000_.Y3KtUOJ.om8le1D
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 24 May 2004 01:49:01 -0700 Andrew Morton <akpm@osdl.org> wrote:
>
> Handy.  So the patch stands as-is?

I would like that, but the recursive grep through /sys example
bascially convinced me that having a writable file is better.

New patch soon.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__24_May_2004_20_22_26_+1000_.Y3KtUOJ.om8le1D
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsczpFG47PeJeR58RAmTiAJsFhH1f4jvauvSWK4mxaakVopDapgCeIpKs
GqymjwRIcHS3mjeifF1rV3s=
=V1S3
-----END PGP SIGNATURE-----

--Signature=_Mon__24_May_2004_20_22_26_+1000_.Y3KtUOJ.om8le1D--
