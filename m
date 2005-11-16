Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVKPOWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVKPOWk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbVKPOWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:22:40 -0500
Received: from mail.tmr.com ([64.65.253.246]:15846 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1750771AbVKPOWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:22:39 -0500
Message-ID: <437B42EB.4020506@tmr.com>
Date: Wed, 16 Nov 2005 09:32:11 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: zilvinas@gemtek.lt
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>	 <4378980C.7060901@ens-lyon.fr> <20051114143248.GA3859@gemtek.lt>	 <43790F00.2020401@tmr.com> <1132045456.6823.1.camel@swoop.gemtek.lt>
In-Reply-To: <1132045456.6823.1.camel@swoop.gemtek.lt>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Žilvinas Valinskas wrote:

>On Mon, 2005-11-14 at 17:26 -0500, Bill Davidsen wrote:
>  
>
>>You are running the correct firmware? I don't have my system handy, but 
>>the Intel page says 2.4 firmware with the driver.
>>    
>>
>
>$ ls  /lib/firmware/ipw-2.4-*
>/lib/firmware/ipw-2.4-boot.fw       /lib/firmware/ipw-2.4-ibss_ucode.fw
>/lib/firmware/ipw-2.4-bss.fw        /lib/firmware/ipw-2.4-sniffer.fw
>/lib/firmware/ipw-2.4-bss_ucode.fw  /lib/firmware/ipw-2.4-sniffer_ucode.fw
>/lib/firmware/ipw-2.4-ibss.fw
>
>
>
>  
>
One possible cause eliminated.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

