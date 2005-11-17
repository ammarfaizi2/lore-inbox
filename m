Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVKQP60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVKQP60 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVKQP60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:58:26 -0500
Received: from ns2.g-housing.de ([81.169.133.75]:44523 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S932220AbVKQP6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:58:25 -0500
Message-ID: <437CA85A.9090408@g-house.de>
Date: Thu, 17 Nov 2005 16:57:14 +0100
From: Christian <evil@g-house.de>
User-Agent: Mail/News 1.6a1 (Windows/20051004)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: netdev@vger.kernel.org
Subject: Re: 2.6.15-rc1: NET_CLS_U32 not working?
References: <437BBC59.70301@g-house.de> <20051116235813.GS5735@stusta.de> <437BC98E.9020002@g-house.de>
In-Reply-To: <437BC98E.9020002@g-house.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0546-3, 16.11.2005), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian schrieb:
> Adrian Bunk schrieb:
>>
>> I'm assuming you are trying to insert the new module in your old kernel?

yes, rebuilding the whole kernel (after just enabling NET_CLS_U32 as a 
module) makes the warnings go away.

>> This is one of the unfortunate but hardly avoidable cases where adding 
>> a module requires installing a new kernel.

i wonder why/if this is really needed. although not critical, this 
behaviour is pretty annoying....

thanks,
Christian.
-- 
BOFH excuse #24:

network packets travelling uphill (use a carrier pigeon)
