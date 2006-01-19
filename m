Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWASGSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWASGSH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWASGSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:18:06 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:695 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964947AbWASGSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:18:04 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, gcoady@gmail.com,
       Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1137635372.4736.3.camel@mindpipe>
References: <1135814419.7680.13.camel@mindpipe>
	 <20051229082217.GA23052@elte.hu> <20051229100233.GA12056@redhat.com>
	 <20051229101736.GA2560@elte.hu> <1135887072.6804.9.camel@mindpipe>
	 <1135887966.6804.11.camel@mindpipe> <20051229202848.GC29546@elte.hu>
	 <u8u8r1ttmtubpvd87sf9mq4fi2of0l6js4@4ax.com>
	 <20051230080914.GA26643@elte.hu>
	 <Pine.LNX.4.64.0512300849590.3298@g5.osdl.org>
	 <20060102201429.GB32464@elte.hu>  <1137635372.4736.3.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 01:17:58 -0500
Message-Id: <1137651478.4736.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 20:49 -0500, Lee Revell wrote:
> I'd like to be able to catch any 2.6.16 latency regressions while there
> is time to do something about them, to avoid a repeat of the unmap_vmas
> problem in 2.6.15.

Good news - I was able to trivially port this to 2.6.16-rc1.

Lee

