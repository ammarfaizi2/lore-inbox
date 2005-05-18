Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVERGLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVERGLJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 02:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVERGLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 02:11:09 -0400
Received: from h80ad263e.async.vt.edu ([128.173.38.62]:50181 "EHLO
	h80ad263e.async.vt.edu") by vger.kernel.org with ESMTP
	id S262104AbVERGK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 02:10:59 -0400
Message-Id: <200505180610.j4I6AdsY004305@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Resources on Networking 
In-Reply-To: Your message of "Wed, 18 May 2005 10:19:15 +0530."
             <428AC94B.2020403@globaledgesoft.com> 
From: Valdis.Kletnieks@vt.edu
References: <428AC94B.2020403@globaledgesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116396638_3369P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 18 May 2005 02:10:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116396638_3369P
Content-Type: text/plain; charset=us-ascii

On Wed, 18 May 2005 10:19:15 +0530, krishna said:
> Hi All,
> 
> I am Interested in _understanding_ Networking.

"To understand the network, you must the network.." 

If you want to *understand* the network, I'd suggest starting off with a very
heavy dose of math, in particularly emergent systems:

http://en.wikipedia.org/wiki/Emergence has a lot of good references.

However, you probably meant "understanding how to get the network to do something
useful for me", which is a totally different question....

> Can any one tell me the resources of Networking.

Not a Linux kernel issue, but I'll be nice (even sorted in likely order
of usefulness for somebody so in need of direction):

0) A good book on C. (Yes, we start at 0. C, remember?)

1) Stevens "Unix Network Programming"

2) Douglas Comer "Internetworking with TCP/IP (Volume I): Protocol and Architecture"

3) http://www.ietf.org/rfc - in particular, you want RFCs 768, 791, 792, 793, and 1149

4) find /usr/src/linux/net -type f | xargs more


--==_Exmh_1116396638_3369P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCitxdcC3lWbTT17ARAgL9AKDezg1HEIzchonQPKKT+R4C8dDaBgCgntz0
mF/wDC3OjVXghNKCOrWB++o=
=pcLt
-----END PGP SIGNATURE-----

--==_Exmh_1116396638_3369P--
