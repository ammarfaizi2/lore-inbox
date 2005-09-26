Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVIZHwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVIZHwR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 03:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVIZHwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 03:52:17 -0400
Received: from h80ad2501.async.vt.edu ([128.173.37.1]:20375 "EHLO
	h80ad2501.async.vt.edu") by vger.kernel.org with ESMTP
	id S1750739AbVIZHwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 03:52:16 -0400
Message-Id: <200509260752.j8Q7q6qa005465@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "Woody.Wu" <Woody.Wu@cn.landisgyr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Compilation Question 
In-Reply-To: Your message of "Mon, 26 Sep 2005 09:00:44 +0200."
             <7567C3A4682B894C99E5E16494442680010AD310@cnzhuex01.cn.landisgyr.com> 
From: Valdis.Kletnieks@vt.edu
References: <7567C3A4682B894C99E5E16494442680010AD310@cnzhuex01.cn.landisgyr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127721125_3307P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Sep 2005 03:52:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127721125_3307P
Content-Type: text/plain; charset=us-ascii

On Mon, 26 Sep 2005 09:00:44 +0200, "Woody.Wu" said:
> i got a RedHat box which running a 2.2.x kernel.  since its too old, i
> decided to upgrade it to 2.6.x, but this might involving upgrading of
> gcc, libc and lots of other things.  i don't want to bother to do that
> and think i can build a kernel in another newer system (a slackware
> running 2.6.x) and copy needed stuff over to the old box.  is it
> possible? 

If it's a RedHat old enough to include a 2.2 kernel, and you have to ask if
it's doable, I can *guarantee* that you don't have the technical experience
to track down all the little details.  That's a long time ago, and there will
be all sorts of little tiny things (for instance, if you use ipchains, you'll
need to switch to ipfilter instead).

It's possible, but by the time you chase down all the pre-requisites and
co-requisites, you will be better off just actually upgrading to something
more recent - even if you get it to work, you get all the joy the *NEXT* time
you have to make a system change.



--==_Exmh_1127721125_3307P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDN6ilcC3lWbTT17ARAkmbAJ4oSE9DoE20PghxGqtz7lICeuz1jgCg8RJw
UeD3qI2AiIVeOeRnYAb1SXE=
=fwFH
-----END PGP SIGNATURE-----

--==_Exmh_1127721125_3307P--
