Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266298AbSLIXaI>; Mon, 9 Dec 2002 18:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbSLIXaI>; Mon, 9 Dec 2002 18:30:08 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:27145 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266298AbSLIXaH>; Mon, 9 Dec 2002 18:30:07 -0500
Date: Mon, 9 Dec 2002 23:37:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK fbdev] Yet again more fbdev updates.
Message-ID: <20021209233749.A8008@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Simmons <jsimmons@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
References: <Pine.LNX.4.33.0212091621180.2360-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0212091621180.2360-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Mon, Dec 09, 2002 at 04:23:08PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 04:23:08PM -0800, James Simmons wrote:
> 
> Hi Linus!!!
> 
>   Here are the fbdev updates people have so been waiting for. Several
> drivers have been ported. Many fixes have been implemented and many nice
> features have been added as well. Please pull the changes. They have been
> tested by people on this list. Thank you.
> 
> bk://fbdev.bkbits.net/fbdev-2.5

Linus,

any chance you could pull James' updates?  He has been sending fbdev updates
that fix known issues with many drivers for a long time but I can't even
remember when you merged it the last time.  Most fbdev drivers are pretty
unusable in mainline without his fixes.

James,

could you please provide diffstat output, bk changes -L output and a
unified diff for review of the actual changes?
