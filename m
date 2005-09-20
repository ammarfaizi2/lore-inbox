Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbVITPT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVITPT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVITPT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:19:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:64994 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965031AbVITPT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:19:27 -0400
Date: Tue, 20 Sep 2005 17:20:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: yangyi <yang.yi@bmrtech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Another latency histogram cleanup
Message-ID: <20050920152022.GA15434@elte.hu>
References: <1126870970.22039.332.camel@montavista2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126870970.22039.332.camel@montavista2>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* yangyi <yang.yi@bmrtech.com> wrote:

> Hi, Ingo
> 
> This is another latency histogram cleanup, changes include:
> 
> - Remove some definitons to include/linux/latency_hist.h from kenerl/latency.c and kernel/latency_hist.c
> - Eliminate most #ifedf from check_critical_timing() and check_wakup_timing()

thanks, applied.

	Ingo
