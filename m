Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVKGRC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVKGRC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVKGRC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:02:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39137 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964875AbVKGRCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:02:55 -0500
Date: Mon, 7 Nov 2005 17:02:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1
Message-ID: <20051107170253.GA17785@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20051106182447.5f571a46.akpm@osdl.org> <20051107033009.GB12192@infradead.org> <Pine.LNX.4.61.0511071315530.1387@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511071315530.1387@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 01:18:26PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Mon, 7 Nov 2005, Christoph Hellwig wrote:
> 
> > gosh.  Can we please get one of the patches to allow m68k in mainline
> > merged?  roman has been blocking these since 2.6.13 at least.  Alternatively
> > just kill m68k from mainline due to lack of active maintainer.
> 
> It's not a problem on my part, Al is constantly vetoing these patches.
> I'm not taking this blame. :-(

You've threatened all kinds of nasty things in case Al's perfectly reasonable
patchkit goes in.  That's certainly what I would call blocking.  Your patch
split has clear disadvantages over the original ones, but I don't really
care which one we get as long as we get this bullshit sorted out.

