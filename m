Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVDDRkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVDDRkS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVDDRkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:40:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28581 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261303AbVDDRkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:40:14 -0400
Date: Mon, 4 Apr 2005 19:40:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.12-rc1-mm4-RT-V0.7.42-08
Message-ID: <20050404174002.GA12306@elte.hu>
References: <1112433149.13131.8.camel@twins> <1112507988.10235.3.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112507988.10235.3.camel@twins>
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
> I need the following two patches to keep my system alive and avoid
> the BUGs in the log send to you earlier (private mail).

hm, the second patch does not apply (and the merge didnt look trivial) - 
maybe it depends on some patch in -mm that is not yet upstream?

	Ingo
