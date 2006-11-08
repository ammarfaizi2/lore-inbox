Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161562AbWKHXUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161562AbWKHXUw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161680AbWKHXUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:20:52 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:18667 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1161562AbWKHXUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:20:51 -0500
Date: Thu, 9 Nov 2006 10:20:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Judith Lebzelter <judith@osdl.org>
Cc: linuxppc-dev@ozlabs.org, hch@lst.de, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  powerpc iseries link error in allmodconfig
Message-Id: <20061109102032.8c3e3b58.sfr@canb.auug.org.au>
In-Reply-To: <20061108173429.GB14991@shell0.pdx.osdl.net>
References: <20061108173429.GB14991@shell0.pdx.osdl.net>
X-Mailer: Sylpheed version 2.3.0beta4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__9_Nov_2006_10_20_32_+1100_imOnlbEjKaY9r.oi"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__9_Nov_2006_10_20_32_+1100_imOnlbEjKaY9r.oi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 8 Nov 2006 09:34:29 -0800 Judith Lebzelter <judith@osdl.org> wrote:
>
> Choose rpa_vscsi.c over iseries_vscsi.c when building both
> pseries and iseries.  This fixes a link error.
>
> Signed-off-by:  Judith Lebzelter <judith@osdl.org>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__9_Nov_2006_10_20_32_+1100_imOnlbEjKaY9r.oi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFUmZGFdBgD/zoJvwRAqQdAJ4q6UB2eodBXXBt+BeyEEb8e9MxRACfb2BK
bLPrP4dxPqP1HJPwFnsKW04=
=WKsI
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Nov_2006_10_20_32_+1100_imOnlbEjKaY9r.oi--
