Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270518AbRHNIZU>; Tue, 14 Aug 2001 04:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270520AbRHNIZL>; Tue, 14 Aug 2001 04:25:11 -0400
Received: from mail12.svr.pol.co.uk ([195.92.193.215]:30233 "EHLO
	mail12.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S270518AbRHNIZC>; Tue, 14 Aug 2001 04:25:02 -0400
Message-ID: <3B78E062.30009@humboldt.co.uk>
Date: Tue, 14 Aug 2001 09:25:06 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: tegeran@home.com
CC: linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio driver bug?
In-Reply-To: <01081307194201.00276@c779218-a> <3B77EFE6.9020106@humboldt.co.uk> <01081321090000.00204@c779218-a>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Knight wrote:
> Keep in mind, this isn't a *total* lockup, it's a problem of the UI in 
> XMMS and other applications becoming unresponsive. Audio skips from this 
> are rare but not unknown to me.

What's difficult is that it doesn't happen to all of us. I can turn the 
volume up and down through XMMS or through the Gnome mixer without the 
slightest problem while playing MP3s. I haven't yet worked out the 
pattern which marks when this occurs.

Could people having this problem send me the following info, and I'll 
summarise any pattern I spot:

lspci -x of the Via southbridge function 5
Motherboard
Processor
Kernel/driver versions
AC97 Codec ID (IMPORTANT)

-- 
Adrian Cox   http://www.humboldt.co.uk/

