Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269724AbUJGGIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269724AbUJGGIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 02:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUJGGIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 02:08:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16047 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269724AbUJGGIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 02:08:47 -0400
Date: Thu, 7 Oct 2004 08:10:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Subject: Re: [patch] sched: auto-tuning task-migration
Message-ID: <20041007061010.GA32679@elte.hu>
References: <20041006200439.GA15003@elte.hu> <200410062118.i96LIC608654@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410062118.i96LIC608654@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> > could you try the replacement patch below - what results does it give?
> 
> By the way, I wonder why you chose to round down, but not up.

what do you mean - the minimum search within the matrix?

	Ingo
