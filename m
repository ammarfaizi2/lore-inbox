Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbUKXHFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbUKXHFB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbUKXHFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:05:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5578 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262164AbUKXHE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:04:59 -0500
Date: Wed, 24 Nov 2004 09:07:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041124080710.GA20755@elte.hu>
References: <20041123133456.GA10453@elte.hu> <Pine.OSF.4.05.10411232343010.4816-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411232343010.4816-100000@da410.ifa.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> --- linux-2.6.10-rc2-mm2-V0.7.30-9/drivers/char/blocker.c.orig  2004-11-23 20:18:28.000000000 +0100
> +++ linux-2.6.10-rc2-mm2-V0.7.30-9/drivers/char/blocker.c       2004-11-23 20:41:57.742899751 +0100

fyi, i've manually applied this patch to my tree - it didnt apply
cleanly because apparently your mailer turned tabs into spaces. I also
fixed up the coding style to match that of the kernel's.

	Ingo
