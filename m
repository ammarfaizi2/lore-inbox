Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWEDV3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWEDV3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWEDV3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:29:30 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:58817 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751401AbWEDV33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:29:29 -0400
Message-Id: <200605042129.k44LTSXa022256@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: grfgguvf.29601511@bloglines.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird framebuffer bug? 
In-Reply-To: Your message of "Thu, 04 May 2006 21:24:53 -0000."
             <1146777893.3982259993.25862.sendItem@bloglines.com> 
From: Valdis.Kletnieks@vt.edu
References: <1146777893.3982259993.25862.sendItem@bloglines.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1146778168_2700P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 04 May 2006 17:29:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1146778168_2700P
Content-Type: text/plain; charset=us-ascii

On Thu, 04 May 2006 21:24:53 -0000, grfgguvf.29601511@bloglines.com said:
> I am having a really strange bug where every fifth or so vertical line
> is not displayed when running X using the framebuffer (so the right fifth
> of the screen is also left black). And it's not the monitor settings. If the
> image is stretched to fill the screen the lines are still omitted (It's an
> LCD and it interpolates the lines so the whole image looks blurred).

I'll bite.  Have you tried using a configuration that specifies the *actual*
LCD resolution so it doesn't have to interpolate?  It could be that the
interpolation hardware is buggy.

--==_Exmh_1146778168_2700P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEWnI3cC3lWbTT17ARAnPXAJ9kU2Cvy7ZUQr6dPbhXSGy0bCAz4ACgmBI4
ZXaR8yeHv4/pbZTDgmqAwkk=
=0BuW
-----END PGP SIGNATURE-----

--==_Exmh_1146778168_2700P--
