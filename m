Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266214AbUHBBpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbUHBBpV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 21:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266215AbUHBBpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 21:45:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:48079 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266214AbUHBBpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 21:45:18 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040801193043.GA20277@elte.hu>
References: <20040713143947.GG21066@holomorphy.com>
	 <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe>
	 <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe>
	 <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu>  <20040801193043.GA20277@elte.hu>
Content-Type: text/plain
Message-Id: <1091411152.973.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 01 Aug 2004 21:45:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-01 at 15:30, Ingo Molnar wrote:
> here's the latest version of the voluntary-preempt patch:
>   
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-O2

This works as well as L2, possibly better, because the 42 usec result
was with the rtc irq threaded, it is now direct.  I will post numbers
soon.

Lee

