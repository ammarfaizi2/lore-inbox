Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVEMIUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVEMIUo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 04:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbVEMIUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 04:20:42 -0400
Received: from h80ad24d2.async.vt.edu ([128.173.36.210]:41233 "EHLO
	h80ad24d2.async.vt.edu") by vger.kernel.org with ESMTP
	id S262300AbVEMIUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 04:20:03 -0400
Message-Id: <200505130819.j4D8Jnh1020567@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Nauman <mailtonauman@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6 project compilation and GCC attribs?? 
In-Reply-To: Your message of "Fri, 13 May 2005 12:57:03 +0500."
             <3cac075b0505130057466381e1@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <3cac075b0505130057466381e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115972384_3671P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 13 May 2005 04:19:47 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115972384_3671P
Content-Type: text/plain; charset=us-ascii

On Fri, 13 May 2005 12:57:03 +0500, Nauman said:

> when i use ( x < y ? 5:10)
> with x=1 and y=2
> the result i get is x = 10: ( 

1) This isn't a kernel problem, this is an introductory C problem.

2) Even if it *were* a kernel problem, you'd have to show us at least
2-3 *complete* lines so we can figure out what the heck you're talking
about.  "When I use" doesn't tell us anything, "I get x = 10" can't happen
because you don't actually assign to x anyplace in that fragment, and so on.

3) Since you're working in userspace, printf() is your debugging friend,
and 'gdb' (and GUI's on top of it like 'ddd') are your other debugging friend. 

--==_Exmh_1115972384_3671P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFChGMgcC3lWbTT17ARAt2UAJ9Aw3cC5AdhkGSbqr0ErOyCEUot+ACcCt85
JA/Ry9er6Nkh880/G+IkB0U=
=wKau
-----END PGP SIGNATURE-----

--==_Exmh_1115972384_3671P--
