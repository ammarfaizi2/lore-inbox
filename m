Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965885AbWK1UPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965885AbWK1UPh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965818AbWK1UPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:15:37 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:14790 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S936050AbWK1UPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:15:35 -0500
Subject: Re: 2.6.19-rc6-rt5
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0611281153l17c2a8f9y28185420f137d0fa@mail.gmail.com>
References: <20061120220230.GA30835@elte.hu>
	 <5bdc1c8b0611220606m31c397d1ubafae3460d36db09@mail.gmail.com>
	 <1164735207.1701.19.camel@mindpipe>
	 <5bdc1c8b0611281153l17c2a8f9y28185420f137d0fa@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 15:16:00 -0500
Message-Id: <1164744960.1701.62.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 11:53 -0800, Mark Knecht wrote:
> I know you've pushed
> me to move to PAM telling me realtime-lsm wasn't going to work in the
> future. I really just wanted to know that PAM was now a requirement
> instead of only best practice. 

I said it was not guaranteed to work.  It should work as long as someone
maintains it.

I don't think anyone expected it to take so long for distros to update
their PAM packages so as to make patching the kernel unnecessary.

Lee

