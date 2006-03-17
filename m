Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWCQNJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWCQNJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWCQNJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:09:23 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:24487 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932177AbWCQNJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:09:22 -0500
Date: Fri, 17 Mar 2006 14:07:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: activate SCHED BATCH expired
Message-ID: <20060317130706.GA29759@elte.hu>
References: <200603081013.44678.kernel@kolivas.org> <200603090036.49915.kernel@kolivas.org> <20060317090653.GC13387@elte.hu> <200603172338.10107.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603172338.10107.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> To increase the strength of SCHED_BATCH as a scheduling hint we can activate
> batch tasks on the expired array since by definition they are latency
> insensitive tasks.
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
