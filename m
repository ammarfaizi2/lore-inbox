Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267231AbUHIVIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267231AbUHIVIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267226AbUHIVIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:08:41 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:44702 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S267212AbUHIVIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:08:35 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] QLogic ISP2x00: remove needless busyloop
Date: Mon, 9 Aug 2004 15:08:27 -0600
User-Agent: KMail/1.6.2
Cc: linux-ia64@vger.kernel.org, Andrew Morton <akpm@osdl.org>, grif@cs.ucr.edu,
       linux-kernel@vger.kernel.org
References: <200408091252.58547.bjorn.helgaas@hp.com> <200408091419.20029.bjorn.helgaas@hp.com> <20040809212147.A9919@infradead.org>
In-Reply-To: <20040809212147.A9919@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408091508.27773.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In general, I think if a driver is in the tree, it should be fair
> > game for bugfixes.  In fact, I see you did the most recent one to
> > qlogicfc :-)
> 
> That wasn't a bugfix, look harder.

My apologies.  I should have written "if a driver is in the
tree, it should be fair game to improve it."

I think I'm missing something in this exchange.  Are you

1) Pointing out that the qlogicfc is obsolete and shouldn't
be used?  If so, thanks for the tip.

2) Suggesting that no changes to qlogicfc should be made?  If so,
I think it should be removed from the tree altogether.

3) Objecting to my patch because it is incorrect?  If so, please
give me a hint about what the problem is.

4) Something else?
