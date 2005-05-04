Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVEDIYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVEDIYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 04:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVEDIYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 04:24:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24504 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261408AbVEDIY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 04:24:29 -0400
Date: Wed, 4 May 2005 10:24:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Inaky Perez-Gonzalez <inaky@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
Message-ID: <20050504082420.GA13899@elte.hu>
References: <17001.26444.246648.14231@sodium.jf.intel.com> <Pine.LNX.4.44.0504221410530.4768-200000@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0504221410530.4768-200000@dhcp153.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> > With 2.6.12-rc3-V0.7.46-02 I get:
> 
> It's still to high , it should be under a millisecond ..
>  
> I'm still testing but the times get better with this patch . I was 
> initializing the lists to 0, instead of MAX_INT . Let me know if it 
> changes anything.

could you send me a single patch that adds the plist stuff to the 
current tree? (that way i'll have your latest and i'll be able to 
add/remove it quicker)

	Ingo
