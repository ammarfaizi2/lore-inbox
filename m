Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316163AbSFDDXb>; Mon, 3 Jun 2002 23:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316167AbSFDDXa>; Mon, 3 Jun 2002 23:23:30 -0400
Received: from mail201.mail.bellsouth.net ([205.152.58.141]:25104 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S316163AbSFDDX3>; Mon, 3 Jun 2002 23:23:29 -0400
Message-ID: <3CFC32AB.F5766BCE@bellsouth.net>
Date: Mon, 03 Jun 2002 23:23:23 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        "linux-i2c@tk.uni-linz.ac.at" <linux-i2c@tk.uni-linz.ac.at>
Subject: [patch]2.5.20 i2c updates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
The attached patch updates printk messages, adds proc to read smbus block data, add check if we are in kernel 2.4 or
greater, then use lock/unlock_kernel instead of MOD_DEC_USE_COUNT, adds I2C versioning.
Thanks,
Albert
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
