Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVC2Ev2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVC2Ev2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 23:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVC2Ev1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 23:51:27 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:44177 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262185AbVC2EvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 23:51:11 -0500
Subject: Re: sched_setscheduler() and usage issues ....please help
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arun Srinivas <getarunsri@hotmail.com>, nickpiggin@yahoo.com.au,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1112071215.3691.27.camel@localhost.localdomain>
References: <BAY10-F472EE1F6A6F80FEA2F5568D9450@phx.gbl>
	 <1112071215.3691.27.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 23:51:07 -0500
Message-Id: <1112071867.19014.30.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 23:40 -0500, Steven Rostedt wrote:
> On Tue, 2005-03-29 at 08:58 +0530, Arun Srinivas wrote:
> > I am trying to set the SCHED_FIFO  policy for my process.I am using 
> > sched_setscheduler() function to do this.
> 
> Attached is a little program that I use to set the priority of tasks.

Why not just use chrt from schedtools?

Lee

