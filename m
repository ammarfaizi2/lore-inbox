Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132120AbRBBAKo>; Thu, 1 Feb 2001 19:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132199AbRBBAKh>; Thu, 1 Feb 2001 19:10:37 -0500
Received: from theirongiant.zip.net.au ([61.8.0.198]:2309 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S132120AbRBBAKU>; Thu, 1 Feb 2001 19:10:20 -0500
Date: Fri, 2 Feb 2001 11:09:07 +1100
From: CaT <cat@zip.com.au>
To: Jagan_Pochimireddy@3com.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel ver 2.4.1 VFS problem
Message-ID: <20010202110907.A365@zip.com.au>
In-Reply-To: <882569E6.0083B746.00@hqoutbound.ops.3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <882569E6.0083B746.00@hqoutbound.ops.3com.com>; from Jagan_Pochimireddy@3com.com on Thu, Feb 01, 2001 at 03:58:58PM -0800
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 03:58:58PM -0800, Jagan_Pochimireddy@3com.com wrote:
> I wamt to use the latest kernel version 2.4.1 . I taken defualt configuration
> and built bzImage. When I try to boot with this image it's giving message like
> this.
> 
> " VFS:Unable to mount root device 805 or 8:05"
> kernel panic "VFS:please append correct "root=\"
> "VFS:Unable to open root device"
> 
> Can any body help me where could be the problem

Do you have the correct SCSI driver compiled into your kernel? A friend
of mine had a similar problem and that was the solution (he thought the 
card was one thing but it was another).

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
