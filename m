Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVFGQEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVFGQEl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 12:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVFGQEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 12:04:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60847 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261918AbVFGQEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 12:04:38 -0400
Date: Tue, 7 Jun 2005 18:04:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-20
Message-ID: <20050607160400.GA9904@elte.hu>
References: <20050607110409.GA14613@elte.hu> <Pine.OSF.4.05.10506071638130.28240-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506071638130.28240-100000@da410.phys.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> Hey,
>  This is an old problem of cpu_freq.c not compiling. I (re)send a fix 
> for it. This time as a real patch...

thanks - i've applied it and have released the -47-27 patch with this 
fix included.

	Ingo
