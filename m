Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVDDXl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVDDXl1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVDDXi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:38:57 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:40937 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261514AbVDDXh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:37:29 -0400
Date: Tue, 5 Apr 2005 09:37:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12-rc2
Message-Id: <20050405093718.7f40ee3d.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org>
	<Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__5_Apr_2005_09_37_18_+1000_Uq2=YaL5Z.w0ZPtY"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__5_Apr_2005_09_37_18_+1000_Uq2=YaL5Z.w0ZPtY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Apr 2005 14:32:52 -0700 (PDT) Linus Torvalds <torvalds@osdl.org> =
wrote:
>
>   o missing include in lanai.c

After this patch I have ended up with linux/dma-mapping.h included twice
in this file ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__5_Apr_2005_09_37_18_+1000_Uq2=YaL5Z.w0ZPtY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCUc+y4CJfqux9a+8RAry7AJ45gTkvn+9EfPoQDlT2Oo7l4AygvwCffbLd
7pMvc/JOcAOy90JAE0zJY5E=
=FCLf
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Apr_2005_09_37_18_+1000_Uq2=YaL5Z.w0ZPtY--
