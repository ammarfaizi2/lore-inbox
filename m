Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932672AbVHPMWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbVHPMWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 08:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbVHPMWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 08:22:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9124 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S932672AbVHPMWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 08:22:48 -0400
Date: Tue, 16 Aug 2005 14:23:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mr Machine <machinehasnoagenda@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: error compiling 2.6.13.rc6 with realtime-preempt patch -rt2 ('quirk_via_irq')
Message-ID: <20050816122334.GA24573@elte.hu>
References: <4301D0F9.4050405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4301D0F9.4050405@gmail.com>
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


* Mr Machine <machinehasnoagenda@gmail.com> wrote:

> i get this error during compile of pci drivers:

> if this helps, here's the realtime configuration section from my 
> .config file:

could you send me the full .config file? That's the easiest way for me 
to reproduce your build problem.

	Ingo
