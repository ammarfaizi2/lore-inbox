Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVIZGZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVIZGZq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 02:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVIZGZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 02:25:46 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:32160 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932409AbVIZGZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 02:25:45 -0400
Date: Mon, 26 Sep 2005 08:26:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: Checks for cmpxchg in get_task_struct_rcu()
Message-ID: <20050926062631.GE3273@elte.hu>
References: <1127345874.19506.43.camel@dhcp153.mvista.com> <433201FC.8040004@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433201FC.8040004@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> You need my atomic_cmpxchg patches that provide an atomic_cmpxchg (and 
> atomic_inc_not_zero) for all architectures.

yeah. When will they be merged upstream?

	Ingo
