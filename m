Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267272AbUHIVVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267272AbUHIVVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267250AbUHIVQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:16:59 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:50445 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267238AbUHIVQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:16:22 -0400
Date: Mon, 9 Aug 2004 22:16:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, grif@cs.ucr.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] QLogic ISP2x00: remove needless busyloop
Message-ID: <20040809221620.B10454@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, grif@cs.ucr.edu,
	linux-kernel@vger.kernel.org
References: <200408091252.58547.bjorn.helgaas@hp.com> <200408091419.20029.bjorn.helgaas@hp.com> <20040809212147.A9919@infradead.org> <200408091508.27773.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408091508.27773.bjorn.helgaas@hp.com>; from bjorn.helgaas@hp.com on Mon, Aug 09, 2004 at 03:08:27PM -0600
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 03:08:27PM -0600, Bjorn Helgaas wrote:
> > > In general, I think if a driver is in the tree, it should be fair
> > > game for bugfixes.  In fact, I see you did the most recent one to
> > > qlogicfc :-)
> > 
> > That wasn't a bugfix, look harder.
> 
> My apologies.  I should have written "if a driver is in the
> tree, it should be fair game to improve it."

I don't object to the patch.  But it was a _very_ _strong_ _hint_ that you
did something wrong if the patch actually matters for you.

