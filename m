Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUBEOsZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 09:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUBEOsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 09:48:25 -0500
Received: from pop.gmx.de ([213.165.64.20]:46281 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265245AbUBEOsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 09:48:17 -0500
X-Authenticated: #4512188
Message-ID: <402257AE.6070902@gmx.de>
Date: Thu, 05 Feb 2004 15:48:14 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Andrew S. Johnson" <andy@asjohnson.com>
CC: Harald Arnesen <harald@skogtun.org>, linux-kernel@vger.kernel.org
Subject: Re: Oops with USB scanner in 2.6.2
References: <200402042233.45790.andy@asjohnson.com> <871xp9lw12.fsf@basilikum.skogtun.org> <40222174.8020801@gmx.de> <200402050732.01636.andy@asjohnson.com>
In-Reply-To: <200402050732.01636.andy@asjohnson.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew S. Johnson wrote:
> On Thursday 05 February 2004 04:56 am, Prakash K. Cheemplavam wrote:
> 
>>Harald Arnesen wrote:
>>
>>>"Andrew S. Johnson" <andy@asjohnson.com> writes:
>>>
>>>
>>>
>>>>This didn't happen with 2.4.22.  The scanner works OK until I turn it off.
>>>>Then I get the oops.  rmmod scanner hangs, with and without the -f switch.
>>>
>>>
>>>I just want to confirm that the same thing happens here.
>>
>>You shouldn't use it anymore. Use libusb.
>>
>>Prakash
>>
> 
> Use what anymore?

Don't use the scanner module. Use libusb (and hotplug) to access the 
scanner.

Prakash
