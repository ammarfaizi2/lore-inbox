Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262821AbULRCiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbULRCiq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 21:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbULRCiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 21:38:46 -0500
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:45947 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262821AbULRCio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 21:38:44 -0500
Message-ID: <41C39833.40103@blueyonder.co.uk>
Date: Sat, 18 Dec 2004 02:38:43 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3 vs clock
References: <41C3746D.8090308@blueyonder.co.uk> <200412171938.05269.gene.heskett@verizon.net>
In-Reply-To: <200412171938.05269.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2004 02:39:13.0613 (UTC) FILETIME=[C2BFA7D0:01C4E4AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Friday 17 December 2004 19:06, Sid Boyce wrote:
> 
>>Bill Davidsen wrote:
>>
>>Gene Heskett wrote:
>>
>>clocks...
>>
>>Gene Heskett suggested I play around with tickadj and I found that a
>>value of 9962 on this SuSE 9.2/XP3000+ has kept it rock solid over
>>the last 4 days. On the x86_64 laptop with XP3000+-Mobile, it's
>>never been out, both of them running 2.6.10-rc3 and using ntpd to
>>keep in step. On the other box with Mandrake 10.1/XP2800+ and
>>2.6.10-rc3, I had to set it to 9958. Something has definitely
>>changed with 2.6.10-rc3.
>>Regards
>>Sid.
> 
> 
> Thats not as far off as I was here Sid. I have to use 9926 on this
> box, an XP2800 athlon with a gig of ram, and high mem turned on.
> 
> And your quoting mechanism in that MTA is broken Sid. :)
> 

Quoting was done manually as I am not subscribed.
Regards
Sid.
-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====
