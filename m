Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274896AbTHPP5A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 11:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274897AbTHPP5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 11:57:00 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:42209 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S274896AbTHPP46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 11:56:58 -0400
Message-ID: <3F3E38AE.1040902@cornell.edu>
Date: Sat, 16 Aug 2003 09:59:10 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: walt <wa1ter@myrealbox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 current - compile error - no member named 'name'
References: <3F3E288B.3010105@cornell.edu> <3F3DD93E.7090706@myrealbox.com>
In-Reply-To: <3F3DD93E.7090706@myrealbox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt wrote:
> Ivan Gyurdiev wrote:
> 
>> Hopefully, this is not a duplicate post:
>> ===========================================
>>
>> drivers/ieee1394/nodemgr.c: In function `nodemgr_update_ud_names':
>> drivers/ieee1394/nodemgr.c:471: error: structure has no member named 
>> `name'
> 
> 
> I got a similar error starting with last night's bk pull:
> 
> drivers/pnp/core.c: In function `pnp_register_protocol':
> drivers/pnp/core.c:72: structure has no member named `name'
> 
> -

And I just got another one of those trying to compile the nvidia driver 
for this kernel. So apparently this is not firewire or pnp specific.




