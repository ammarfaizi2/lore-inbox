Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265714AbUATUR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 15:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbUATUR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 15:17:59 -0500
Received: from kiy.wanderer.org ([195.218.87.138]:64264 "EHLO kiy.wanderer.org")
	by vger.kernel.org with ESMTP id S265714AbUATUR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 15:17:58 -0500
Message-ID: <400D8CF3.6080504@tv.debian.net>
Date: Tue, 20 Jan 2004 22:17:55 +0200
From: Tommi Virtanen <tv@tv.debian.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bart Samwel <bart@samwel.tk>
Cc: Lorenzo Hernandez Garcia-Hierro <lorenzohgh@nsrg-security.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Noise with  2.6.0 in a Dell Laptop ( Latitude c600 )
References: <1073488405.850.35.camel@zeus> <4003F998.4020104@tv.debian.net> <200401201336.54113.bart@samwel.tk>
In-Reply-To: <200401201336.54113.bart@samwel.tk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Samwel wrote:
>>>When the 2.6.0 inits in my laptop it becomes reaaallyyy noisy.
>>>Why ?
>>If it's the fans, it's the BIOS reading CPU temperature of 85 C,
>>which is not true. It seems a Fn-Z press resets this reading to
>>sane values. You can look at the temperature reading and fan
>>state with i8kutils.
>>
>>Atleast that's what a Dell Latitude C640 that I had did.
> Might it be that the hardware reports 85 F instead of 85 C maybe? That's about 
> (85-32)*0.55 = about 29 C, which may be more realistic when you're just 
> booting it up. :)

Only if it switches between C and F at runtime. Normal readings when 
loaded were 55-65, IIRC.
