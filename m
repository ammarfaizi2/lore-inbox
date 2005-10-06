Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbVJFPBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVJFPBh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbVJFPBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:01:37 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:17545 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751062AbVJFPBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:01:36 -0400
Date: Thu, 6 Oct 2005 11:00:50 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Lee Revell <rlrevell@joe-job.com>
cc: tglx@linutronix.de, Mark Knecht <markknecht@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, david singleton <dsingleton@mvista.com>,
       Todd.Kneisel@bull.com, Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <1128609107.14584.4.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0510061057530.387@localhost.localdomain>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com> 
 <20051004130009.GB31466@elte.hu>  <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
  <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com> 
 <1128450029.13057.60.camel@tglx.tec.linutronix.de> <1128609107.14584.4.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lee,

Once again, Please replace the kihontech.com with goodmis.org (done here)
since the kihontech.com is for use with customers and potential customers
;-)


On Thu, 6 Oct 2005, Lee Revell wrote:

>
> Sorry if this is old news, but I am getting them with 2.6.13-rt12.
> Unlike previous occurrences, it appears that X does *not* end up
> SCHED_FIFO.
>

Yep old news, it was an accounting error that Thomas discovered. It's all
fixed in the latest release of -rt.

-- Steve

