Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263554AbTHXMVB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbTHXMVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:21:01 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:15109 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263554AbTHXMU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:20:59 -0400
Date: Sun, 24 Aug 2003 13:20:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] macide (was: Re: Linux 2.6.0-test4)
Message-ID: <20030824132058.A16763@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org> <Pine.GSO.4.21.0308241342190.14814-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0308241342190.14814-100000@waterleaf.sonytel.be>; from geert@linux-m68k.org on Sun, Aug 24, 2003 at 01:51:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2003 at 01:51:20PM +0200, Geert Uytterhoeven wrote:
> On Fri, 22 Aug 2003, Linus Torvalds wrote:
> > Bartlomiej Zolnierkiewicz:
> >   o ide: disk geometry/capacity cleanups
> >   o ide: always store disk capacity in u64
> 
> You forgot to update the Macintosh IDE driver:

Btw, what's the state of mac68k (and the other m68k subarches) on
2.6?

