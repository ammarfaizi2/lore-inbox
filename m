Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263014AbVCQIiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbVCQIiY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 03:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbVCQIiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 03:38:24 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62155 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263014AbVCQIiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 03:38:20 -0500
Date: Thu, 17 Mar 2005 09:38:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Frank Rowand <frowand@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] ppc RT: Realtime preempt support for PPC
Message-ID: <20050317083803.GA10011@elte.hu>
References: <422CCC1D.1050902@mvista.com> <20050316100914.GA16012@elte.hu> <42385129.90408@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42385129.90408@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> >to drive things forward, i've applied the first 3 patches (except the
> >rt_lock.h chunk from the first patch), and released it as part of the
> >40-03 patch:
> >
> >  http://redhat.com/~mingo/realtime-preempt/
> >
> 
> Is no one else having trouble compiling this one? The attached one
> liner reverses a one line in the above patch.

yeah - a leftover of the ext3 patches. I've added your fix to 40-04.

	Ingo
