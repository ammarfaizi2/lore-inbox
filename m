Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVFBMhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVFBMhv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 08:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVFBMhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 08:37:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:23231 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261398AbVFBMhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 08:37:32 -0400
Date: Thu, 2 Jun 2005 14:37:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: RT patch breaks X86_64 build
Message-ID: <20050602123703.GA10878@elte.hu>
References: <200505302141.31731.kernel-stuff@comcast.net> <200505302201.48123.kernel-stuff@comcast.net> <429BFF51.4000401@stud.feec.vutbr.cz> <200505310753.49447.kernel-stuff@comcast.net> <429C530E.70704@stud.feec.vutbr.cz> <20050601091344.GB11703@elte.hu> <429EFC0D.9020703@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429EFC0D.9020703@stud.feec.vutbr.cz>
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


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> Hi Ingo,
> 
> I don't see why /proc/sys/kernel/preempt_{max_latency,thresh} should 
> not be readable for all users. They already can see much more detailed 
> information in /proc/latency_trace.

agreed - added.

	Ingo
