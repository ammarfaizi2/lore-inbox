Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbTKRVvs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 16:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTKRVvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 16:51:48 -0500
Received: from main.gmane.org ([80.91.224.249]:22176 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263803AbTKRVvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 16:51:47 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Parick Beard <patrick@p-beard.com>
Subject: Re: Smartmedia 2.6.0-test9 problem.
Date: Tue, 18 Nov 2003 21:51:25 +0000
Message-ID: <pan.2003.11.18.21.51.11.828965@p-beard.com>
References: <bpcumv$v22$1@sea.gmane.org> <20031118174828.GA26450@axis.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder if you are seeing the same thing I see...
> 
> I have several different sized memory cards which I use using a usb
> adaptor.  The kernel (I've only tried 2.4 not 2.6) recognises the
> first one fine, but refuses to update its internal knowledge of the
> size of the card so if I insert a different sized one it doesn't mount
> properly.
> 
> The work-around I use is to "rmmod usb-storage ; modprobe usb-storage"
> whenever I change memory card - this kicks the kernel into re-reading
> the size of the media (or maybe the partition table) and it all works
> fine after that.
> 
> This obviously isn't ideal but I haven't found a better solution.

Nick,

Thanks for that thought. I only recently found out about that. It led me
to interpret my problem wrongly the first time.
Unfortunately  this is not my problem. On a clean boot I can't mount the
64mb card in the reader, yet if I plug my camera in I can mount it there.
The 16mb card however mounts no problem in the reader.

As an alternative to the fix for the problem you see. Here is a link I
found that towards the bottom of the page has a solution. I haven't tried
it myself, but it might interest you.

http://bmiller.customer.netspace.net.au/linux/c5050.html

If ever I get my problem sorted I'll give it a try myself.

--
Patrick

