Return-Path: <linux-kernel-owner+w=401wt.eu-S937585AbWLKTNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937585AbWLKTNh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937579AbWLKTNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:13:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42953 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937585AbWLKTNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:13:36 -0500
Date: Mon, 11 Dec 2006 20:12:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make kernel/printk.c:ignore_loglevel_setup() static
Message-ID: <20061211191208.GB28340@elte.hu>
References: <20061211191132.GG28443@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211191132.GG28443@stusta.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0013]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> This patch makes the needlessly global ignore_loglevel_setup() static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

thanks,

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
