Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbVJ1HkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbVJ1HkF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbVJ1HkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:40:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:11196 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965178AbVJ1HkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:40:02 -0400
Date: Fri, 28 Oct 2005 09:40:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better wake-balancing: respin
Message-ID: <20051028074015.GD5248@elte.hu>
References: <200510270124.j9R1OPg27107@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510270124.j9R1OPg27107@unix-os.sc.intel.com>
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


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> Once upon a time, this patch was in -mm tree (2.6.13-mm1):
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112265450426975&w=2
> 
> It is neither in Linus's official tree, nor it is in -mm anymore.

it's sched-better-wake-balancing-3.patch, in 2.6.14-rc5-mm1.

	Ingo
