Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTKPR2Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 12:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTKPR2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 12:28:25 -0500
Received: from h80ad26be.async.vt.edu ([128.173.38.190]:20108 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263024AbTKPR2Y (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 12:28:24 -0500
Message-Id: <200311161727.hAGHRbLa028984@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Pavel Machek <pavel@ucw.cz>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, mfedyk@matchmail.com,
       reiser@namesys.com, herbert@gondor.apana.org.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Debian Kernels was: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431" 
In-Reply-To: Your message of "Sun, 16 Nov 2003 18:05:09 +0100."
             <20031116170509.GB201@elf.ucw.cz> 
From: Valdis.Kletnieks@vt.edu
References: <20031029141931.6c4ebdb5.akpm@osdl.org> <E1AGCUJ-00016g-00@gondolin.me.apana.org.au> <20031101233354.1f566c80.akpm@osdl.org> <20031102092723.GA4964@gondor.apana.org.au> <20031102014011.09001c81.akpm@osdl.org> <20031116130558.GB199@elf.ucw.cz> <20031116151522.6ef9d2e1.skraw@ithnet.com>
            <20031116170509.GB201@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2037539920P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 16 Nov 2003 12:27:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2037539920P
Content-Type: text/plain; charset=us-ascii

On Sun, 16 Nov 2003 18:05:09 +0100, Pavel Machek said:

> Okay, in the perfect world we'd have just one distribution with all
> packages unmodified. Well.. but we are not there yet.

Then why do we have a -mm kernel and a -ac kernel and a.....?

It's interesting that we've apparently decided that Andrew Morton or
Alan Cox or any of the other -initial kernel streams are allowed to have
different goals (and thus different code to achieve those goals) but
we seem to think that distributions are not allowed to do the same thing...

-exec-shield is OK if it shows up in Andrew's stuff, but not when it's
in the RedHat from whence it came?  What's wrong with THAT?

--==_Exmh_2037539920P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/t7OIcC3lWbTT17ARArYyAKDaCNJROBWucr6VawggWxts3inNyQCcC2xg
eGYV5gFsnswaCOr10YyPtks=
=qqXr
-----END PGP SIGNATURE-----

--==_Exmh_2037539920P--
