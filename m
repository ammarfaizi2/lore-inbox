Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265615AbSIWL6D>; Mon, 23 Sep 2002 07:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265671AbSIWL6C>; Mon, 23 Sep 2002 07:58:02 -0400
Received: from mta.sara.nl ([145.100.16.144]:54147 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S265615AbSIWL6B>;
	Mon, 23 Sep 2002 07:58:01 -0400
Date: Mon, 23 Sep 2002 14:03:02 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: 2.5.38 on ppc/prep
From: Remco Post <r.post@sara.nl>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <692386AC-CEEC-11D6-A08A-000393911DE2@sara.nl>
X-Pgp-Agent: GPGMail 0.5.3 (v20)
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

after some tiny fixes to reiserfs and the makefile for prep bootfile 
(using ../lib/lib.a vs. ../lib/libz.a) I managed to succesfully compile 
a kernel. It even boots to the point where it frees unused kernel memory 
and then stops... this includes succesfully mounting the root 
filesystem...

Just to let the world know what does and doesn't work on my powerstack 
mobo.

- --
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167
PGP keys at http://home.sara.nl/~remco/keys.asc

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (Darwin)

iD8DBQE9jwL/BIoCv9yTlOwRAkGMAKC1mv8cF2kfVIWOWruxjLQMGXSgIgCghGQi
tkJONCA76Lz9dWmJPzOc9pg=
=yOO+
-----END PGP SIGNATURE-----

