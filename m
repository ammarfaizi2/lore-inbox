Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWBNEOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWBNEOO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 23:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbWBNEOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 23:14:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030349AbWBNEOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 23:14:14 -0500
Date: Mon, 13 Feb 2006 20:13:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kenneth.w.chen@intel.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/2] fix perf. bug in wake-up load balancing for aim7
 and db workload
Message-Id: <20060213201313.1856af42.akpm@osdl.org>
In-Reply-To: <43F15531.3060809@yahoo.com.au>
References: <200602140309.k1E394g17590@unix-os.sc.intel.com>
	<20060213193856.696bf1f0.akpm@osdl.org>
	<43F15211.2090206@yahoo.com.au>
	<43F15531.3060809@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Nick Piggin wrote:
> > Andrew Morton wrote:
> > 
> >>
> >>
> >> Well I don't see any benchmark numbers in the original patch.  Just an
> >> assertion that it "should" help something.
> >>
> > 
> > The regression was in a Ken's commercial database benchmark. I couldn't
> > reproduce it but presumably it did fix it otherwise Ken would would have
> > piped up?
> > 
> 
> BTW, I did actually ask that you hold off merging it until Ken came
> back with some numbers.
> 

So you did.
