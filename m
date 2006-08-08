Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWHHPxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWHHPxi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWHHPxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:53:38 -0400
Received: from xenotime.net ([66.160.160.81]:17820 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964979AbWHHPxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:53:37 -0400
Date: Tue, 8 Aug 2006 08:56:14 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       torvalds <torvalds@osdl.org>, matthew@wil.cx, kyle@parisc-linux.org
Subject: Re: [PATCH 5/9] Replace ARCH_HAS_FLUSH_ANON_PAGE with
 CONFIG_ARCH_FLUSH_ANON_PAGE
Message-Id: <20060808085614.dd2bc702.rdunlap@xenotime.net>
In-Reply-To: <20060808085223.GA20680@infradead.org>
References: <20060807120928.c0fe7045.rdunlap@xenotime.net>
	<20060807141008.de9c9c5c.rdunlap@xenotime.net>
	<20060808085223.GA20680@infradead.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2006 09:52:23 +0100 Christoph Hellwig wrote:

> On Mon, Aug 07, 2006 at 02:10:08PM -0700, Randy.Dunlap wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Replace ARCH_HAS_FLUSH_ANON_PAGE with CONFIG_ARCH_FLUSH_ANON_PAGE.
> 
> Please just put the dummy flush_anon_page in every architectures header.

Nope, someone else can do that.

---
~Randy
