Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267800AbUHJWwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267800AbUHJWwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267799AbUHJWvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:51:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29375 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267801AbUHJWqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:46:31 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040810171235.GA12157@elte.hu>
References: <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de>
	 <1092103522.761.2.camel@mindpipe> <20040810085849.GC26081@elte.hu>
	 <1092157841.3290.3.camel@mindpipe>  <20040810171235.GA12157@elte.hu>
Content-Type: text/plain
Message-Id: <1092178008.784.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 18:46:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 13:12, Ingo Molnar wrote:

> well, could you try M486 then?
> 

Results with CONFIG_M586TSC are basically the same as CONFIG_MCYRIXIII. 
I have posted my latest results here:

http://www.members.dca.net/rlrevell/testresults/testresults.html

There are graphs (linear and logarithmic scale) for each of 5 trials,
followed by all the XRUN traces and preempt violations I got around the
time of the test.

iozone -a was running also.

Lee



