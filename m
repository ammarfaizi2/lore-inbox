Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264236AbUEXToB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbUEXToB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 15:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264430AbUEXToB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 15:44:01 -0400
Received: from lvs00-fl-n03.valueweb.net ([216.219.253.136]:64926 "EHLO
	ams003.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S264236AbUEXToA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 15:44:00 -0400
Message-ID: <40B2504B.6050208@coyotegulch.com>
Date: Mon, 24 May 2004 15:43:07 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040522)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: NUMA Questions
References: <1Zt9u-86V-3@gated-at.bofh.it> <m3n03xd3hr.fsf@averell.firstfloor.org>
In-Reply-To: <m3n03xd3hr.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> [hmm, didn't I answer this already?]

Yes, you did, and I applied the patch earlier, prior to rebuilding the 
kernel and (of course) updating the kernel headers. Then I recompiled 
the numa utilities, with the result I detailed in the original post. 
I've just double-checked that /usr/include/asm/unistd.h includes your patch.

..Scott

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Software Invention for High-Performance Computing
