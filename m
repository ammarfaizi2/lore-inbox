Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVC2GD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVC2GD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 01:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVC2GD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 01:03:58 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:51150 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262443AbVC2GDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 01:03:55 -0500
Date: Tue, 29 Mar 2005 08:03:14 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Steven Rostedt <rostedt@goodmis.org>,
       Arun Srinivas <getarunsri@hotmail.com>, nickpiggin@yahoo.com.au,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: sched_setscheduler() and usage issues ....please help
In-Reply-To: <1112071867.19014.30.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0503290802170.25114@yvahk01.tjqt.qr>
References: <BAY10-F472EE1F6A6F80FEA2F5568D9450@phx.gbl> 
 <1112071215.3691.27.camel@localhost.localdomain> <1112071867.19014.30.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I am trying to set the SCHED_FIFO  policy for my process.I am using 
>> > sched_setscheduler() function to do this.
>> 
>> Attached is a little program that I use to set the priority of tasks.
>
>Why not just use chrt from schedtools?

Not every distro has it yet, and I like to point out that a lot of users is 
still using "older" distros, such as FC2, SUSE 9.1, and also olders with Linux 
2.4 kernels.



Jan Engelhardt
-- 
No TOFU for me, please.
