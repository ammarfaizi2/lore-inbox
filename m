Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbTEIFzI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 01:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbTEIFzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 01:55:08 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:6389 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261184AbTEIFzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 01:55:07 -0400
Message-ID: <3EBB45A2.2030809@nortelnetworks.com>
Date: Fri, 09 May 2003 02:07:30 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
References: <3EBAD63C.4070808@nortelnetworks.com>	<20030509001339.GQ8978@holomorphy.com>	<Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com>	<20030509003825.GR8978@holomorphy.com>	<Pine.LNX.4.53.0305082052160.21290@chaos>	<3EBB25FD.7060809@nortelnetworks.com> <52k7d0lpuy.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Chris> I want to find an additional programmable interrupt source.
>     Chris> It bites that cheap PCs have this, and the powerpc doesn't.

> On something like the Motorola 74xx, you might be able to use the
> something like the performance monitor to generate an exception.

That's the chip.  I'll look into that further--thanks for the suggestion.

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

