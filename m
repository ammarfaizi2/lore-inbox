Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbVK3Tq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbVK3Tq5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 14:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbVK3Tq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 14:46:57 -0500
Received: from kirby.webscope.com ([204.141.84.57]:44735 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1751558AbVK3Tq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 14:46:56 -0500
Message-ID: <438E017C.2090901@m1k.net>
Date: Wed, 30 Nov 2005 14:46:04 -0500
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Damien Wyart <damien.wyart@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG in kernel checked out 24 hours ago
References: <20051130192050.GA13596@localhost.localdomain> <1133378746.2825.60.camel@laptopd505.fenrus.org>
In-Reply-To: <1133378746.2825.60.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Wed, 2005-11-30 at 20:20 +0100, Damien Wyart wrote:
>  
>
>>Hello,
>>
>>Please find the log from a BUG I encountered this evening while running
>>a kernel I had checkouted from git and compiled arond 6pm UTC yesterday.
>>The computer froze and I could reboot it with Sysrq.
>>
>>Any comments welcome, notably about if this has been corrected since or
>>not (I am not insider enough to be sure). I am currently compileing
>>a freshly checkouted kernel to see if it runs better.
>>    
>>
>
>you should try without the nvidia module....
>
It looks like this issue applies to your situation:

[LKML] Merely a warning to my fellow Nvidia travellers running 2.6.15-rc3
http://lkml.org/lkml/2005/11/30/157/index.html

Cheers,

Michael Krufky


