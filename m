Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUDOXes (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 19:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUDOXes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 19:34:48 -0400
Received: from mhub-m6.tc.umn.edu ([160.94.23.36]:22459 "EHLO
	mhub-m6.tc.umn.edu") by vger.kernel.org with ESMTP id S261981AbUDOXeg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 19:34:36 -0400
Message-Id: <407F1C07.6050104@umn.edu>
Date: Thu, 15 Apr 2004 18:34:31 -0500
From: Simon Koch <koch0121@umn.edu>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040401)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ryan Geoffrey Bourgeois <rgb005@latech.edu>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: poor sata performance on 2.6
References: <200404150236.05894.kos@supportwizard.com> <1082001287.407e0787f3c48@webmail.LaTech.edu> <200404151455.36307.kos@supportwizard.com> <1082044297.407eaf894ddda@webmail.LaTech.edu>
In-Reply-To: <1082044297.407eaf894ddda@webmail.LaTech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Geoffrey Bourgeois wrote:

>>I'm almost ready to buy separate controller, but all that I could find nearby
>>
>>are based on the same Silicon Image chipset
>>
>>    
>>
>
>I do recomend Promise's SATA controller cards.  The kernel drivers are excellent
>imho.  As well as my onboard Promise TX2, I'm using a thei S150 SX4 RAID5
>capable controller in my file server.  A controlle ard should be easy enough to
>finnd online.  I shop at NewEgg.com.  Good prices, highly rcommended.
>
>I'm gonna take a look at your .config as soon as I get back to my own computer.
>
>Cheers.
>-Ryan
>
>-------------------------------------------------
>This mail sent through IMP: http://horde.org/imp/
>

What kernel/driver are you using for the S150 SX4?  I couldn't ever get 
better than 13MB/sec from it in 2.6.  Of course, the last I tried was 
2.6.3.  I could get 55MB/sec using 2.4 and Promise's partial source 
driver, but since my onboard SATA controller works fine in 2.6 I'm just 
using that meanwhile.

Thanks,
    Simon
