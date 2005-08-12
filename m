Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbVHLGUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVHLGUe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 02:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVHLGUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 02:20:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24721 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S1751110AbVHLGUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 02:20:33 -0400
Date: Fri, 12 Aug 2005 08:21:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Real-Time Preemption V0.7.53-02, fix redundant PREEMPT_RCU config option
Message-ID: <20050812062104.GB13397@elte.hu>
References: <42FBC106.3040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FBC106.3040501@gmail.com>
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


* Luca Falavigna <dktrkranz@gmail.com> wrote:

> This patch removes a redundant PREEMPT_RCU option from kernel/Kconfig.preempt.

thanks, applied.

	Ingo
