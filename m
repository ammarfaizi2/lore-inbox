Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWBGDng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWBGDng (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWBGDng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:43:36 -0500
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:31167 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S964959AbWBGDng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:43:36 -0500
Message-ID: <43E81766.20000@comcast.net>
Date: Mon, 06 Feb 2006 22:43:34 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: alan@lxorguk.ukuu.org.uk, harald.dunkel@t-online.de,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion + tsc sync issues
References: <Pine.LNX.4.58.0601250846210.29859@shark.he.net>	<43E3D103.70505@comcast.net>	<Pine.LNX.4.58.0602060836520.1309@shark.he.net>	<43E7A4C0.4020209@t-online.de>	<1139255800.10437.51.camel@localhost.localdomain>	<43E805D4.5010602@comcast.net>	<43E7F73E.2070004@comcast.net> <20060206173520.43412664.akpm@osdl.org>
In-Reply-To: <20060206173520.43412664.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Ed Sweetman <safemode@comcast.net> wrote:
>  
>
>
>(eek, top-posting!)
>
>  
>
>>2.6.16-rc2 with the libata patch alan cox provided resulted in a system 
>>which correctly found my atapi drive on the pata bus.  
>>
>>Also, moving from the mm kernels to 2.6.16-rc2 resulted in my pm timer 
>>working again. 
>>    
>>
>
>I don't recall that.  Even 2.6.16-rc1-mm5?  What about rc1-mm4?
>
>  
>


yes, 2.6.16-rc1-mm5 was the last kernel I was using before getting out 
of mm. 
I never tried mm4, but mm2 was also affected. 




