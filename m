Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSHQPrO>; Sat, 17 Aug 2002 11:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSHQPrO>; Sat, 17 Aug 2002 11:47:14 -0400
Received: from protactinium.btinternet.com ([194.73.73.176]:16783 "EHLO
	protactinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S314078AbSHQPrN>; Sat, 17 Aug 2002 11:47:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Benjamin Geer <ben@beroul.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 ATAPI cdrom I/O errors when reading CD-R
Date: Sat, 17 Aug 2002 16:45:14 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Adrian Bunk" <bunk@fs.tum.de>, "Jean Delvare" <khali@linux-fr.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17g5r5-0005LJ-00@protactinium.btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002, Adrian Bunk wrote:
> 3. it costs much time to compile try let's say 40 different kernels

I actually don't mind compiling and trying lots of different kernels.  
It's a fast machine; I could set it up to compile a lot of kernels 
overnight, and in the morning it would just take a few minutes per kernel 
to install, reboot, and see if the problem is still there.

> Someone with a better knowledge of ATAPI might be able to understand 
> what the error messages say and to either understand the problem or to
> tell how to trace it down.

That would be really helpful.  This problem seems to occur for me with 
all CD-Rs burnt under Windows using Adaptec DirectCD.

I would also be happy to apply kernel patches and retest.  Is there 
anyone familiar with the ATAPI code in the kernel who could provide some 
guidance?

Ben

