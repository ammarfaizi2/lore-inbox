Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268228AbUJWGHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbUJWGHK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 02:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUJWGCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 02:02:37 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:65199 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268282AbUJWGAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 02:00:37 -0400
Message-ID: <4179F381.5090200@yahoo.com.au>
Date: Sat, 23 Oct 2004 16:00:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Alastair Stevens <alastair@altruxsolutions.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-ck1: swap mayhem under UT2004
References: <200410222346.32823.alastair@altruxsolutions.co.uk> <41799FE0.1020403@kolivas.org> <4179ED80.5090800@yahoo.com.au> <4179EE45.9080409@kolivas.org>
In-Reply-To: <4179EE45.9080409@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> 
> Lurking on the gentoo forums will reveal this:
> http://forums.gentoo.org/viewtopic.php?t=239686&postdays=0&postorder=asc&start=50 
> 
> 
> Cheers
> Con

Hmm thanks.

Alastair, can you compile sysrq support into the kernel, and
press Alt+SysRq+M when kswapd is going crazy. Then send me
the output of `dmesg`. That would be very helpful.

Nick
