Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVC2Imp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVC2Imp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVC2IiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:38:23 -0500
Received: from mx2.elte.hu ([157.181.151.9]:23463 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262221AbVC2IeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:34:02 -0500
Date: Tue, 29 Mar 2005 10:33:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Yang Yi <yyang@ch.mvista.com>
Cc: linux-kernel@vger.kernel.org, Rt-Dev@Mvista.Com
Subject: Re: [patch] Fix e1000 driver disable interrupts bug for realtime-preempt-2.6.11-rc4-V0.7.39-02
Message-ID: <20050329083352.GA6225@elte.hu>
References: <1109663530.18759.207.camel@montavista2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109663530.18759.207.camel@montavista2>
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


* Yang Yi <yyang@ch.mvista.com> wrote:

> Hi ,Ingo
> 
> this patch fixes e1000 driver disable interrupt bug when enabling 
> "Complete Preemption (Realtime)".

thanks - applied it to the 41-12 tree.

	Ingo
