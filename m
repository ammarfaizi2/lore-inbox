Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268251AbUHQOg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268251AbUHQOg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268248AbUHQOg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:36:58 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:19152 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268267AbUHQOgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:36:37 -0400
Message-ID: <41221890.8070307@sgi.com>
Date: Tue, 17 Aug 2004 09:39:12 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq deprecation
References: <20040817105859.GA1497@elf.ucw.cz>
In-Reply-To: <20040817105859.GA1497@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

A scan of the lkml archives on theaimsgroup for cpufreq shows only this 
message about deprecation.  Where was this discussed?  Is there an alternative 
for this information being proposed?

Thanks,

Ray

Pavel Machek wrote:
> Hi!
> 
> Today I learned that /proc/cpufreq is going to be removed from
> 2.6.. I thought that 2.6 means "no interface changes" :-(. Anyway, if
> we are going to warn about it, we might want to include newline...
> 
> Please apply,
> 								Pavel


-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

