Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSHGC0F>; Tue, 6 Aug 2002 22:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316623AbSHGC0F>; Tue, 6 Aug 2002 22:26:05 -0400
Received: from dsl-213-023-062-078.arcor-ip.net ([213.23.62.78]:8709 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S316621AbSHGC0F>;
	Tue, 6 Aug 2002 22:26:05 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Noticable improvements with DVD-RAM (slow devices) in 2.4.19
Date: Wed, 7 Aug 2002 04:30:21 +0200
User-Agent: KMail/1.4.1
X-PGP-KeyID: 0x561D4FD2
X-PGP-Key: http://www.lionking.org/~kiza/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208070430.55809.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

some long time ago I posted this on linux kernel 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0102.0/0880.html. Short 
description: writing huge amounts of data to the DVD-RAM will slow down/hang 
the system for up to some minutes while transferring data. This problem got 
slightly better with the 2.4 series but was still a problem most of the time.

Now with 2.4.19 this has improved _significantly_. The system probably slows 
down for a couple of seconds during the data transfer, but that's all. It's 
almost perfectly usable otherwise. Thank you everyone. 2.4.19 is probably the 
best kernel until now... at least for me. :)

Bye

- -- 
Oliver Feiler  <kiza@(gmx(pro).net|lionking.org|claws-and-paws.com)>
http://www.lionking.org/~kiza/  <--   homepage
PGP-key ID 0x561D4FD2    --> /pgpkey.shtml
http://www.lionking.org/~kiza/journal/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9UIZfOpifZVYdT9IRAnGGAJ4jQFjObvoZsZ1/qHyeC4M7SXf7vACgvJ8H
xQEg66pd3umXzCd2mEkQb2Y=
=VcB4
-----END PGP SIGNATURE-----

