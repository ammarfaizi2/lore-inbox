Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVK1Lsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVK1Lsb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 06:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVK1Lsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 06:48:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40901 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751243AbVK1Lsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 06:48:30 -0500
Date: Mon, 28 Nov 2005 12:48:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
Message-ID: <20051128114852.GA3391@elte.hu>
References: <1132987928.4896.1.camel@mindpipe> <20051126122332.GA3712@elte.hu> <1133031912.5904.12.camel@mindpipe> <1133034406.32542.308.camel@tglx.tec.linutronix.de> <20051127123052.GA22807@elte.hu> <1133141224.4909.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133141224.4909.1.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


which was the last -rt kernel that worked fine for you in 
PREEMPT_DESKTOP mode?

	Ingo
