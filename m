Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVHWNCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVHWNCl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVHWNCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:02:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28381 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932075AbVHWNCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:02:40 -0400
Date: Tue, 23 Aug 2005 14:02:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] suspend: update warnings
Message-ID: <20050823130237.GA7539@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>,
	Nigel Cunningham <ncunningham@cyclades.com>,
	Andrew Morton <akpm@zip.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050822081528.GA4418@elf.ucw.cz> <1124753566.5093.8.camel@localhost> <20050823125017.GB3664@elf.ucw.cz> <20050823125724.GA7341@infradead.org> <20050823130050.GB3735@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050823130050.GB3735@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 03:00:50PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > - DRI being used in X where the drivers don't properly support
> > > suspend/resume (NVidia esp)
> > 
> > NVidias driver is not support and a copyright violation of the
> > copyrights of many of use.  It's never supported so please don't
> > mention it.
> 
> Unfortunately, it is quite common out there. I need to somehow keep
> those bug reports off my mailbox.

I think we made it pretty clear that people with binary modules should
sodd off.  Feel free to use banner for a big "sod off as usual" warning
for all binary module user idiots.

