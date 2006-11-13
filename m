Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753872AbWKMEUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbWKMEUY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 23:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753877AbWKMEUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 23:20:24 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:57746 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1753872AbWKMEUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 23:20:23 -0500
Message-ID: <4557F287.7050807@vmware.com>
Date: Sun, 12 Nov 2006 20:20:23 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: caglar@pardus.org.tr
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Gerd Hoffmann <kraxel@suse.de>, john stultz <johnstul@us.ibm.com>
Subject: Re: [Opps] Invalid opcode
References: <200611051507.37196.caglar@pardus.org.tr> <200611051740.47191.ak@suse.de> <200611120439.56199.caglar@pardus.org.tr>
In-Reply-To: <200611120439.56199.caglar@pardus.org.tr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

S.Çağlar Onur wrote:
> 05 Kas 2006 Paz 18:40 tarihinde, Andi Kleen şunları yazmıştı: 
>   
>> And does it still happen in 2.6.19-rc4?
>>     
>
> Sorry for delayed test result, i cannot reproduce this panic with 2.6.19-rc5
>   

I would like to find the exact cause of the problem; I suspect, as does 
Andi, that it could just be dormant. You had problems still with 
2.6.18.latest, correct? If I can find the cause, I would like to get a 
fix into 2.6.18-stable if possible. I think you already sent me the 
reproducing kernel config, but I seem to have misplaced it. Could you 
resend? I should have some time to look at this early this week.

Thanks,

Zach
