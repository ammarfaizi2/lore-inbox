Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265948AbUAKV4j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 16:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUAKV4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 16:56:39 -0500
Received: from adsl-67-114-19-185.dsl.pltn13.pacbell.net ([67.114.19.185]:58246
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S265948AbUAKV4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 16:56:35 -0500
Message-ID: <4001C68D.4010108@tupshin.com>
Date: Sun, 11 Jan 2004 13:56:29 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla Thunderbird 0.5a (20031216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: The NeverGone <never@delfin.klte.hu>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: UML (user-mode-linux) kernel-2.6.x
References: <Pine.LNX.4.58.0401112222030.1401@localhost>
In-Reply-To: <Pine.LNX.4.58.0401112222030.1401@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NeverGone wrote:

>Hi...
>
>
>  
>
>>Look at the second item called:
>>FAQ: "I'm tracing myself and I can't get out"
>>There is an associated patch which needs to be applied to the UML
>>*guest* when running on a 2.6 host.
>>    
>>
>
>It's compliled into the Kernel, but it's still not works at all...
>  
>
The guest UML kernel??? Works for me. What guest kernel are you running?

>
>  
>
>>This patch:
>>http://sdw.st/src/uml/linux-2.6.1-skas3.patch
>>    
>>
>
>
>This patch cant be used with the -mm2 patch
>  
>
That patch is absolutely not necessary to get basic uml functionality 
working. It provides the possibility of better performance and more 
isolation from the host, but it is not needed.

-Tupshin
