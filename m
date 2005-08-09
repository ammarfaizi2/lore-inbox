Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbVHIQK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbVHIQK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVHIQK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:10:29 -0400
Received: from mail0.scram.de ([195.226.127.110]:11019 "EHLO mail0.scram.de")
	by vger.kernel.org with ESMTP id S964849AbVHIQK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:10:28 -0400
Message-ID: <42F8D557.9040601@scram.de>
Date: Tue, 09 Aug 2005 18:09:59 +0200
From: Jochen Friedrich <jochen@scram.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Adrian Bunk <bunk@stusta.de>,
       Lee Revell <rlrevell@joe-job.com>, abonilla@linuxwireless.org,
       "'Andreas Steinmetz'" <ast@domdv.de>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Denis Vlasenko'" <vda@ilport.com.ua>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: Wireless support
References: <005501c59c4a$f6210800$a20cc60a@amer.sykes.com> <42F872E3.3050106@scram.de> <AC074A82-2B17-485A-9BFE-090CB4EE6E44@mac.com> <200508091624.17381.rjw@sisk.pl>
In-Reply-To: <200508091624.17381.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:

>On Tuesday, 9 of August 2005 15:52, Kyle Moffett wrote:
>  
>
>>On Aug 9, 2005, at 05:09:55, Jochen Friedrich wrote:
>>    
>>
>>>Third, both ndiswrapper and binary-only drivers only work on one  
>>>platform.
>>>
>>>E.g. broadcom has a binary-only driver for their WLAN card on  
>>>Linux, but
>>>only for mipsel (wrt54g).
>>>
>>>On Alpha or PowerPC, most WLAN equipment doesn't work under Linux,  
>>>at all.
>>>      
>>>
>>Definitely.  I want my Airport Extreme to work!  Many users of the  
>>BCM4301 chip can get it to work (kinda) with Linux via ndiswrapper,
>>but that means they are much less likely to participate in any kind of
>>reverse engineering effort,
>>    
>>
>
>Do you know of anyone actually doing it?
>
>Rafael
>
>  
>

See http://linux-bcom4301.sourceforge.net/

Jochen
