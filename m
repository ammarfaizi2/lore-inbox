Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUAKWdJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUAKWdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:33:09 -0500
Received: from adsl-67-114-19-185.dsl.pltn13.pacbell.net ([67.114.19.185]:4745
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S266009AbUAKWdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:33:06 -0500
Message-ID: <4001CF1F.9080901@tupshin.com>
Date: Sun, 11 Jan 2004 14:33:03 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla Thunderbird 0.5a (20031216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: The NeverGone <never@delfin.klte.hu>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: UML (user-mode-linux) kernel-2.6.x
References: <Pine.LNX.4.58.0401112222030.1401@localhost> <4001C68D.4010108@tupshin.com> <Pine.LNX.4.58.0401112300020.1585@localhost> <4001C9DC.4070505@tupshin.com> <Pine.LNX.4.58.0401112313350.1696@localhost>
In-Reply-To: <Pine.LNX.4.58.0401112313350.1696@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NeverGone wrote:

>On Sun, 11 Jan 2004, Tupshin Harper wrote:
>
>  
>
>>Is that guest 2.4.23 kernel stock, with only the mentioned patch (pasted
>>below) applied?
>>
>>Are you absolutely positive that you rebuilt that guest kernel with the
>>patch???(I'm guessing that this is really the problem)
>>
>>Are you still getting the same error message? ("I'm tracing myself...")
>>
>>-Tupshin
>>
>>
>>    
>>
>
>Hi...
>
>It's also included in the host kernel (2.6.1-mm2) ...
>
>Thx...
>
>The NeverGone :)
>
>  
>
You didn't answer any of my questions. I'm forced to believe that the 
guest is either not properly patched, not properly rebuilt, or not 
actually the version that you're running. Not much I can suggest other 
than to recheck those things.

On the odd chance that 2.6.1-mm2 reintroduces a new version of this 
problem that the mentioned patch doesn't fix, you could try the host 
running stock 2.6.1.

Also, I inadvertently referred to stock 2.4.23, but of course you would 
have had to apply a large uml patch to it in order to compile it at all. 
Did you? If so, which patch, from where?

-Tupshin

