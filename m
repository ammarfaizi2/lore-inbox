Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132286AbRAHTlQ>; Mon, 8 Jan 2001 14:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131547AbRAHTlH>; Mon, 8 Jan 2001 14:41:07 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1540 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131358AbRAHTkx>;
	Mon, 8 Jan 2001 14:40:53 -0500
Message-ID: <20010105234604.C301@bug.ucw.cz>
Date: Fri, 5 Jan 2001 23:46:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: adefacc@tin.it, linux-kernel@vger.kernel.org
Subject: Re: Confirmation request about new 2.4.x. kernel limits
In-Reply-To: <3A546385.C50B1092@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A546385.C50B1092@tin.it>; from A.D.F. on Thu, Jan 04, 2001 at 11:50:29AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi, I would like to know whether following limits are right for kernel
> 2.4.x:
> 
> Max. N. of CPU:			32	(SMP)
> Max. CPU speed:			> 2 Ghz	(up to ?)
> Max. RAM size:			64 GB	(any slowness accessing RAM over 4 GB
> 					 with 32 bit machines ?)

64GB on i386. I believe you can get few terabytes with ultrasparc.

> Max. file size:	 		1 TB	(?)
> Max. file system size:		2 TB	(?)

Again, maybe on i386 with ext2.
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
