Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUIFER6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUIFER6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 00:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267438AbUIFER6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 00:17:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41417 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267431AbUIFER4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 00:17:56 -0400
Date: Sun, 5 Sep 2004 21:17:55 -0700
From: Paul Jackson <pj@sgi.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org
Subject: Re: [RFC] DRM remove DMA/IRQ macros..
Message-Id: <20040905211755.6b151f0d.pj@sgi.com>
In-Reply-To: <20040905204530.491dc4f1.davem@davemloft.net>
References: <Pine.LNX.4.58.0409051015570.14009@skynet>
	<20040905203622.32f75496.davem@davemloft.net>
	<Pine.LNX.4.58.0409060440320.22266@skynet>
	<20040905204530.491dc4f1.davem@davemloft.net>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David wrote:
> Ask Andrew Morton for pointers to handy sparc64 cross

The ones I use (after I broke every build from here to Kingdom Come with
my dreaded cpumask patch ;) are I believe the same ones Andrew recommends:

  Cross-Compile Tool Chains used in Patch LifeCycle Manager
  http://developer.osdl.org/dev/plm/cross_compile/

They work pretty slick - download, unpack, set the specified ENV
variables, and build away.  I build several arch's on my desktop PC.

I did report a breakage in the alpha build a couple of weeks ago to an
email I found embedded in the tools, and haven't heard anything back. 
Don't know if that's been addressed or not.  I should send that message
out again.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
