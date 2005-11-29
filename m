Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbVK2XUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbVK2XUB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbVK2XUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:20:01 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37300 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751390AbVK2XUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:20:00 -0500
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <20051129093231.GA5028@elte.hu>
References: <1133031912.5904.12.camel@mindpipe>
	 <1133034406.32542.308.camel@tglx.tec.linutronix.de>
	 <20051127123052.GA22807@elte.hu> <1133141224.4909.1.camel@mindpipe>
	 <20051128114852.GA3391@elte.hu> <1133189789.5228.7.camel@mindpipe>
	 <20051128160052.GA29540@elte.hu> <1133217651.4678.2.camel@mindpipe>
	 <1133230103.5640.0.camel@mindpipe> <20051129072922.GA21696@elte.hu>
	 <20051129093231.GA5028@elte.hu>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 18:19:41 -0500
Message-Id: <1133306382.4627.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 10:32 +0100, Ingo Molnar wrote:
> I've released -rt21 with these fixes, does it work better for you?

Thanks, this works perfectly.

Lee

