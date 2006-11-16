Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755480AbWKPWik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480AbWKPWik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755478AbWKPWik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:38:40 -0500
Received: from jutrzenka.firma.o2.pl ([193.222.135.194]:25281 "EHLO
	jutrzenka.firma.o2.pl") by vger.kernel.org with ESMTP
	id S1755480AbWKPWij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:38:39 -0500
Message-ID: <455CE86B.6000609@firma.o2.pl>
Date: Thu, 16 Nov 2006 23:38:35 +0100
From: "Krzysztof Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.19-rc6: irq 48: nobody cared
References: <200611161629.45149.Krzysztof.Sierota@firma.o2.pl> <20061116210748.GI31879@stusta.de>
In-Reply-To: <20061116210748.GI31879@stusta.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk napisał(a):
> On Thu, Nov 16, 2006 at 04:29:44PM +0100, Krzysztof Sierota wrote:
>   
>> Hi,
>>
>> I'm getting the following in dmesg with 2.6.19-rc5 and 2.6.19-rc6 kernels quad 
>> opteron server running 64bit kernel, and the network card gets disabled. 
>> ...
>>     
>
> Please send the dmesg from the latest kernel that works for you.
>
>   
I've tested rc-[6,5,3,2] - all behave the same. 2.6.18.2 did not boot or 
switched the interfaces and I cannot access the machine. Will follow up, 
when I get back to work.

K

