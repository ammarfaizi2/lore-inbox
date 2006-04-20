Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWDTRWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWDTRWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWDTRWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:22:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14464 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751167AbWDTRWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:22:41 -0400
Date: Thu, 20 Apr 2006 18:22:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch 2/5] mm: deprecate vmalloc_to_pfn
Message-ID: <20060420172240.GD21659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux Memory Management <linux-mm@kvack.org>,
	Hugh Dickins <hugh@veritas.com>
References: <20060228202202.14172.60409.sendpatchset@linux.site> <20060228202223.14172.21110.sendpatchset@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228202223.14172.21110.sendpatchset@linux.site>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 07:06:30PM +0200, Nick Piggin wrote:
> Deprecate vmalloc_to_pfn.

I don't think there's any point to even keep it.  There's a trivial replcement.

