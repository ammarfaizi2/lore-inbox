Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWEPQfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWEPQfF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWEPQfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:35:05 -0400
Received: from fmr18.intel.com ([134.134.136.17]:62370 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932112AbWEPQfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:35:02 -0400
Date: Tue, 16 May 2006 09:33:39 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ulrich Drepper <drepper@redhat.com>, Blaisorblade <blaisorblade@yahoo.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 00/14] remap_file_pages protection support
Message-ID: <20060516163339.GL9612@goober>
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au> <200605030225.54598.blaisorblade@yahoo.it> <445CC949.7050900@redhat.com> <445D75EB.5030909@yahoo.com.au> <4465E981.60302@yahoo.com.au> <20060513181945.GC9612@goober> <4469D3F8.8020305@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4469D3F8.8020305@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 11:30:32PM +1000, Nick Piggin wrote:
> 
> Hi Val,
> 
> Thanks, I've tried with your most recent ebizzy and with 256 threads and
> 50,000 vmas (which gives really poor mmap_cache hits), I'm still unable
> to get find_vma above a few % of kernel time.

How excellent!  Sometimes negative results are worth publishing. :)

-VAL
