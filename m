Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267862AbTBKOQV>; Tue, 11 Feb 2003 09:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267865AbTBKOQV>; Tue, 11 Feb 2003 09:16:21 -0500
Received: from lucidpixels.com ([66.45.37.187]:57862 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S267862AbTBKOQT>;
	Tue, 11 Feb 2003 09:16:19 -0500
Message-ID: <3E490800.9070305@lucidpixels.com>
Date: Tue, 11 Feb 2003 09:26:08 -0500
From: jpiszcz <jpiszcz@lucidpixels.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gianni Tedesco <gianni@ecsc.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Evil bug in netfilter/kernel 2.4.x?
References: <3E482899.9070906@lucidpixels.com> <1044966716.1118.82.camel@lemsip>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Other packets are shown as dropped by tcpdump, apparently others said 
this is not a bug.
Also tried to log them etc, so either way was unsuccessful.

Gianni Tedesco wrote:

>On Mon, 2003-02-10 at 22:32, jpiszcz wrote:
>  
>
>>However, when I run tcpdump, I can clearly see these are not getting 
>>dropped or logged by the kernel.
>>    
>>
>
>Could your problem actually be a testing flaw? tcpdump sees firewalled
>packets since it works at packet level, below the IP stack.
>
>  
>


