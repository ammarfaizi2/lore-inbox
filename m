Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVC2LtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVC2LtM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVC2LtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:49:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:1770 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262237AbVC2LrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:47:03 -0500
Date: Tue, 29 Mar 2005 13:46:44 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>,
       Arun Srinivas <getarunsri@hotmail.com>, nickpiggin@yahoo.com.au,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: sched_setscheduler() and usage issues ....please help
In-Reply-To: <1112096597.6282.50.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0503291345161.19483@yvahk01.tjqt.qr>
References: <BAY10-F472EE1F6A6F80FEA2F5568D9450@phx.gbl> 
 <1112071215.3691.27.camel@localhost.localdomain>  <1112071867.19014.30.camel@mindpipe>
  <Pine.LNX.4.61.0503290802170.25114@yvahk01.tjqt.qr>
 <1112096597.6282.50.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>FC2 has this. Even FC1 had it, and I'd not be surprised if even RHL9 had
>this. I'd be very susprised if SuSE 9.1 doesn't have it either.

It was introduced with SUSE Linux 9.1. But, as usually, I usually do not care 
for new packages when updating, and schedutils was not a dependency, so it 
lost itself until I actively checked what it's about when the boot process 
says
"Setting scheduling timeslices                                        unused"





Jan Engelhardt
-- 
No TOFU for me, please.
