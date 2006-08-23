Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWHWQFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWHWQFV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 12:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWHWQFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 12:05:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11490 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964995AbWHWQFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 12:05:20 -0400
Date: Wed, 23 Aug 2006 17:04:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Stephane Eranian <eranian@frankl.hpl.hp.com>,
       linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 1/18] 2.6.17.9 perfmon2 patch for review: introduction
Message-ID: <20060823160458.GA17712@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Stephane Eranian <eranian@frankl.hpl.hp.com>,
	linux-kernel@vger.kernel.org, eranian@hpl.hp.com
References: <200608230805.k7N85qo2000348@frankl.hpl.hp.com> <20060823152831.GC32725@infradead.org> <20060823155715.GA5204@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823155715.GA5204@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 07:57:16PM +0400, Alexey Dobriyan wrote:
> On Wed, Aug 23, 2006 at 04:28:31PM +0100, Christoph Hellwig wrote:
> > oh, and please give the patches useful subjects that descript the
> > patch, e.g. this one should be just:
> >
> >
> >     [PATCH 0/17] perfmon2: introduction
> >
> > (yes, it's convention to number the introduction 0 and the actual patches
> >  1 to n)
> 
> Padding with zeros makes it even more useful:
> 
> 	[PATCH 00/17]
> 	[PATCH 01/17]
> 		...
> 	[PATCH 17/17]

To be honest I utterly hate that convention, and the double-padded
version [PATCH 001/17] some people use is even worse.

