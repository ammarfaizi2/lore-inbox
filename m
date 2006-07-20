Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWGTQEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWGTQEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 12:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWGTQEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 12:04:55 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:51909 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030355AbWGTQEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 12:04:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17599.43337.775125.837876@cargo.ozlabs.ibm.com>
Date: Fri, 21 Jul 2006 02:03:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Horms <horms@verge.net.au>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>,
       Anton Blanchard <anton@samba.org>, Andi Kleen <ak@suse.de>,
       Chris Zankel <chris@zankel.net>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linuxppc-dev@ozlabs.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panic_on_oops: remove ssleep()
In-Reply-To: <31687.FP.7244@verge.net.au>
References: <31687.FP.7244@verge.net.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horms writes:

> This patch is part of an effort to unify the panic_on_oops behaviour
> across all architectures that implement it.

Acked-by: Paul Mackerras <paulus@samba.org>
