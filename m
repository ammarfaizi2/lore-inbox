Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSE2T6a>; Wed, 29 May 2002 15:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSE2T63>; Wed, 29 May 2002 15:58:29 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:16132 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S315451AbSE2T62>; Wed, 29 May 2002 15:58:28 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: lkml <linux-kernel@vger.kernel.org>
Message-ID: <86256BC8.006DB41A.00@smtpnotes.altec.com>
Date: Wed, 29 May 2002 14:55:31 -0500
Subject: ufs compile error in 2.5.19
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



truncate.c: In function `ufs_truncate':
truncate.c:456: `tq_disk' undeclared (first use in this function)
truncate.c:456: (Each undeclared identifier is reported only once
truncate.c:456: for each function it appears in.)
make[2]: *** [truncate.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.19/fs/ufs'


