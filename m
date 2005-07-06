Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVGFVGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVGFVGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVGFVGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:06:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52177 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262562AbVGFVDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 17:03:06 -0400
Date: Wed, 6 Jul 2005 23:02:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050706210249.GA2017@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507062047.26855.s0348365@sms.ed.ac.uk> <20050706204429.GA1159@elte.hu> <200507062200.08924.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507062200.08924.s0348365@sms.ed.ac.uk>
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


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> This is a completely unrelated question, but now we've got everything 
> under control.. how do I make "quiet" actually do something on the RT 
> patchset?
> 
> Currently I flag it on the kernel cmdline, but I still get everything 
> spewed to my primary VT.

do you have CONFIG_PRINTK_IGNORE_LOGLEVEL enabled perhaps?

	Ingo
