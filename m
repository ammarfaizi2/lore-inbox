Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbTDXETB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTDXESx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:18:53 -0400
Received: from h80ad2785.async.vt.edu ([128.173.39.133]:6784 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264386AbTDXESt (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:18:49 -0400
Message-Id: <200304240430.h3O4UnxQ001294@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Pat Suwalski <pat@suwalski.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered. 
In-Reply-To: Your message of "Wed, 23 Apr 2003 22:29:05 EDT."
             <3EA74BF1.2090700@suwalski.net> 
From: Valdis.Kletnieks@vt.edu
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423172120.GA12497@citd.de> <3EA6947D.9080106@suwalski.net> <20030423221749.GA9187@elf.ucw.cz> <3EA71533.4090008@suwalski.net> <20030423225520.GA32577@atrey.karlin.mff.cuni.cz> <20030423231920.D1425@almesberger.net>
            <3EA74BF1.2090700@suwalski.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_681555120P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Apr 2003 00:30:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_681555120P
Content-Type: text/plain; charset=us-ascii

On Wed, 23 Apr 2003 22:29:05 EDT, Pat Suwalski said:
> I have not seen a computer in the last year and a half that has not had 
> either onboard sound or a card. It is very standard hardware these days. 
> Therefore, your soundcard should work just like your keyboard does. You 
> do not have to add any lines to any rc script to get the keyboard 
> working, do you? Sound should not have to be any different, in an ideal 
> world.

Users come in two basic flavors - distro based users and people who roll
their own kernels.  For the distro users, it really doesn't matter WHAT
we do, as the distro can patch the kernel and userspace how they want.

If you're a roll-your-own, you don't have to add lines to an rc script
to get the keyboard working - but you DO have to do the CONFIG_INPUT thing. ;)

--==_Exmh_681555120P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+p2h4cC3lWbTT17ARAnFnAKDNN8XJK7ViYtwRfRt7I7P+XrbtkACgo9IV
0bb6LUQBhUvUg6TO1sJ1bh0=
=EQ6h
-----END PGP SIGNATURE-----

--==_Exmh_681555120P--
