Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTE2Luv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 07:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTE2Luu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 07:50:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:51915 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262175AbTE2Lut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 07:50:49 -0400
Message-ID: <3ED5F7ED.7060302@onlinehome.de>
Date: Thu, 29 May 2003 14:07:09 +0200
From: Hans-Georg Thien <1682-600@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: wwp <subscript@free.fr>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] "Disable Trackpad while typing" on Notebooks withh
 aPS/2 Trackpad
References: <3EB19625.6040904@onlinehome.de>	<3EBAAC12.F4EA298D@hp.com>	<3ED3CECA.9020706@onlinehome.de> <20030527231026.6deff7ed.subscript@free.fr>
In-Reply-To: <20030527231026.6deff7ed.subscript@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wwp wrote:
> Hi Hans-Georg Thien,
> 
> 
> On Tue, 27 May 2003 22:47:06 +0200 Hans-Georg Thien <1682-600@onlinehome.de>
> wrote:
> 
> 
>>Hans-Georg Thien wrote:
> 
> [snip]
> 
>>It it is now possible to adjust some settings via
>>
>>       echo ???? > /proc/tty/ps2-trackpad
>>
>>(1) Set the delay time to 2 Secs (default is 10 ==> 1 Sec)
>>
>>         echo "delay 20" > /proc/tty/ps2-trackpad
>>
>>
>>(2)  Completely disable the trackpad (default 0). Useful if you plug in 
>>an external mouse.
>>
>>         echo "disable 1" > /proc/tty/ps2-trackpad
>>
>>(3)  Escape the keyboard scancode for a key. These scancodes are
> 
> [snip]
> 
> Sounds good, thanx for your work, guy :-).
> Do you think/know if this patch will be merged to the official tree?
> 
I hope, of course ... If you know a way to enforce it - let me know!

