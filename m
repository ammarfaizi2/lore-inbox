Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVC3SJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVC3SJr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVC3SJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:09:47 -0500
Received: from bay10-f13.bay10.hotmail.com ([64.4.37.13]:28960 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262370AbVC3SJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:09:35 -0500
Message-ID: <BAY10-F131BE888B1B9501BEB344DD9460@phx.gbl>
X-Originating-IP: [146.229.160.228]
X-Originating-Email: [getarunsri@hotmail.com]
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: rostedt@goodmis.org
Subject: Re: sched_setscheduler() and usage issues ....please help
Date: Wed, 30 Mar 2005 23:39:33 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 30 Mar 2005 18:09:34.0276 (UTC) FILETIME=[A0976040:01C53553]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I schedule my process with SCHED_FIFO policy (using 
sched_setscheduler()) , is there any means to verify that it is indeed being 
scheduled with the same priority?

thanks
arun
>From: Steven Rostedt <rostedt@goodmis.org>
>To: Arun Srinivas <getarunsri@hotmail.com>
>Subject: Re: sched_setscheduler() and usage issues ....please help
>Date: Tue, 29 Mar 2005 06:31:43 -0500
>
>On Tue, 2005-03-29 at 13:25 +0530, Arun Srinivas wrote:
> > thanks.gcc says "could not find strutils.h". I am using kernel 2.6.x 
>with
> > gcc 3.3.4. Where can I find the file?
>
>Oops! Sorry, I gave you a modified version of my actual program. I have
>my own usage wrapper, that I use in all my tools. I took it out, but
>forgot about my header. That is a custom header, just take it out and it
>will compile.
>
>OK, just to be clean, I've attached it here.
>
>-- Steve
>
><< setscheduler.c >>

_________________________________________________________________
Get the job you always wanted. 
http://www.naukri.com/tieups/tieups.php?othersrcp=736 Its simple, post your 
CV on Naukri.com

