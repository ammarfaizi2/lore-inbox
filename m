Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVEWHzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVEWHzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 03:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVEWHzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 03:55:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40581 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261867AbVEWHyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 03:54:43 -0400
Date: Mon, 23 May 2005 09:54:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mingming Cao <cmm@us.ibm.com>, kus Kusche Klaus <kus@keba.com>,
       linux-kernel@vger.kernel.org, inaky.perez-gonzalez@intel.com,
       dwalker@mvista.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-00
Message-ID: <20050523075424.GB9287@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F367323202@MAILIT.keba.co.at> <20050509091709.GA27126@elte.hu> <1116201764.25898.44.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116201764.25898.44.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Ingo,
> 
> Can you add Mingming's ext3 patch to the next version?  For my 
> workload at least, this seems to be the last important latency breaker 
> that we need to go upstream.

yeah, agreed - i've applied it to my tree and it's looking good in my 
ext3 tests.

	Ingo
