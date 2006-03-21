Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWCURD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWCURD5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWCURD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:03:57 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14540 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932094AbWCURDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:03:55 -0500
Date: Tue, 21 Mar 2006 18:01:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt1
Message-ID: <20060321170149.GA27290@elte.hu>
References: <20060320085137.GA29554@elte.hu> <200603211430.29466.Serge.Noiraud@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603211430.29466.Serge.Noiraud@bull.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> I get the following error :
> ...
> Kernel: arch/i386/boot/bzImage is ready  (#2)
>   Building modules, stage 2.
>   MODPOST
> *** Warning: "mutex_destroy" [fs/xfs/xfs.ko] undefined!
> *** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [fs/xfs/xfs.ko] undefined!
> ...
> Is it a BUG ?

could you check -rt2?

	Ingo
