Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUECO4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUECO4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 10:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbUECO4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 10:56:53 -0400
Received: from [81.219.144.6] ([81.219.144.6]:63748 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S263725AbUECO4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 10:56:48 -0400
Message-ID: <40965DAA.4040504@pointblue.com.pl>
Date: Mon, 03 May 2004 15:56:42 +0100
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Hamie <hamish@travellingkiwi.com>, linux-kernel@vger.kernel.org
Subject: Re: uspend to Disk - Kernel 2.6.4 vs. r50p
References: <20040429064115.9A8E814D@damned.travellingkiwi.com> <20040503123150.GA1188@openzaurus.ucw.cz>
In-Reply-To: <20040503123150.GA1188@openzaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>echo -n disk > /proc/power/state
>>    
>>
>
>Use echo 4 > /proc/acpi/sleep, and vanilla kernels.
>
>			
>
What If it happends that I have T22 Thinkpad, and it doesn't work with 
ACPI in 2.6 (causes problems with network cards for some reason, long 
and not yet fixed bug in ACPI), and I don't have /proc/acpi. How can I 
use swsusp than ?

--
GJ

