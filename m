Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267335AbSLKXqr>; Wed, 11 Dec 2002 18:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267345AbSLKXqr>; Wed, 11 Dec 2002 18:46:47 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:33034 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267335AbSLKXqq>; Wed, 11 Dec 2002 18:46:46 -0500
Date: Wed, 11 Dec 2002 23:54:30 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patricia Gaughen <gone@us.ibm.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (2/2) i386 discontigmem support against 2.4.21pre1: discontigmem
Message-ID: <20021211235430.A9740@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patricia Gaughen <gone@us.ibm.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
References: <200212112335.gBBNZqN04597@w-gaughen.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212112335.gBBNZqN04597@w-gaughen.beaverton.ibm.com>; from gone@us.ibm.com on Wed, Dec 11, 2002 at 03:35:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 03:35:52PM -0800, Patricia Gaughen wrote:
> This patch provides generic discontiguous memory support for the i386
> numa architecture.  The patch also provides supports for the ia32 IBM
> NUMA-Q hardware platform.  John Stultz also has added support for the
> x440 hardware, but now it's mine.  This will be posted separately at a 
> later date.  A version of this patch has been accepted into the v2.5
> tree starting with 2.5.34.
> 
> This patch depends on the paddr->pfn patch that I just sent out.
> 

[snip]

> Any and all feedback regarding this patch is greatly appreciated.

The patch looks very nice.  And it looks like it got testing in -aa
for a fair while.

