Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751106AbWFENbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWFENbW (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 09:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWFENbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 09:31:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16040 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751099AbWFENbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 09:31:21 -0400
Date: Mon, 5 Jun 2006 14:31:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jeff@garzik.org>,
        Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: wireless (was Re: 2.6.18 -mm merge plans)
Message-ID: <20060605133117.GA25243@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605010636.GB17361@havoc.gtf.org> <20060605085451.GA26766@infradead.org> <20060605132732.GA23350@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605132732.GA23350@tuxdriver.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 09:27:37AM -0400, John W. Linville wrote:
> Actually, I was planning to merge the softmac-based version for 2.6.18.
> It looks like I may want some of Andrew's patches on top (ia64, alpha, etc).

duh, didn't know that wasn't in -mm.  we want the softmac version of course.

