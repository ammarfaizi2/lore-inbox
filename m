Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVC2Lko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVC2Lko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVC2Lkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:40:43 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:19945 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262227AbVC2Ljj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:39:39 -0500
Date: Tue, 29 Mar 2005 13:38:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Lee Revell <rlrevell@joe-job.com>, Arun Srinivas <getarunsri@hotmail.com>,
       nickpiggin@yahoo.com.au, LKML <linux-kernel@vger.kernel.org>
Subject: Re: sched_setscheduler() and usage issues ....please help
In-Reply-To: <1112096147.3691.35.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0503291338160.19483@yvahk01.tjqt.qr>
References: <BAY10-F472EE1F6A6F80FEA2F5568D9450@phx.gbl> 
 <1112071215.3691.27.camel@localhost.localdomain>  <1112071867.19014.30.camel@mindpipe>
  <Pine.LNX.4.61.0503290802170.25114@yvahk01.tjqt.qr>
 <1112096147.3691.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>OK, I'm a little embarrassed. I never saw this tool. I use debian

You don't need to be. Before I got to know of this tool, I also wrote my own.
Look for "schedutils".

>unstable, but didn't have the package loaded.  I did a apropos on
>sched_setscheduler, and it didn't come up with any tools, so I just
>wrote my own!



Jan Engelhardt
-- 
No TOFU for me, please.
