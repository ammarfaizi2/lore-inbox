Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVCDPMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVCDPMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 10:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbVCDPMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 10:12:17 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:59277 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262212AbVCDPMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 10:12:13 -0500
Message-ID: <42287AC9.2050100@drzeus.cx>
Date: Fri, 04 Mar 2005 16:12:09 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH][MMC] Secure Digital (SD) support
References: <422701A0.8030408@drzeus.cx> <1109948432.8058.57.camel@pegasus>
In-Reply-To: <1109948432.8058.57.camel@pegasus>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann wrote:

>Hi Pierre,
>
>  
>
>>Here are the patches for Secure Digital support that I've been sitting 
>>on for a while. I tried to get some feedback on inclusion of this 
>>previously but since I didn't get any I'll just submit the thing.
>>It was originally diffed against 2.6.10 but it applies to 2.6.11 just 
>>fine (only minor fuzz).
>>    
>>
>
>lately I got a request for the support of a Bluetooth SD card. These are
>using SDIO and I think at the moment only memory cards are handled. Do
>you have any plans for SDIO support?
>
>  
>

I would if I had some hardware to play with *hint* *hint* ;)
The SDIO spec is publically available on the SD card associations web 
page so it shouldn't be too difficult to get some basic support. But I 
can't do much as long as I don't have any hardware to test it with. I 
might also need specs for the card itself. I haven't looked too much at 
SDIO at the moment.

Rgds
Pierre

