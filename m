Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTDOSb7 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbTDOSb7 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:31:59 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:62148 "EHLO
	mta4.rcnstx.swbell.net") by vger.kernel.org with ESMTP
	id S263564AbTDOSb6 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 14:31:58 -0400
Message-ID: <3E9C553A.9020402@pacbell.net>
Date: Tue, 15 Apr 2003 11:53:46 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Robert Schwebel <robert@schwebel.de>
CC: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] ANNOUNCE:  Linux "USB Gadget" API and Driver
 Framework
References: <3E889C26.7010704@pacbell.net> <20030415180240.GS10886@pengutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:
> 
> is anybody working on PXA25x drivers yet? I would like to avoid
> duplicate work. 

Not that I know of -- though I have some bits
that might help someone get started, perhaps
in combination with the sa11x0-ish code that
I found starting at www.handhelds.org.

If you're going to start, more power to you!!

I think a PXA-25x driver will be interesting
to a lot of people.  Its USB support looks to
be flexible enough to support quite a lot of
interesting Linux-based applications:  lots of
endpoints, including ISO support.

- Dave



