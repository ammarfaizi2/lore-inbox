Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWHHOSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWHHOSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWHHOSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:18:14 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:25232 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S964897AbWHHOSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:18:13 -0400
Date: Tue, 8 Aug 2006 10:17:34 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
To: Christoph Hellwig <hch@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       torvalds <torvalds@osdl.org>, matthew@wil.cx, kyle@parisc-linux.org
Subject: Re: [PATCH 5/9] Replace ARCH_HAS_FLUSH_ANON_PAGE with CONFIG_ARCH_FLUSH_ANON_PAGE
Message-ID: <20060808141734.GB4896@athena.road.mcmartin.ca>
References: <20060807120928.c0fe7045.rdunlap@xenotime.net> <20060807141008.de9c9c5c.rdunlap@xenotime.net> <20060808085223.GA20680@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808085223.GA20680@infradead.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 09:52:23AM +0100, Christoph Hellwig wrote:
> Please just put the dummy flush_anon_page in every architectures header.
> 

That sounds much cleaner.
