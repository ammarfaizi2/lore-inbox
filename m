Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268353AbUIKVnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268353AbUIKVnB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 17:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUIKVnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 17:43:01 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:9628 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268347AbUIKVl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 17:41:57 -0400
Message-ID: <9e47339104091114411aeb3c78@mail.gmail.com>
Date: Sat, 11 Sep 2004 17:41:56 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Eric Anholt <eta@lclark.edu>
Subject: Re: radeon-pre-2
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1094934573.884.59.camel@leguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <20040911132727.A1783@infradead.org>
	 <9e47339104091109111c46db54@mail.gmail.com>
	 <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
	 <9e473391040911101331a584ec@mail.gmail.com>
	 <1094934573.884.59.camel@leguin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 13:29:33 -0700, Eric Anholt <eta@lclark.edu> wrote:
> To summarize, there is no "2d mode" and "3d mode."  Please stop
> referring to it.  If you were actually trying to talk about
> synchronization for MMIO vs DMA command submission (which is and would

You are right on all of this, I'm just using 2D and 3D as shorthand
for GPU coprocessor/DMA vs CPU/registers. Don't take this as literally
meaning 2D vs 3D.

-- 
Jon Smirl
jonsmirl@gmail.com
