Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266573AbUFYIjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266573AbUFYIjI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 04:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266598AbUFYIjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 04:39:08 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:58270 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S266573AbUFYIi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 04:38:58 -0400
Date: Fri, 25 Jun 2004 18:38:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing semicolon in 2.6.7 VIODASD driver
Message-Id: <20040625183858.3e221926.sfr@canb.auug.org.au>
In-Reply-To: <31563.1088089053@redhat.com>
References: <31563.1088089053@redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__25_Jun_2004_18_38_58_+1000_Okucl2JhxzTqbcF1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__25_Jun_2004_18_38_58_+1000_Okucl2JhxzTqbcF1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi David,

On Thu, 24 Jun 2004 15:57:33 +0100 David Howells <dhowells@redhat.com> wrote:
>
> There appears to be a missing semicolon in the VIODASD driver in 2.6.7.

Looks good to me - now I just have to figure out how I have been building
kernels. :-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__25_Jun_2004_18_38_58_+1000_Okucl2JhxzTqbcF1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2+SiFG47PeJeR58RApWTAJwLh8X2kLzMJ7mgAEvG+28L/ARJ7QCgu4/h
/aQHB8ZRh2tCc0/+Fzjf5xc=
=ETi4
-----END PGP SIGNATURE-----

--Signature=_Fri__25_Jun_2004_18_38_58_+1000_Okucl2JhxzTqbcF1--
