Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbVJ0SDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVJ0SDd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 14:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbVJ0SDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 14:03:33 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:47256 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751371AbVJ0SDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 14:03:33 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
Date: Thu, 27 Oct 2005 20:03:17 +0200
User-Agent: KMail/1.7.2
Cc: Andi Kleen <ak@suse.de>, vojtech@suse.cz, akpm@osdl.org
References: <200510271026.10913.ak@suse.de>
In-Reply-To: <200510271026.10913.ak@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1377499.ql50k6TSnE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510272003.26560.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1377499.ql50k6TSnE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andi,

On Thursday 27 October 2005 10:26, Andi Kleen wrote:
> Remove most useless printk in the world

*clap* *clap*

Thanks!

It usally triggers, if your cat, child, bird whatever handles your keyboard or
you accidentally put a book or sth. on it (e.g while the screen has been
locked).

So there is really no use for it, except for kernel debugging,
where it can be wrapped up by pr_debug() or similiar.

Regards

Ingo Oeser


--nextPart1377499.ql50k6TSnE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDYRZuU56oYWuOrkARArCeAKCiv7MjrE48xLNHha4Fj7/74u1Y7gCgjAfZ
xbhMt4PJp4P1d9QumaRbjqU=
=8wXY
-----END PGP SIGNATURE-----

--nextPart1377499.ql50k6TSnE--
