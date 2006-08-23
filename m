Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbWHWTLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbWHWTLe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 15:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWHWTLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 15:11:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34730 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965103AbWHWTLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 15:11:33 -0400
Date: Wed, 23 Aug 2006 20:11:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/18] 2.6.17.9 perfmon2 patch for review: introduction
Message-ID: <20060823191132.GA13381@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200608230805.k7N85qo2000348@frankl.hpl.hp.com> <20060823152831.GC32725@infradead.org> <20060823155715.GA5204@martell.zuzino.mipt.ru> <20060823160458.GA17712@infradead.org> <20060823115857.89f8d47b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823115857.89f8d47b.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 11:58:57AM -0700, Andrew Morton wrote:
> > > Padding with zeros makes it even more useful:
> > > 
> > > 	[PATCH 00/17]
> > > 	[PATCH 01/17]
> > > 		...
> > > 	[PATCH 17/17]
> > 
> > To be honest I utterly hate that convention
> 
> It's so they'll correctly alphasort at the recipient's end.

I suspect most mailers sort by date and not by subject anyway.

At least mine does :)

