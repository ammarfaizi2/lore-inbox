Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753055AbWKCEDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbWKCEDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbWKCEDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:03:41 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:50398 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1753053AbWKCEDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:03:40 -0500
Date: Fri, 3 Nov 2006 15:03:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeff Garzik <jeff@garzik.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question for today
Message-Id: <20061103150333.92eef355.sfr@canb.auug.org.au>
In-Reply-To: <454A88C3.1060608@garzik.org>
References: <20061103104818.f280a003.sfr@canb.auug.org.au>
	<454A88C3.1060608@garzik.org>
X-Mailer: Sylpheed version 2.3.0beta3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__3_Nov_2006_15_03_33_+1100_A6twsmj2qwWX_FO+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__3_Nov_2006_15_03_33_+1100_A6twsmj2qwWX_FO+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 02 Nov 2006 19:09:39 -0500 Jeff Garzik <jeff@garzik.org> wrote:
>
> Stephen Rothwell wrote:
> > Does vmalloc() zero the memory it allocates?
>
> Nope.

Thanks.  See "Fix sys_move_pages when a NULL node list is passed."

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__3_Nov_2006_15_03_33_+1100_A6twsmj2qwWX_FO+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFSr+VFdBgD/zoJvwRAh9+AJ9L27S0CJ66dstQyZLl6buY9qlAVgCfUjBC
BU7Y362XyDSThiN8PnUzADU=
=N5u4
-----END PGP SIGNATURE-----

--Signature=_Fri__3_Nov_2006_15_03_33_+1100_A6twsmj2qwWX_FO+--
