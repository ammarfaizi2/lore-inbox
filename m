Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264526AbUESUHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUESUHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 16:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbUESUHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 16:07:32 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:33408 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264526AbUESUHa (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 16:07:30 -0400
Message-Id: <200405192006.i4JK6Hv8004808@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org, Larry McVoy <lm@work.bitmover.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: bk-3.2.0 released 
In-Reply-To: Your message of "Wed, 19 May 2004 16:26:56 +0200."
             <20040519142656.GP1912@lug-owl.de> 
From: Valdis.Kletnieks@vt.edu
References: <20040518233238.GC28206@work.bitmover.com> <20040519075128.A19221@infradead.org> <20040519140259.GA18977@work.bitmover.com> <20040519141115.GO1912@lug-owl.de> <20040519141648.GB18977@work.bitmover.com>
            <20040519142656.GP1912@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_921624884P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 May 2004 16:06:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_921624884P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 May 2004 16:26:56 +0200, Jan-Benedict Glaw said:
> On Wed, 2004-05-19 07:16:48 -0700, Larry McVoy <lm@bitmover.com>
> wrote in message <20040519141648.GB18977@work.bitmover.com>:
> > new version of a widely used tool is available?  If someone posted that
> > there is a new version of gcc available is that off topic? =20
> 
> Yes, it was. Even miscompilation reports are mostly OT, since they
> should go to GCC's bugzilla.

Given the number of times (it's well past non-zero) we've changed around kernel
source in order to work around a bug in one or another widely-distributed
release of gcc, I think miscompile reports *are* on topic.

I seem to remember that gcc 3.4 did oddness with inlining strcpy that resulted
in a source tweak to lib/strings.c not too long ago, as just one example...

And there was the "read/write constraints and registers" warning recently...

And there was.... you get the idea...


--==_Exmh_921624884P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAq745cC3lWbTT17ARAqRuAKCcUaJn8wkLf8xtrEyxy7rKnNb4LACgsHxV
4TLFtDzwz9Mr7YtjKeUs6bI=
=Meni
-----END PGP SIGNATURE-----

--==_Exmh_921624884P--
