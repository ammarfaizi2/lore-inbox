Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVCZSlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVCZSlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 13:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVCZSlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 13:41:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:42192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261208AbVCZSlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 13:41:02 -0500
Message-ID: <4245ACB3.1080105@osdl.org>
Date: Sat, 26 Mar 2005 10:40:51 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][trivial] fix tiny spelling error in init/Kconfig and
 write "so-called" instead of "so called" and "socalled" everywhere.
References: <Pine.LNX.4.62.0503260225170.2463@dragon.hyggekrogen.localhost> <4244D2BC.9000204@osdl.org> <Pine.LNX.4.62.0503261130550.2437@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0503261130550.2437@dragon.hyggekrogen.localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On Fri, 25 Mar 2005, Randy.Dunlap wrote:
> 
> 
>>Jesper Juhl wrote:
>>
>>>Fix spelling in init/Kconfig
>>>
>>>Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
>>>
>>>--- linux-2.6.12-rc1-mm3-orig/init/Kconfig	2005-03-25 15:29:08.000000000
>>>+0100
>>>+++ linux-2.6.12-rc1-mm3/init/Kconfig	2005-03-26 02:24:33.000000000 +0100
>>>@@ -83,7 +83,7 @@
>>> 	default y
>>> 	help
>>> 	  This option allows you to choose whether you want to have support
>>>-	  for socalled swap devices or swap files in your kernel that are
>>>+	  for so called swap devices or swap files in your kernel that are
>>> 	  used to provide more virtual memory than the actual RAM present
>>> 	  in your computer.  If unsure say Y.
>>
>>I would prefer (and write) "so-called".
>>
> 
> I believe both "so called" and "so-called" are valid, but "so-called" 
> seems to be more common in the Kconfig files already. So let's be 
> consistent about it.
> 
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

I agree.  Thanks.

-- 
~Randy
