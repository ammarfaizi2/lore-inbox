Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbULOJtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbULOJtk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 04:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbULOJtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 04:49:40 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59084 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261151AbULOJtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 04:49:39 -0500
Date: Wed, 15 Dec 2004 10:49:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dean Nelson <dcn@sgi.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] export sched_setscheduler() for kernel module use
Message-ID: <20041215094929.GA14627@elte.hu>
References: <41BDF815.mailx9L513T2H5@aqua.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BDF815.mailx9L513T2H5@aqua.americas.sgi.com>
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


* Dean Nelson <dcn@sgi.com> wrote:

> This patch exports sched_setscheduler() so that it can be used by a kernel
> module to set a kthread's scheduling policy and associated parameters.
> 
> Signed-off-by: Dean Nelson <dcn@sgi.com>

looks good for post-2.6.10.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
