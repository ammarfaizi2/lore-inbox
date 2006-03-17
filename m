Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWCQNJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWCQNJs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWCQNJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:09:48 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:30887 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932441AbWCQNJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:09:47 -0500
Date: Fri, 17 Mar 2006 14:07:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2/2] sched: sched.c runqueue_t cleanup
Message-ID: <20060317130736.GC29759@elte.hu>
References: <200603180004.59946.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603180004.59946.kernel@kolivas.org>
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

> Replace all struct runqueue instances in sched.c with runqueue_t
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
