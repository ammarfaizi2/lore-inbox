Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUJWFlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUJWFlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267618AbUJWFhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:37:12 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:13706 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267939AbUJWFfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 01:35:03 -0400
Message-ID: <4179ED80.5090800@yahoo.com.au>
Date: Sat, 23 Oct 2004 15:34:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Alastair Stevens <alastair@altruxsolutions.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-ck1: swap mayhem under UT2004
References: <200410222346.32823.alastair@altruxsolutions.co.uk> <41799FE0.1020403@kolivas.org>
In-Reply-To: <41799FE0.1020403@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Alastair Stevens wrote:

>> Any ideas?  Any more info required?
> 
> 
> I've seen reports of this happening since 2.6.9 _even on mainline_. 
> Something seems very sick with kswapd where it consumes massive amounts 
> of cpu. Can you reproduce without any -ck patches? Others have already 
> done so, but it seems to happen earlier with -ck.
> 

Where are the bug reports, please? I haven't seen any on lkml, but
I haven't been following too closely for the past few days.

Thanks
Nick
