Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUIEQHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUIEQHe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 12:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUIEQHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 12:07:34 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:22146 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S266850AbUIEQH3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 12:07:29 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
Date: Sun, 5 Sep 2004 09:07:43 -0700
User-Agent: KMail/1.7
Cc: Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, rlrevell@joe-job.com,
       felipe_alfaro@linuxmail.org
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
In-Reply-To: <20040905140249.GA23502@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409050907.44689.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Any chance you will start syncing your patches up with the -mm tree ? Or is it 
just -bk for the time being ? 

Matt H.


On Sunday 05 September 2004 7:02 am, Ingo Molnar wrote:
> i've released -R5:
>
>  
> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12
>-R5
>
> 2.6.9-rc1-bk12 patching order is:
>
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
>  + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc1.bz2
>  + http://redhat.com/~mingo/voluntary-preempt/patch-2.6.9-rc1-bk12.bz2
>
> Changes in -R5:
>
>  - merge to 2.6.9-rc1-bk12
>
>  - fixed an in_atomic() bug in the SMP && !PREEMPT kernel
>
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
