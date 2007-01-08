Return-Path: <linux-kernel-owner+w=401wt.eu-S1751100AbXAHTzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbXAHTzE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 14:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbXAHTzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 14:55:04 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:42100 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbXAHTzB (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 14:55:01 -0500
Message-Id: <200701081953.l08JrANJ031784@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Willy Tarreau <w@1wt.eu>
Cc: Adrian Bunk <bunk@stusta.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
In-Reply-To: Your message of "Mon, 08 Jan 2007 01:38:57 +0100."
             <20070108003857.GE435@1wt.eu>
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr> <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc> <1168182838.14763.24.camel@shinybook.infradead.org> <20070107153833.GA21133@flint.arm.linux.org.uk> <1168187346.14763.70.camel@shinybook.infradead.org> <20070107170656.GC21133@flint.arm.linux.org.uk> <Pine.LNX.4.61.0701072009430.4365@yvahk01.tjqt.qr> <20070107204834.GU24090@1wt.eu> <20070107233750.GL20714@stusta.de>
            <20070108003857.GE435@1wt.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168285990_27349P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Jan 2007 14:53:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168285990_27349P
Content-Type: text/plain; charset=us-ascii

On Mon, 08 Jan 2007 01:38:57 +0100, Willy Tarreau said:
> it's clearly the proof of a flaw in the initial design. And I'm not even
> discussing the stupidity which requires that you read a whole text to get
> its number of characters !

It's no more stupid than the *current* situation with Linux kernel code, where
the stupidity actually requires that even if you know that there are only 60
characters on a given line, you actually have to look at each one in order to
figure out if the line goes past column 80....


--==_Exmh_1168285990_27349P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFoqEmcC3lWbTT17ARAsOoAKCLgFBrqJtxDRKwP6JKpzsCQ+Z3wwCg85sw
HDs+Vq3rpLHHU9vibEkUejw=
=MLBN
-----END PGP SIGNATURE-----

--==_Exmh_1168285990_27349P--
