Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVCFAGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVCFAGI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 19:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVCFACh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 19:02:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29069 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261242AbVCFAAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 19:00:37 -0500
Date: Sun, 6 Mar 2005 00:00:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Jens Axboe <axboe@suse.de>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050306000017.GC31261@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesper Juhl <juhl-lkml@dif.dk>, Jens Axboe <axboe@suse.de>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <42268037.3040300@osdl.org> <Pine.LNX.4.62.0503041212580.2794@dragon.hygekrogen.localhost> <20050304141211.GC18335@suse.de> <Pine.LNX.4.62.0503042037470.2794@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503042037470.2794@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 08:41:34PM +0100, Jesper Juhl wrote:
> That's true. I guess my lack of trust in vendor kernels is part being 
> bitten by them in the past where my own custom build vanilla kernels have 
> worked fine, and part the fear of getting locked-in to some vendor 
> specific feature... Perhaps things are different these days and I should 
> reevaluate my view on vendor kernels - but that's why I haven't been 
> trusting them.

Traditionally the vendor kernels from the big two vendors have been full
of crap, for one of them it seems to be slowly changing now..

