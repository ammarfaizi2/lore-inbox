Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269741AbUJGHZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269741AbUJGHZy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 03:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269743AbUJGHZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 03:25:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26502 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269741AbUJGHZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 03:25:52 -0400
Date: Thu, 7 Oct 2004 09:26:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Andrew Morton'" <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: Default cache_hot_time value back to 10ms
Message-ID: <20041007072613.GA2551@elte.hu>
References: <20041006134317.03a22198.akpm@osdl.org> <200410062313.i96NDo609923@unix-os.sc.intel.com> <20041007062908.GB32679@elte.hu> <4164EB6F.90302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4164EB6F.90302@pobox.com>
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


* Jeff Garzik <jgarzik@pobox.com> wrote:

> Ingo Molnar wrote:
> >* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> >>>Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> >
> >
> >Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> 
> [tangent] FWIW Andrew has recently been using "Acked-by" as well,
> presumably for patches created by person X from but reviewed by wholly
> independent person Y (since signed-off-by indicates you have some
> amount of legal standing to actually sign off on the patch)

[even more tangential] even if this werent a onliner, i might have some
amount of legal standing, i wrote the original cache_decay_ticks code
that this patch reverts to ;) But yeah, Acked-by would be more
informative here.

	Ingo
