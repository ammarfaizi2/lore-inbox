Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVJWWTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVJWWTd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 18:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVJWWTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 18:19:33 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:45802
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750742AbVJWWTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 18:19:32 -0400
Message-ID: <435C0C5E.5000709@linuxwireless.org>
Date: Sun, 23 Oct 2005 16:19:10 -0600
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Rob Landley <rob@landley.net>, kronos@kronoz.cjb.net,
       Keenan Pepper <keenanpepper@gmail.com>, linux-kernel@vger.kernel.org,
       jketreno@linux.intel.com
Subject: Re: ipw2200 only works as a module?
References: <20050926171220.GA9341@dreamland.darkstar.lan> <200510191635.13253.rob@landley.net> <200510222350.57605.s0348365@sms.ed.ac.uk>
In-Reply-To: <200510222350.57605.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:

>On Wednesday 19 October 2005 22:35, Rob Landley wrote:
>  
>
>>On Monday 26 September 2005 12:12, Luca wrote:
>>    
>>
>>>Keenan Pepper <keenanpepper@gmail.com> ha scritto:
>>>      
>>>
>>>>With CONFIG_IPW2200=y I get:
>>>>
>>>>ipw2200: ipw-2.2-boot.fw load failed: Reason -2
>>>>ipw2200: Unable to load firmware: 0xFFFFFFFE
>>>>
>>>>but with CONFIG_IPW2200=m it works fine. If it doesn't work when built
>>>>into the kernel, why even give people the option?
>>>>        
>>>>
I have seen this before with users using FC or RH. They end up 
increasing the timeout of the hotplug event and then it all works. But 
then again, it only occurs for what I have seen with FC users. Dunno Why.

.Alejandro
