Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264655AbUG1VnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbUG1VnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbUG1VnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:43:13 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:63907 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264655AbUG1VnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:43:12 -0400
Subject: Re: [patch] IRQ threads
From: Lee Revell <rlrevell@joe-job.com>
To: karim@opersys.com
Cc: Scott Wood <scott@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>,
       Philippe Gerum <rpm@xenomai.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41081771.1010307@opersys.com>
References: <20040727225040.GA4370@yoda.timesys>
	 <4107CA18.4060204@opersys.com> <1091039327.747.26.camel@mindpipe>
	 <4107FA93.3030801@opersys.com> <1091043218.766.10.camel@mindpipe>
	 <41080540.9040401@opersys.com> <1091046954.791.27.camel@mindpipe>
	 <41081771.1010307@opersys.com>
Content-Type: text/plain
Message-Id: <1091051005.791.45.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 17:43:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 17:15, Karim Yaghmour wrote:
> Lee Revell wrote:
> My real argument was best summarized in the second paragraph, and what
> I'm saying is that these approaches make the kernel's dynamic behavior
> extremely complicated. And while they do contribute to making the
> kernel's response time faster, they do not provided hard-rt, which is
> what everyone is trying to get in the end anyway (either intentionally
> or unintentionally.)
> 
> With that, let me respond to Bill's discussion on signle vs. N kernels
> as that thread is the most likely to be fruitfull. I hope you'll agree.
> 

Yes, agreed.  I am glad this did not escalate, and I hope you can
understand how I would have overlooked your actual argument due to my
perceiving the first paragraph as vaguely ad hominem. 

Lee

