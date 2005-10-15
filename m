Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVJOPN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVJOPN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 11:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVJOPN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 11:13:58 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:7653 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751171AbVJOPN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 11:13:58 -0400
Message-ID: <43511CAD.2010209@m1k.net>
Date: Sat, 15 Oct 2005 11:13:49 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Damir Perisa <damir.perisa@solnet.ch>,
       Benoit Boissinot <bboissin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Documentation/files somewhere online?
References: <43505F86.1050701@perkel.com> <40f323d00510150640q1b1a996p85c9b4ff468de346@mail.gmail.com> <200510151653.03747.damir.perisa@solnet.ch> <200510151802.27120.vda@ilport.com.ua>
In-Reply-To: <200510151802.27120.vda@ilport.com.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>On Saturday 15 October 2005 17:52, Damir Perisa wrote:
>  
>
>>is somebody keeping a online version of the kernel source docs (i mean the 
>>Documentation/* files) somewhere for surfing? i want to point people to 
>>pages with links without forcing them to download the sources to read 
>>what i tell them to.
>>    
>>
>http://lxr.linux.no/source/Documentation/
>  
>
I think that using the -git web interface to Linus' tree on kernel.org 
is even better.

The following is a link to the top-level of the kernel source tree:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree

You will notice a Documentation tree link (3rd file object link from the 
top).

This will get you the most current Documentation at the moment from 
Linus' tree, and it also gives you the ability to see the history of 
changes.

Hope this helps.

-- 
Michael Krufky

