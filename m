Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTFYLlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 07:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbTFYLlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 07:41:03 -0400
Received: from mail-02.iinet.net.au ([203.59.3.34]:10504 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262319AbTFYLlB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 07:41:01 -0400
Message-ID: <3EF98806.4080407@ii.net>
Date: Wed, 25 Jun 2003 19:31:18 +0800
From: Wade <neroz@ii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030618 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: Weird modem behaviour in 2.5.73-mm1
References: <200306242102.49356.kde@myrealbox.com> <200306250327.h5P3RwH8001577@turing-police.cc.vt.edu>
In-Reply-To: <200306250327.h5P3RwH8001577@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Tue, 24 Jun 2003 21:02:49 +0300, "ismail (cartman) donmez" <kde@myrealbox.com>  said:
>  
>
>>Hi All,
>>
>>First I did not tried 2.5.73 vanilla so this can be a bug in 2.5.73 itself . 
>>When I use my 56k modem to connect to internet it always hang up 5-6 minutes 
>>( sometimes like 1-2 minutes ) later. I checked with 2.5.72-mm1 and I got not
>>    
>>
> 
>  
>
>>hang-up whatsoever. I checked system logs and it just says :
>>
>>[pppd] Modem Hang Up
>>    
>>
>
>2.5.72-mm3 is fine for modem usage for me.
>
>2.5.73-mm1 threw this all 3 times I tried starting PPPD:
>
>Jun 24 22:37:48 turing-police pppd[1144]: Using interface ppp0
>Jun 24 22:37:48 turing-police pppd[1144]: Connect: ppp0 <--> /dev/ttyS14
>Jun 24 22:37:49 turing-police pppd[1144]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x9ed88e38> <pcomp> <accomp>]
>Jun 24 22:37:49 turing-police pppd[1144]: Modem hangup
>Jun 24 22:37:49 turing-police pppd[1144]: Connection terminated.
>
>i.e. it died a quick and horrid death.  I've not checked a plain 2.5.73 yet
>
I get the same issue in mm1, haven't tried vanilla either.

