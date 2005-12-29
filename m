Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVL2Mip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVL2Mip (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 07:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbVL2Mip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 07:38:45 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:24518 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1750700AbVL2Mip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 07:38:45 -0500
Message-ID: <43B3D8D3.30400@voltaire.com>
Date: Thu, 29 Dec 2005 14:38:43 +0200
From: Erez Zilber <erezz@voltaire.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: cannot boot 2.6.15-rc6 on Opteron machine
References: <43B3CA9E.7000804@voltaire.com> <1135857022.2935.19.camel@laptopd505.fenrus.org>
In-Reply-To: <1135857022.2935.19.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2005 12:38:44.0062 (UTC) FILETIME=[CE2097E0:01C60C74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Thu, 2005-12-29 at 13:38 +0200, Erez Zilber wrote:
>  
>
>>Hi,
>>
>>I've downloaded kernel 2.6.15-rc6 (had the same problem with rc7) and 
>>    
>>
>
>2.6.15-rc needs a newer udev version...
>
>
>  
>

Redhat AS4 comes with udev 039. I couldn't find a newer rpm for this distribution, so I cannot replace the current udev rpm.  I've downloaded the latest udev sources from http://www.us.kernel.org/pub/linux/utils/kernel/hotplug/ and installed it but I still get the same errors.


Erez
