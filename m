Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265579AbUAZGZT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 01:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265581AbUAZGZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 01:25:19 -0500
Received: from h80ad25ed.async.vt.edu ([128.173.37.237]:64961 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265579AbUAZGZP (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 01:25:15 -0500
Message-Id: <200401260625.i0Q6P4op023127@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Steve Youngs <sryoungs@bigpond.net.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: (as177) Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core 
In-Reply-To: Your message of "Mon, 26 Jan 2004 15:55:06 +1000."
             <microsoft-free.87d697s18l.fsf@eicq.dnsalias.org> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org> <Pine.LNX.4.58.0401251054340.18932@home.osdl.org> <microsoft-free.877jzfoc5h.fsf@eicq.dnsalias.org> <20040125222242.A24443@mail.kroptech.com> <microsoft-free.87hdyjs3h3.fsf@eicq.dnsalias.org> <200401260521.i0Q5LRha021370@turing-police.cc.vt.edu>
            <microsoft-free.87d697s18l.fsf@eicq.dnsalias.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-997692841P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jan 2004 01:25:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-997692841P
Content-Type: text/plain; charset=us-ascii

On Mon, 26 Jan 2004 15:55:06 +1000, Steve Youngs <sryoungs@bigpond.net.au>  said:

> Because the 2nd user is still using the module so its in-use bit
> should still be set.  Remember that when the module was first loaded
> it registered a function with the kernel for testing whether the
> module is in use.

Anybody who's ever been in a bathroom stall and somebody turned off the
lights on their way out will intuitively understand why you need a reference
count and not an in-use bit,

--==_Exmh_-997692841P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAFLK/cC3lWbTT17ARApDUAJsHMnrydJcKRp73jfUO/c9r8WeDQwCdFomr
AhbH9FOdPWHZBJj8bHOHwL8=
=/yj6
-----END PGP SIGNATURE-----

--==_Exmh_-997692841P--
