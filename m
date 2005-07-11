Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVGKPvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVGKPvt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVGKPtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:49:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12722 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262083AbVGKPsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:48:05 -0400
Date: Mon, 11 Jul 2005 16:48:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Victor <andrew@sanpeople.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Russell King <rmk@arm.linux.org.uk>, alan@lxorguk.ukuu.org.uk,
       dwmw2@infradead.org
Subject: Re: [RFC] Atmel-supplied hardware headers for AT91RM9200 SoC processor
Message-ID: <20050711154803.GA14164@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org,
	Russell King <rmk@arm.linux.org.uk>, alan@lxorguk.ukuu.org.uk,
	dwmw2@infradead.org
References: <1120730318.16806.75.camel@fuzzie.sanpeople.com> <20050707130607.GC28489@infradead.org> <1121088922.7407.64.camel@localhost.localdomain> <1121090246.7380.46.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121090246.7380.46.camel@fuzzie.sanpeople.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 03:57:26PM +0200, Andrew Victor wrote:
> > Or written a perl script to reprocess them into something saner for
> > that matter.
> 
> The issue that everybody seems to be forgetting (or ignoring) with
> changing the headers is that ALL the drivers then also need to be
> converted, and re-tested.

Given your lack of taste they'll probably need a full rewrite anyway.
And given their not in-tree yet we don't care at all either.

