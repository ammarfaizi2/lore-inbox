Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUAOStN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 13:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUAOStN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 13:49:13 -0500
Received: from [128.173.54.129] ([128.173.54.129]:386 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261190AbUAOStL (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 13:49:11 -0500
Message-Id: <200401151849.i0FIn5gF010726@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Tim Cambrant <tim@cambrant.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: True story: "gconfig" removed root folder... 
In-Reply-To: Your message of "Thu, 15 Jan 2004 19:31:25 +0100."
             <20040115183125.GA5772@cambrant.com> 
From: Valdis.Kletnieks@vt.edu
References: <1074177405.3131.10.camel@oebilgen> <Pine.LNX.4.58.0401151558590.27223@serv> <87ptdl2q7l.fsf@asmodeus.mcnaught.org> <slrnc0dct5.2o5.erik@bender.home.hensema.net> <20040115160759.GA5458@cambrant.com> <200401151617.i0FGHW1a005870@turing-police.cc.vt.edu>
            <20040115183125.GA5772@cambrant.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1606210233P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Jan 2004 13:49:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1606210233P
Content-Type: text/plain; charset=us-ascii

On Thu, 15 Jan 2004 19:31:25 +0100, Tim Cambrant said:

> I'm not sure if I understand you correctly, and you might mean
> that the problem in make gconfig isn't fixed. That's true, but

Right.  It's not fixed.

> I'm not the maintainer so I'm just trying to help you find a
> solution that will work for now.

Well, unfortunately, saying "Well, don't do that then" is about as much of a
workaround as we can manage till gconfig actually gets fixed.

What I'm worried about is a semi-clued user who will read the lkml archives,
see the "just do this" discussion, and think that it's actually a fix rather than
a retargeting of the ICBM ;)

--==_Exmh_-1606210233P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFABuChcC3lWbTT17ARAvUOAKD+uUrRHu58tWVL5MwmucDlCXAR1ACgnVFn
0Kxud8qmyYRUHaz0tdn14RA=
=c4UQ
-----END PGP SIGNATURE-----

--==_Exmh_-1606210233P--
