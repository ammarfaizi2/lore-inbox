Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422764AbWJ3X7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422764AbWJ3X7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422768AbWJ3X7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:59:34 -0500
Received: from 8.ctyme.com ([69.50.231.8]:29073 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1422764AbWJ3X7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:59:33 -0500
Message-ID: <454691E4.6000807@perkel.com>
Date: Mon, 30 Oct 2006 15:59:32 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: usb device descriptor read/64, error -110
References: <45468ABC.1060100@perkel.com> <20061030235429.GO27968@stusta.de>
In-Reply-To: <20061030235429.GO27968@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Adrian Bunk wrote:
> On Mon, Oct 30, 2006 at 03:29:00PM -0800, Marc Perkel wrote:
>   
>> Running the latest FC6 kernel based on 2.6.18.1. What does this error mean?
>>
>> device descriptor read/64, error -110
>>
>> Is this a kernel bug? Thanks in advance?
>>     
>
> That's a timeout.
>
> Your bug report lacks any any information for further debugging your 
> problem.
>
> - When does it occur?
> - What is failing?
> - Please send the output of "dmesg -s 1000000".
>
> And please read and follow REPORTING-BUGS in the kernel sources before 
> sending your next bug report.
>
> cu
> Adrian
>
>   

Thanks for your help. The device is a module that lets me plug in 
various kinds og camera memory sticks.

usb 1-7: new full speed USB device using ohci_hcd and address 2
usb 1-7: device descriptor read/64, error -110
usb 1-7: device descriptor read/64, error -110
usb 1-7: new full speed USB device using ohci_hcd and address 3
usb 1-7: device descriptor read/64, error -110


