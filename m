Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbUKENpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbUKENpy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 08:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbUKENpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 08:45:53 -0500
Received: from mx1.elte.hu ([157.181.1.137]:36501 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262689AbUKENpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 08:45:41 -0500
Date: Fri, 5 Nov 2004 14:46:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Amit Shah <amitshah@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT-preempt-2.6.10-rc1-mm2-V0.7.11 hang
Message-ID: <20041105134639.GA14830@elte.hu>
References: <200411051837.02083.amitshah@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411051837.02083.amitshah@gmx.net>
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


* Amit Shah <amitshah@gmx.net> wrote:

> Hi Ingo,
> 
> I'm trying out the RT preempt patch on a P4 HT machine, I get the following 
> message:
> 
> e1000_xmit_frame+0x0/0x83b [e1000]

hm, does this happen with -V0.7.13 too? (note that it's against
2.6.10-rc1-mm3, a newer -mm tree.)

	Ingo
