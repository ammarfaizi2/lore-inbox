Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTKKCvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 21:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264216AbTKKCvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 21:51:24 -0500
Received: from h80ad251e.async.vt.edu ([128.173.37.30]:19072 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261686AbTKKCvW (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 21:51:22 -0500
Message-Id: <200311110250.hAB2orA8004592@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Peter Lieverdink <linux@cafuego.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loopback device + crypto = crash on 2.6.0-test7 ? 
In-Reply-To: Your message of "Tue, 11 Nov 2003 10:27:16 +1100."
             <6.0.0.22.2.20031111101721.01bde418@caffeine.cc.com.au> 
From: Valdis.Kletnieks@vt.edu
References: <1067411342.1574.11.camel@localhost> <20031109131018.GA18342@deneb.enyo.de> <bop47i$7eg$1@gatekeeper.tmr.com>
            <6.0.0.22.2.20031111101721.01bde418@caffeine.cc.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_547892807P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Nov 2003 21:50:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_547892807P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 Nov 2003 10:27:16 +1100, Peter Lieverdink <linux@cafuego.net>  said:

> I agree that something is very broken, though. Mind you, I can only 
> replicate this problem on one of my machines - the other one I've tried it 
> on seems to work fine. Odder still, when I compile a kernel on the machine 
> which is fine and ruin said kernel on the machine which is not fine, I 
> don't experience the crash.

Could we see a 'gcc -V' from *both* machines, please? (and an 'as -v'
and 'ld -v' as well, just to be thorough?)

--==_Exmh_547892807P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/sE6McC3lWbTT17ARAoWXAKCczSsOz8oD57lAlnu1VXqVChBX9ACfV30z
s2Pjjdyp8Ktg+XK223I7b1I=
=yU5b
-----END PGP SIGNATURE-----

--==_Exmh_547892807P--
