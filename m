Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTD2GpO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 02:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTD2GpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 02:45:14 -0400
Received: from static-ctb-210-9-247-213.webone.com.au ([210.9.247.213]:3341
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261959AbTD2GpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 02:45:13 -0400
Message-ID: <3EAE220D.4010602@cyberone.com.au>
Date: Tue, 29 Apr 2003 16:56:13 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: James@superbug.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Bug in linux kernel when playing DVDs.
References: <3EABB532.5000101@superbug.demon.co.uk> <200304290538.h3T5cLu16097@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200304290538.h3T5cLu16097@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>On 27 April 2003 13:47, James Courtier-Dutton wrote:
>
>>Hello,
>>
>>I have found a bug in the linux kernel when it plays DVDs. I use xine
>>(xine.sf.net) for playing DVDs.
>>At some point during the playing there is an error on the DVD. But
>>currently this error is not handled correctly by the linux kernel.
>>This puts the kernel into an uncertain state, causing the kernel to
>>take 100% CPU and fail all future read requests.
>>
>
[snip]

>
>Apart of making max retry # settable by the user, I don't see how
>this can be made better.
>
Having the kernel not use 100% CPU?

> Pity. This is common problem on CDs...
>  
>

