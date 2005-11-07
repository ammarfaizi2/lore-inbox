Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVKGDaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVKGDaM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVKGDaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:30:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34495 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932428AbVKGDaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:30:10 -0500
Date: Mon, 7 Nov 2005 03:30:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1
Message-ID: <20051107033009.GB12192@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20051106182447.5f571a46.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106182447.5f571a46.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -m68k-introduce-task_thread_info.patch
> -m68k-introduce-setup_thread_stack-end_of_stack.patch
> -m68k-thread_info-header-cleanup.patch
> -m68k-m68k-specific-thread_info-changes.patch
> -m68k-convert-thread-flags-to-use-bit-fields.patch
> -add-stack-field-to-task_struct.patch
> -add-stack-field-to-task_struct-ia64-fix.patch
> -rename-allocfree_thread_info-to-allocfree_thread_stack.patch
> -use-end_of_stack.patch
> -change-thread_info-access-to-stack.patch
> -use-task_thread_info.patch
> 
>  Dropped - the powerpc changes broke these and they probably need some
>  separating out anyway.

gosh.  Can we please get one of the patches to allow m68k in mainline
merged?  roman has been blocking these since 2.6.13 at least.  Alternatively
just kill m68k from mainline due to lack of active maintainer.

