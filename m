Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUBOWYG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 17:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUBOWYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 17:24:06 -0500
Received: from lpbproductions.com ([68.98.208.147]:55179 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S265230AbUBOWYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 17:24:02 -0500
From: "Matt H." <lkml@lpbproductions.com>
To: linux-kernel@vger.kernel.org
Subject: Re: stable/vanilla+(O)1
Date: Sun, 15 Feb 2004 15:26:31 -0700
User-Agent: KMail/1.5.94
References: <20040215220454.GL14140@riseup.net>
In-Reply-To: <20040215220454.GL14140@riseup.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402151526.31560.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's recommened you use 2.6.x if you want the O1 scheduler and newer things. 
You can also use the -aa patchset for 2.4 , that contains the O1 Scheduler 
and some vm tweaks.


Matt H.


On Sunday 15 February 2004 3:04 pm, Micah Anderson wrote:
> Is there a patch to the stable/vanilla 2.4 kernel tree which provides
> the O(1) scheduler code from 2.6? The closest thing I can find is:
>
> http://people.redhat.com/mingo/O(1)-scheduler/sched-HT-2.4.22-ac1-A0
>
> which is for AC (and is also A0), is there a newer 2.4.23/24 patch
> that works against stock? The above patch fails miserably against a
> stock 2.4.22 kernel.
>
> There is ftp://ftp.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/
> the latest which is sched-O1-rml-2.4.20-rc3-1.patch, but that too
> fails horribly on a stock 2.4.22.
>
> I've been crawling through list archives, but have yet to find
> anything, so I am reduced to asking. :)
>
> micah
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
