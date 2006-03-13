Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWCMJJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWCMJJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 04:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWCMJJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 04:09:56 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:63459 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932375AbWCMJJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 04:09:54 -0500
Date: Mon, 13 Mar 2006 10:07:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Peter Williams <pwil3058@bigpond.net.au>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH][3/4] sched: add above background load function
Message-ID: <20060313090733.GC5780@elte.hu>
References: <200603131908.00161.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131908.00161.kernel@kolivas.org>
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

> Add an above_background_load() function which can be used by other 
> subsystems to detect if there is anything besides niced tasks running. 
> Place it in sched.h to allow it to be compiled out if not used.
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
