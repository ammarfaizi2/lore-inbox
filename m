Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUBVJjp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 04:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUBVJjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 04:39:45 -0500
Received: from [213.177.124.6] ([213.177.124.6]:36772 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S261210AbUBVJjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 04:39:43 -0500
Date: Sun, 22 Feb 2004 12:39:34 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: NoTellin <notellin@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple NIC cards in the same machine and 2.5/2.6
Message-ID: <20040222093934.GA2943@sirius.home>
References: <200402210815.55770.notellin@speakeasy.net> <pan.2004.02.21.15.33.18.150094@altlinux.ru> <200402211739.31305.notellin@speakeasy.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <200402211739.31305.notellin@speakeasy.net>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 21, 2004 at 05:39:31PM -0500, NoTellin wrote:
> On Saturday 21 February 2004 10:33, Sergey Vlasov wrote:
> > options ne io=0x300,0x200 irq=3,5
> 
> Ah-HAH. This must be one of those fundamental differences between 
> 2.4 and 2.6.

No - this is an old feature (it was present in 2.2 and maybe even
earlier).  It is noted in Documentation/networking/net-modules.txt.

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAOHjWW82GfkQfsqIRAmbIAJ986wdW/o3vBhM4Ir/DRRJ4uC8YGACfVqpq
W4zZ66qicLvsELR1Tx2b4wo=
=iWoU
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
