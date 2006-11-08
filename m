Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965917AbWKHPVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965917AbWKHPVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 10:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965919AbWKHPVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 10:21:16 -0500
Received: from smtpauth03.prod.mesa1.secureserver.net ([64.202.165.183]:28381
	"HELO smtpauth03.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S965917AbWKHPVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 10:21:15 -0500
Message-ID: <4551F5B7.1050709@seclark.us>
Date: Wed, 08 Nov 2006 10:20:23 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
Subject: Re: New laptop - problems with linux
References: <4551EC86.5010600@seclark.us> <4551F3A6.8040807@gmail.com>
In-Reply-To: <4551F3A6.8040807@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:

>Stephen Clark wrote:
>  
>
>>Hi list,
>>
>>I just purchased a VBI-Asus S96F laptop Intel 945GM &  ICH7, with a Core
>>2 Duo T560,0 2gb pc5400 memory.
>>From checking around it appeared all the
>>hardware was well supported by linux - but I am having major problems.
>>
>>
>>1. neither the wireless lan Intel pro 3945ABG or built in ethernet
>>RTL-8169C are detected and configured
>>    
>>
>
>If you searched the web, you would get ipw3945 sourceforge homepage in return --
>it's not in the vanilla kernel for the time being.
>
>Is r8169 module loaded?
>
>  
>
No it is not loaded - i did a modprobe on it and it loaded but still no 
ethx device.

>regards,
>  
>


-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



