Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262579AbREZDRA>; Fri, 25 May 2001 23:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262585AbREZDQu>; Fri, 25 May 2001 23:16:50 -0400
Received: from smtp5vepub.gte.net ([206.46.170.26]:56340 "EHLO
	smtp5ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S262579AbREZDQp>; Fri, 25 May 2001 23:16:45 -0400
From: George France <france@handhelds.org>
Date: Fri, 25 May 2001 23:16:34 -0400
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
To: Andrea Arcangeli <andrea@suse.de>, Jay Thorne <Yohimbe@userfriendly.org>
In-Reply-To: <990827407.27355.2.camel@gracie.userfriendly.org> <990836703.27355.6.camel@gracie.userfriendly.org> <20010526025119.L9634@athlon.random>
In-Reply-To: <20010526025119.L9634@athlon.random>
Subject: Re: PROBLEM: Alpha SMP Low Outbound Bandwidth
MIME-Version: 1.0
Message-Id: <01052523163402.28075@shadowfax.middleearth>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

Jay, if the problem still exist in 2.4.5-pre6aa1 (please try the new kernel), 
then I will have tech op's check this on Tuesday (Monday is a US holiday).  
We should be able to duplicate this in the hardware lab and find the problem 
with a logic analyser.

Best Regards,


--George

On Friday 25 May 2001 20:51, Andrea Arcangeli wrote:
> On Fri, May 25, 2001 at 05:25:03PM -0700, Jay Thorne wrote:
> > But Wu-ftpd is an easy to set up test bench, and is ubiquitous enough
> > that anyone with an alpha running SMP can test it. Note that this
>
> My smp alpha box drives a single tulip over 12MB/sec in full duplex
> using tcp without any problem at all. So I definitely cannot reproduce.
> You may want to try to reproduce with 2.4.5pre6aa1 btw. If you've not
> tried it yet you can consider also using egcs 1.1.2 as compiler just in
> case.
>
> You may also want to keep an eye on the VM, on alpha I see very weird
> things happening.
>
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
