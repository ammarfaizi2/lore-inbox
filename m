Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267834AbRGUWNH>; Sat, 21 Jul 2001 18:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267837AbRGUWM5>; Sat, 21 Jul 2001 18:12:57 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:30127 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S267834AbRGUWMs>;
	Sat, 21 Jul 2001 18:12:48 -0400
Message-ID: <3B59FE8B.CEB83605@mandrakesoft.com>
Date: Sat, 21 Jul 2001 18:13:31 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Griesser <tuxx@aon.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another 2.4.7 build failure
In-Reply-To: <20010721222826.A1953@lucretia.debian.net> <20010722000203.A25593@aon.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alexander Griesser wrote:
> 
> On Sat, Jul 21, 2001 at 10:28:26PM +0200, you wrote:
> > Building fails for me with following error:
> > ll_rw_blk.c:25: linux/completion.h: No such file or directory
> 
> Maybe a bad patch?
> $TOPDIR/include/linux/completion.h exists, at least on my platform :)

sounds like someone forgot a 'cvs add' or similar...

-- 
Jeff Garzik      | "I wouldn't be so judgemental
Building 1024    |  if you weren't such a sick freak."
MandrakeSoft     |             -- goats.com
