Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265022AbUD2Wvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbUD2Wvq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265021AbUD2Wu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:50:59 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8070
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265019AbUD2Wtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:49:32 -0400
Date: Fri, 30 Apr 2004 00:49:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, jmoyer@redhat.com,
       carson@taltos.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       davem@redhat.com
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-ID: <20040429224936.GT29954@dualathlon.random>
References: <382320000.1082759593@taltos.ny.ficc.gs.com> <16527.4259.174536.629347@segfault.boston.redhat.com> <20040429210951.GB20453@logos.cnet> <20040429142807.1fa4c5ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429142807.1fa4c5ea.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 02:28:07PM -0700, Andrew Morton wrote:
> just to exercise that code path a bit more.

what's the point of exercising that code path more? are you worried that
there are bugs in it?
