Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268221AbTALD7R>; Sat, 11 Jan 2003 22:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268222AbTALD7R>; Sat, 11 Jan 2003 22:59:17 -0500
Received: from h80ad2641.async.vt.edu ([128.173.38.65]:24960 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S268221AbTALD7O>; Sat, 11 Jan 2003 22:59:14 -0500
Message-Id: <200301120407.h0C47oLE030404@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Christoph Hellwig <hch@lst.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't create regular files in devfs 
In-Reply-To: Your message of "Sat, 11 Jan 2003 20:56:00 +0100."
             <20030111205600.A25947@lst.de> 
From: Valdis.Kletnieks@vt.edu
References: <20030111205600.A25947@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1023107510P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 11 Jan 2003 23:07:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1023107510P
Content-Type: text/plain; charset=us-ascii

On Sat, 11 Jan 2003 20:56:00 +0100, Christoph Hellwig said:
> Even more devfs creptomancy :)

> Get rid of it.

> -	printk(KERN_INFO 
> -		"IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n", 
> -		MICROCODE_VERSION);

Did you intend to nuke this too?  Personally, I prefer having all the
drivers tell me what they are....
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_1023107510P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+IOoWcC3lWbTT17ARAqOyAKC31QG64ZtLMH/rKcwwPg6E0ZWs7QCgiUYo
R8u1Naje9bQoKiiNDdNaYNQ=
=/bw/
-----END PGP SIGNATURE-----

--==_Exmh_1023107510P--
