Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266397AbUHNKzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266397AbUHNKzz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 06:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUHNKzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 06:55:55 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:50948 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266397AbUHNKzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 06:55:54 -0400
Date: Sat, 14 Aug 2004 11:55:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matthew Wilcox <willy@debian.org>
Subject: Re: Linux v2.6.8 - Oops on NFSv3
Message-ID: <20040814115548.A19527@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Willy Tarreau <willy@w.ods.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matthew Wilcox <willy@debian.org>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org> <20040814101039.GA27163@alpha.home.local> <Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org>; from torvalds@osdl.org on Sat, Aug 14, 2004 at 03:49:00AM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 03:49:00AM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 14 Aug 2004, Linus Torvalds wrote:
> > 
> > Andrew, since I'm gone in another hour, how about you try to make a
> > 2.6.8.1 with this, since this is clearly a good reason for one?
> 
> Ahh. Jeff posted the right one, obviously. Pushed to BK.
> 
> I'll make a 2.6.8.1 myself, to make it usable for people with NFS.

Cane we make this 2.6.9 to avoid breaking all kinds of scripts expecting
three-digit kernel versions?

