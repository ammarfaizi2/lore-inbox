Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268769AbUJPQCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268769AbUJPQCm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 12:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268771AbUJPQCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 12:02:42 -0400
Received: from [82.154.234.21] ([82.154.234.21]:8064 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S268769AbUJPQCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 12:02:40 -0400
Message-ID: <41714622.3090800@vgertech.com>
Date: Sat, 16 Oct 2004 17:02:42 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-bk3 - make[3]: *** [drivers/char/drm/gamma_drv.o] Error
 1
References: <4170C664.9000703@vgertech.com> <20041016093112.GA5307@stusta.de>
In-Reply-To: <20041016093112.GA5307@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
>>...
>>CONFIG_EXPERIMENTAL=y
>># CONFIG_CLEAN_COMPILE is not set
>>CONFIG_BROKEN=y
>>...
>>CONFIG_DRM_GAMMA=m
>>...
> 
> If you answer "yes" to
> 
>   "Prompt for development and/or incomplete code/drivers"
> 
> and "no" to
> 
>   "Select only drivers expected to compile cleanly"
> 
> it souldn't be a big surprise if a driver doesn't compile.
> 

Totally correct, my mistake.

Sorry for the false alarm.
Thanks,
Nuno Silva

