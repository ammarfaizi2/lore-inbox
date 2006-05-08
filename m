Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWEHOtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWEHOtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWEHOtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:49:19 -0400
Received: from wip-ec-mm01.wipro.com ([203.91.193.25]:58312 "EHLO
	wip-ec-mm01.wipro.com") by vger.kernel.org with ESMTP
	id S932267AbWEHOtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:49:19 -0400
Message-ID: <445F5BC0.9040707@wipro.com>
Date: Mon, 08 May 2006 20:24:56 +0530
From: Madhukar Mythri <madhukar.mythri@wipro.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Mittendorfer <delist@gmx.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to read BIOS information
References: <445F5228.7060006@wipro.com> <20060508163630.1059bd9a.delist@gmx.net>
In-Reply-To: <20060508163630.1059bd9a.delist@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But, HT information is not present in demicode(SMBIOS info..)


Richard Mittendorfer wrote:

>Also sprach Madhukar Mythri <madhukar.mythri@wipro.com> (Mon, 08 May
>2006 19:44:00 +0530):
>  
>
>>Hi,
>>     Im new to this group.
>>I want to get some information from BIOS. i.e i want to know whether 
>>Hyperthreading is Enabled/Disabled(as per BIOS settings)  from an user
>>applications program.
>>    
>>
>
>Maybe dmidecode[1] is something for you. However, I'm not sure about HT
>there. It's userspace.
>
>apt-get install dmidecode or
>[1] http://www.nongnu.org/dmidecode/
>
>sl ritch
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


-- 
Thanks & Regards
Madhukar Mythri
Wipro Technologies
Bangalore.
Off: +91 80 30294361.
M: +91 9886442416.

