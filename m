Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268883AbUI2TTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268883AbUI2TTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 15:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268890AbUI2TTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 15:19:11 -0400
Received: from [63.227.221.253] ([63.227.221.253]:17587 "EHLO home.keithp.com")
	by vger.kernel.org with ESMTP id S268886AbUI2TS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 15:18:56 -0400
X-Mailer: exmh version 2.3.1 11/28/2001 with nmh-1.1
To: Discuss issues related to the xorg tree <xorg@freedesktop.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Keith Packard <keithp@keithp.com>
Subject: Re: New DRM driver model - gets rid of DRM() macros! 
From: Keith Packard <keithp@keithp.com>
In-Reply-To: Your message of "Wed, 29 Sep 2004 15:39:37 BST."
             <415AC929.6070700@tungstengraphics.com> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-600504980P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Sep 2004 12:16:49 -0700
Message-Id: <E1CCjwX-0002Y0-9S@evo.keithp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-600504980P
Content-Type: text/plain; charset=us-ascii


Around 15 o'clock on Sep 29, Keith Whitwell wrote:

> A future X-on-GL world where regular applications are presumably doing direct 
> rendering will change that assumption...

I'm not planning on eliminating the X protocol in this environment, so 
unless cairo really takes off and applications start coding to cairo-on-GL 
instead of cairo-on-X-on-GL, then we'll have about the same number of 
contexts, although the X context will be more rational than it currently 
is.

-keith



--==_Exmh_-600504980P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.3.1 11/28/2001

iD8DBQFBWwohQp8BWwlsTdMRAkY4AKCuhi8k2WdLVL9ZJSU0be0snpmWwwCfdQPU
dcxkFklrsMNnDExcmD77Vnw=
=2gip
-----END PGP SIGNATURE-----

--==_Exmh_-600504980P--
