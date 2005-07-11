Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVGKPZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVGKPZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVGKPXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:23:43 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:60109 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261996AbVGKPXc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:23:32 -0400
Subject: Re: [RFC] Atmel-supplied hardware headers for AT91RM9200 SoC
	processor
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Russell King <rmk@arm.linux.org.uk>, dwmw2@infradead.org
In-Reply-To: <1121090246.7380.46.camel@fuzzie.sanpeople.com>
References: <1120730318.16806.75.camel@fuzzie.sanpeople.com>
	 <20050707130607.GC28489@infradead.org>
	 <1121088922.7407.64.camel@localhost.localdomain>
	 <1121090246.7380.46.camel@fuzzie.sanpeople.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121095209.7433.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 11 Jul 2005 16:20:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-07-11 at 14:57, Andrew Victor wrote:
> The issue that everybody seems to be forgetting (or ignoring) with
> changing the headers is that ALL the drivers then also need to be
> converted, and re-tested.

So its a few more lines of perl

> I have asked Atmel if they're willing to dual-license the headers.  The
> licensing issue is probably now with their legal department, but I don't
> see them having a problem with it.

Great
