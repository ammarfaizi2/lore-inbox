Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbUKIP6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUKIP6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 10:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUKIP6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 10:58:42 -0500
Received: from mx1.elte.hu ([157.181.1.137]:48020 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261558AbUKIP6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 10:58:39 -0500
Date: Tue, 9 Nov 2004 18:00:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] don't hide thread_group_leader() from grep
Message-ID: <20041109170042.GA5289@elte.hu>
References: <4190F55E.DF508D9F@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4190F55E.DF508D9F@tv-sign.ru>
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


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> Trivial. replace open-coded thread_group_leader() calls.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
