Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVIPTqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVIPTqb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVIPTqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:46:31 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:20104 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751246AbVIPTqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:46:30 -0400
Message-ID: <432B2101.9080806@gmail.com>
Date: Fri, 16 Sep 2005 21:46:09 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Dominik Karall <dominik.karall@gmx.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kay.sievers@vrfy.org
Subject: Re: 2.6.14-rc1-mm1
References: <20050916022319.12bf53f3.akpm@osdl.org> <200509162042.07376.dominik.karall@gmx.net>
In-Reply-To: <200509162042.07376.dominik.karall@gmx.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall napsal(a):

>On Friday 16 September 2005 11:23, Andrew Morton wrote:
>  
>
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/2.
>>6.14-rc1-mm1/ (temp copy at
>>http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc1-mm1.gz)
>>    
>>
>
>I don't get a /dev/input/mice device with this kernel, so Xorg reports 
>following error (udev 070 in use):
>  
>
[snip]

I have the same problem. Version 2.6.13-mm3 was OK and the new version 
was only oldconfigured. When I create appropriate devices with mknod, it 
is ok. So why does not udev (58 and 70) create that devices (event, 
mice, mouse, wacom)?

thanks,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

