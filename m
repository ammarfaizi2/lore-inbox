Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263178AbVG3U6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbVG3U6q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263175AbVG3UzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:55:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:55252 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263173AbVG3UxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:53:05 -0400
Date: Sat, 30 Jul 2005 22:52:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
Message-ID: <20050730205259.GA24542@elte.hu>
References: <20050730160345.GA3584@elte.hu> <1122756435.29704.2.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122756435.29704.2.camel@twins>
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


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Hi Ingo,
> 
> -02 needs the attached patch to compile with my config.

thanks, i've released -03 with your fixes.

	Ingo
