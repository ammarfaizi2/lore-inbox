Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVJKWG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVJKWG3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 18:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVJKWG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 18:06:28 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:59023 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751195AbVJKWG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 18:06:28 -0400
Subject: Re: 2.6.14-rc4-rt1
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <5bdc1c8b0510111413q7b1ea391n3bc27924d928b963@mail.gmail.com>
References: <20051011111454.GA15504@elte.hu>
	 <1129064151.5324.6.camel@cmn3.stanford.edu>
	 <5bdc1c8b0510111408n4ef45eadv1e12ec4d1271d971@mail.gmail.com>
	 <5bdc1c8b0510111413q7b1ea391n3bc27924d928b963@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 17:21:36 -0400
Message-Id: <1129065696.4718.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 14:13 -0700, Mark Knecht wrote:
> The machine had been essentially 'User space idle' for the previous
> two hours. The screen saver had kicked in. Audio was running and the
> machine was busy. I woke it up, gave xscreensaver my password, read
> email, sent the previous mail, then picked up the telephone to make a
> call. Not 2 seconds later the xruns occurred!

So what does /proc/latency_trace report?

Lee

