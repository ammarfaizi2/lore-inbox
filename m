Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbUBCPZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 10:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265718AbUBCPZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 10:25:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:16772 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264874AbUBCPZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 10:25:43 -0500
Date: Tue, 3 Feb 2004 12:47:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] 2.6.1 Hyperthread smart "nice" 2
Message-ID: <20040203114704.GA10128@elte.hu>
References: <200401291917.42087.kernel@kolivas.org> <200402032207.38006.kernel@kolivas.org> <20040203111236.GA8508@elte.hu> <200402032214.49229.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402032214.49229.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk1 SpamAssassin 2.60 ClamAV 0.60
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no, SpamAssassin (score=0, required 5.9)
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> Actually I was trying to say something like my patch, but done
> correctly. I agree with new instructions not helping at the moment.

ok - for that the sched-domains code is the right solution.

	Ingo
