Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbUCIQIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUCIQIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:08:39 -0500
Received: from mx1.elte.hu ([157.181.1.137]:49567 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262037AbUCIQGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:06:51 -0500
Date: Tue, 9 Mar 2004 17:08:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309160807.GA10778@elte.hu>
References: <20040308202433.GA12612@dualathlon.random> <20040309105226.GA2863@elte.hu> <20040309110233.GA3819@elte.hu> <20040309155917.GH8193@dualathlon.random> <20040309160709.GA10577@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309160709.GA10577@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > this use more cpu than the previous one, but no other differences.
> 
> how fast is the system you tried this on? If it's faster than the 500
> MHz box i tried it on then please try the attached test-mmap3.c.
> (which is still not doing anything extreme.)

also, please run it on an UP kernel.

	Ingo
