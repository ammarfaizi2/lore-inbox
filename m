Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270003AbTHQNIE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 09:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270007AbTHQNIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 09:08:04 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:53466 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S270003AbTHQNIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 09:08:00 -0400
Date: Sun, 17 Aug 2003 16:07:54 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Dominik Strasser <Dominik.Strasser@t-online.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi.h uses "u8" which isn't defined.
Message-ID: <20030817130754.GS27888@actcom.co.il>
References: <3F3F782C.2030902@t-online.de> <20030817134633.A7881@infradead.org> <3F3F7E67.2040506@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JkgDhDyNm4zanevS"
Content-Disposition: inline
In-Reply-To: <3F3F7E67.2040506@t-online.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JkgDhDyNm4zanevS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2003 at 03:08:55PM +0200, Dominik Strasser wrote:

> I am sorry, in 2.6.0-test3 (which I should have mentioned), there is no=
=20
> u8 in liux/types.h. Just a __u8.

linux/types.h brings in asm/types.h, which (at least on x86) defines
u8, ifndef __ASSEMBLY__.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--JkgDhDyNm4zanevS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/P34qKRs727/VN8sRAqQ2AJ4thtJkfn3Wie8G838Po0HFZ/GofwCgqfG+
TJhjySTqfseYmIrzsRsxRTE=
=xLLx
-----END PGP SIGNATURE-----

--JkgDhDyNm4zanevS--
