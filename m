Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWEQB1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWEQB1r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 21:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWEQB1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 21:27:46 -0400
Received: from pool-71-254-71-216.ronkva.east.verizon.net ([71.254.71.216]:29380
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932411AbWEQB1q (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 21:27:46 -0400
Message-Id: <200605170127.k4H1RLAS011291@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wiretapping Linux?
In-Reply-To: Your message of "Tue, 16 May 2006 06:24:38 PDT."
             <4469D296.8060908@perkel.com>
From: Valdis.Kletnieks@vt.edu
References: <4469D296.8060908@perkel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147829241_4166P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 16 May 2006 21:27:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1147829241_4166P
Content-Type: text/plain; charset=us-ascii

On Tue, 16 May 2006 06:24:38 PDT, Marc Perkel said:
> So what about Linux? With thousands of people working on the Kernel if 
> someone from the NSA wanted to slip a back door into the Kernel, could 
> the do that?

Actually, if the NSA wanted to slip in a back door, they'd have done so
in the SELinux code. :)

As others have mentioned, the kernel code isn't the best place to try
to put a back door in, precisely because of the depth of scrutiny.  A
much more likely avenue is to backdoor some popular userspace code (as
did happen to Sendmail and OpenSSH within a few weeks of each other a
few years ago).

And then there's the Underhanded C Code contest:

http://www.brainhz.com/underhanded/

:)

--==_Exmh_1147829241_4166P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEanv5cC3lWbTT17ARAsYwAJ0cRn76A7VCneMrcVZgZb9Yc5GHhACfZlYx
7Mko1vgk2l5JQ5qAW1tEjwM=
=dlz+
-----END PGP SIGNATURE-----

--==_Exmh_1147829241_4166P--
