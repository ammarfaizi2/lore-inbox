Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130004AbRBAW7w>; Thu, 1 Feb 2001 17:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130674AbRBAW7m>; Thu, 1 Feb 2001 17:59:42 -0500
Received: from mail5.svr.pol.co.uk ([195.92.193.20]:41282 "EHLO
	mail5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S130062AbRBAW7Y>; Thu, 1 Feb 2001 17:59:24 -0500
Date: Thu, 1 Feb 2001 15:09:37 GMT
From: James Stevenson <mistral@stev.org>
Message-Id: <200102011509.f11F9bV13547@cyrix.home>
To: nils@ipe.uni-stuttgart.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: What does "NAT: dropping untracked packet" mean?
In-Reply-To: <20010201133811.D14768@ipe.uni-stuttgart.de>
In-Reply-To: <20010201133811.D14768@ipe.uni-stuttgart.de>
Reply-To: mistral@stev.org
X-BadReturnPath: mistral@cyrix.home rewritten as mistral@stev.org
  using "Reply-To" header
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi

do the messages apear when the windows machines a booting ?
i would tend to think that the kernel cannot handle the NET on
IGMP packets so its printting a message about it
the packets do look like they are goign to a multicast address


>
>Feb  1 12:58:56 obelix kernel: NAT: 0 dropping untracked packet ce767600 1 129.69.22.21 -> 224.0.0.2
>Feb  1 12:59:01 obelix kernel: NAT: 0 dropping untracked packet ce767480 1 129.69.22.21 -> 224.0.0.2
>Feb  1 12:59:04 obelix kernel: NAT: 0 dropping untracked packet ce767d80 1 129.69.22.21 -> 224.0.0.2
>Feb  1 13:00:44 obelix kernel: NAT: 0 dropping untracked packet ce767600 1 129.69.22.51 -> 224.0.0.2
>Feb  1 13:00:47 obelix kernel: NAT: 0 dropping untracked packet ce767600 1 129.69.22.51 -> 224.0.0.2
>Feb  1 13:00:50 obelix kernel: NAT: 0 dropping untracked packet ce767b40 1 129.69.22.51 -> 224.0.0.2
>


-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
  3:00pm  up 16 days, 22:21,  4 users,  load average: 1.37, 1.38, 1.25
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
