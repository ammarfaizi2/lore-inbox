Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264177AbTE0VTx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTE0VTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:19:53 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:12789 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S264193AbTE0VTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:19:52 -0400
Message-ID: <3ED3D98F.9070501@yahoo.com>
Date: Tue, 27 May 2003 22:33:03 +0100
From: Chris Rankin <rankincj@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-gb, en-us
MIME-Version: 1.0
To: marcelo@conectiva.com.br
CC: alan@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Mainly due to a IDE DMA problem which would happen on boxes with lots of
 > RAM, here is -rc5.

Hmm, should I say "Thanks, Santa!", or is this a completely different problem 
from the one I reported on Saturday 24th May:

"[BUG] IDE DMA timeout, then crash on reenable (2.4.20-SMP)"?

If this fix *is* related to my bug report then is there any way that I can test 
this, now that we know what might be causing it? My usual way of reproducing it 
is "boot, then wait for 28+ days of uptime", which doesn't sound like a part of 
a plan to get 2.4.21 out the door...

Cheers,
Chris


