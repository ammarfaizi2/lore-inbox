Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbSBRUKK>; Mon, 18 Feb 2002 15:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285093AbSBRUKA>; Mon, 18 Feb 2002 15:10:00 -0500
Received: from pak218.pakuni.net ([207.91.34.218]:48649 "EHLO linuxtr.net")
	by vger.kernel.org with ESMTP id <S284305AbSBRUJq>;
	Mon, 18 Feb 2002 15:09:46 -0500
Date: Mon, 18 Feb 2002 14:58:21 -0600 (CST)
From: Mike Phillips <mikep@linuxtr.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] New driver 3Com 3C359 Tokenring Velocity XL
Message-ID: <Pine.LNX.4.10.10202181451060.4149-100000@www.linuxtr.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

The driver for the 3c359 adapter has been tested in the wild for several
months now and ready for inclusion in the kernel.

The patch itself is fairly large due to the microcode required for the
adapter, so links provided rather than including in this email.

2.4.17:

plain: http://www.linuxtr.net/download/3com/3c359-2.4.17.patch
gzip: http://www.linuxtr.net/download/3com/3c359-2.4.17.patch.gz

2.5.5pre1

plain: http://www.linuxtr.net/download/3com/3c359-2.5.5pre1.patch
gzip: http://www.linuxtr.net/download/3com/3c359-2.5.5pre1.patch.gz

The only difference between the 2.4.17 and 2.5.5pre1 patch is the part
for the Configure.help / Config.help files.

Thanks to 3Com for providing the tech docs for the adapter and to all the
beta testers for the driver.

Thanks
Mike Phillips
Linux Token Ring Project
http://www.linuxtr.net


