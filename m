Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbUKOW3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbUKOW3x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUKOW3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:29:53 -0500
Received: from ns.suse.de ([195.135.220.2]:60379 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261341AbUKOW3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:29:52 -0500
Date: Mon, 15 Nov 2004 23:14:32 +0100
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, ak@suse.de, discuss@x86-64.org
Subject: Re: [discuss] [PATCH] x8664 hpet: fix function warning
Message-ID: <20041115221431.GD3062@wotan.suse.de>
References: <419906BB.9080405@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419906BB.9080405@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 11:42:51AM -0800, Randy.Dunlap wrote:
> 
> put function prototype outside of #ifdef block, to fix:
> arch/x86_64/kernel/time.c:941: warning: implicit declaration of
> function `oem_force_hpet_timer'

Thanks, added.

-Andi
