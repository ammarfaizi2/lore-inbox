Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUFBR53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUFBR53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 13:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUFBRy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:54:27 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:61825 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263776AbUFBRw5 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:52:57 -0400
Message-Id: <200406021752.i52Hqtks024484@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why swap at all? 
In-Reply-To: Your message of "Wed, 02 Jun 2004 01:17:06 +0200."
             <E1BVIVG-0003wL-00@calista.eckenfels.6bone.ka-ip.net> 
From: Valdis.Kletnieks@vt.edu
References: <E1BVIVG-0003wL-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1354917434P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Jun 2004 13:52:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1354917434P
Content-Type: text/plain; charset=us-ascii

On Wed, 02 Jun 2004 01:17:06 +0200, Bernd Eckenfels <ecki-news2004-05@lina.inka.de>  said:

> Yes but: your wm is so  often used/activated it will not get swaped  out. 
> But if your mouse passes over mozilla and tries to focus it, then you will
> feel the pain of a swapped-out x program.

Yes, I'm quite familiar with what a swapped-out mozilla does to my laptop ;)

The point I was making (apparently poorly) was that if mozilla is swapping in,
*that window* is hosed, but if the WM or the X server is swapping in,
*everything* is hosed.

And I *have* had times when I've left for an extended period while Mozilla
is downloading a Knoppix .iso or similar beastly large thing, and it managed
to keep Mozilla pages hot because it was busy doing a download, and the WM
pages got swapped out because the WM wasn't actually doing anything...

Yes, it's a rare state of affairs, but it *has* happened...

--==_Exmh_1354917434P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAvhP3cC3lWbTT17ARAn3MAJ4ybvDbILuVbILyueNoKXP9rYvLQwCfbJUG
uCccIIjDCQdkHZtCEVA1etU=
=C1vk
-----END PGP SIGNATURE-----

--==_Exmh_1354917434P--
