Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVBKJmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVBKJmi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 04:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVBKJmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 04:42:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17294 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262226AbVBKJmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 04:42:33 -0500
Date: Fri, 11 Feb 2005 10:42:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sven Dietrich <sdietrich@mvista.com>
Cc: "'George Anzinger'" <george@mvista.com>,
       "'William Weston'" <weston@lysdexia.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050211094222.GA6229@elte.hu>
References: <20050211083408.GB3349@elte.hu> <000501c5101d$8247b280$c800a8c0@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000501c5101d$8247b280$c800a8c0@mvista.com>
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


* Sven Dietrich <sdietrich@mvista.com> wrote:

> No, this is not in arm. Here is the patch.
> 
> Index: linux-2.6.10/include/asm-i386/spinlock.h

what version do you have? The current released patch is
2.6.11-rc3-V0.7.38-10.

	Ingo
