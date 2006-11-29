Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967628AbWK2UWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967628AbWK2UWT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 15:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967630AbWK2UWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 15:22:19 -0500
Received: from smtp3.Stanford.EDU ([171.67.20.26]:18894 "EHLO
	smtp3.stanford.edu") by vger.kernel.org with ESMTP id S967628AbWK2UWS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 15:22:18 -0500
Subject: Re: 2.6.19-rc6-rt8: alsa xruns
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <20061129195144.GA8676@elte.hu>
References: <1164743931.15887.34.camel@cmn3.stanford.edu>
	 <20061128200927.GA26934@elte.hu>
	 <1164746224.15887.40.camel@cmn3.stanford.edu>
	 <1164747854.15887.48.camel@cmn3.stanford.edu>
	 <20061129134311.GA14566@elte.hu>
	 <1164825498.18954.5.camel@cmn3.stanford.edu>
	 <20061129195144.GA8676@elte.hu>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 12:22:17 -0800
Message-Id: <1164831737.18954.21.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 20:51 +0100, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> Also, can you see the xruns/latencies with latencytest too? (That one 
> might be easier to reproduce for me.)

I can do that. Is this the old latency test script?
(http://www.gardena.net/benno/linux/latencytest-0.42-png.tar.gz)
Most probably there are newer versions...
-- Fernando


