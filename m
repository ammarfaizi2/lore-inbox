Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbUKEUFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUKEUFw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 15:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUKEUFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 15:05:51 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:23046 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261194AbUKEUFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 15:05:39 -0500
Date: Fri, 5 Nov 2004 21:00:21 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Adam Heath <doogie@debian.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Chris Wedgwood <cw@f00f.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
Message-ID: <20041105200021.GA30993@alpha.home.local>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org> <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com> <20041103233029.GA16982@taniwha.stupidest.org> <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com> <418A603A.3030806@nortelnetworks.com> <Pine.LNX.4.58.0411041216240.1229@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411041216240.1229@gradall.private.brainfood.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 12:17:01PM -0600, Adam Heath wrote:
> > You're posting to the kernel development list--many people here recompile dozens
> > of times a day.
> 
> So find the fastest computer you have, and use that.  There is no need to
> compile a kernel on the machine it will be run on.

Uhh ?

What are you smoking ? We all have the fastest computers we can buy, and
since a kernel still takes a few minutes to compile on those computers,
we try to use the fastest compilers to save *HOURS* at the end of the day.
Nobody ever claimed that we all spend our time compiling on the target
system. I wonder if thas would be possible on a 16 MB/200 MHz MIPS ;-)

That's it.

Willy

