Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267749AbUH1AQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267749AbUH1AQl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 20:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUH1AQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 20:16:41 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:28132 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267749AbUH1AQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 20:16:26 -0400
Date: Sat, 28 Aug 2004 01:16:24 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: "David S. Miller" <davem@davemloft.net>
Cc: hch@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: drm fixup 1/2 - missing bus_address assignment
In-Reply-To: <20040827171208.51f2811d.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0408280114570.23054@skynet>
References: <Pine.LNX.4.58.0408271510530.32411@skynet> <20040827152110.A31641@infradead.org>
 <Pine.LNX.4.58.0408280054580.23054@skynet> <20040827171208.51f2811d.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You really have to use the defined DMA apis for stuff like this.
>
> I was going to bark about this too.
>
> Check out Documentation/DMA-mapping.txt and friends.

I'll check it out and submit a patches ripping them all out .. there's a
couple in the mga...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

