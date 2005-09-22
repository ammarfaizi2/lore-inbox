Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbVIVSmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVIVSmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 14:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVIVSmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 14:42:09 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:22020 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751044AbVIVSmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 14:42:08 -0400
Message-ID: <4332FAD8.50800@tmr.com>
Date: Thu, 22 Sep 2005 14:41:28 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Kesterson <robertk@robertk.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.13] drivers/ide: Enable basic VIA VT6410 IDE functionality
References: <op.sxg2dxd5wc4mme@new.robertk.com>
In-Reply-To: <op.sxg2dxd5wc4mme@new.robertk.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Kesterson wrote:
> This patch enables plain IDE functionality on the VIA VT6410 IDE controller
> (such as used on the Asus P4P800 Deluxe motherboard).  This is not a RAID
> driver, but you can use Linux's software RAID once the drives are visible.
> I did not write the original version of this patch, which I found on the
> internet back in the days of kernel 2.6.2.  I have been unable to identify
> the original author to give him/her proper credit.  I have been maintaining
> and updating this patch since then and have released several updates which
> have been successfully used by others who have downloaded it from my
> website.
> 
> It seems appropriate that this minimal functionality should be in the
> mainstream kernel.

Thank you, I have been running with a similar patch for 2.4 series, but 
have been running unpatched kernels for testing and have not had access 
to my other drives. Hopefully this can get into the mainstream without 
too much delay.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
