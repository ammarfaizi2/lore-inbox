Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUJWKUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUJWKUO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUJWKUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:20:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13248 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266463AbUJWKUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:20:09 -0400
Date: Sat, 23 Oct 2004 12:20:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Matt Dobson <colpatch@us.ibm.com>,
       Martin J Bligh <mbligh@aracnet.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [patch] scheduler: active_load_balance fixes
Message-ID: <20041023102054.GC30270@elte.hu>
References: <1098488173.2854.13.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098488173.2854.13.camel@farah.beaverton.ibm.com>
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


* Darren Hart <dvhltc@us.ibm.com> wrote:

> The following patch against the latest mm fixes several problems with
> active_load_balance().

i definitely like this patch, i'd vote to give it a test-drive in -mm.

	Ingo
