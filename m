Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVCXJyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVCXJyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 04:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbVCXJyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 04:54:16 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:42959 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S262753AbVCXJyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 04:54:12 -0500
Message-ID: <42428FCE.7070901@qazi.f2s.com>
Date: Thu, 24 Mar 2005 10:00:46 +0000
From: Asfand Yar Qazi <ay1204@qazi.f2s.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041010
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
References: <3LwFC-4Ko-15@gated-at.bofh.it> <3LwYW-4Xx-11@gated-at.bofh.it> <3LwYZ-4Xx-25@gated-at.bofh.it>
In-Reply-To: <3LwYZ-4Xx-25@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>* "hardware firewall" -- sounds silly.  Pretty sure Linux doesn't support
>>it in any case.
>>
> 
> 
> probably just one of those things implemented in the binary drivers in
> software, just like the "hardware" IDE raid is most of the time (3ware
> being the positive exception there)
> 

http://www.neoseeker.com/Articles/Hardware/Previews/nvnforce4/3.html

You're right there - some semi-hardware support combined with drivers 
apparently result in lower CPU usage that software firewalls.  Apparently.

Actually, these people like it:
http://www.bjorn3d.com/read.php?cID=712&pageID=1096

However one feature that you can't laugh at is the fact that it can be 
made to block packets in the span of time between the OS being loaded 
up, and the "real" firewall coming up.  This small time span 
theoretically leaves the PC vulnerable, so I think this is the only 
use for "ActiveAmor Firewall".

However, this doesn't answer my original question (which I suppose I 
should have made clearer): can I get SATA II NCQ support in Linux with 
an nForce 4 chipset?


