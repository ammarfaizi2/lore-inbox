Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbUKHR5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbUKHR5w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbUKHR5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:57:39 -0500
Received: from fire.osdl.org ([65.172.181.4]:34997 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261963AbUKHRyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 12:54:01 -0500
Message-ID: <418FAFF6.70400@osdl.org>
Date: Mon, 08 Nov 2004 09:42:14 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] fix address passing of unknown_bootoption
References: <200411072247.39841.mbuesch@freenet.de> <20041107164244.34ad8bfd.akpm@osdl.org> <418EC395.3070002@osdl.org> <200411080943.43734.mbuesch@freenet.de>
In-Reply-To: <200411080943.43734.mbuesch@freenet.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> Quoting "Randy.Dunlap" <rddunlap@osdl.org>:
> 
>>>hm, I don't know what happened there.  Maybe the value of pm_idle in
>>>cpu_idle() is garbage.  Or maybe not.
>>
>>Zwane and someone else had patches for that happening IIRC
>>a month or 2 back.
>>I can dig them out if wanted... Michael, want to try?
> 
> 
> 
> Yes, sure. Please.

OK, there are several patches flying around that may fix this.
or maybe not...

And I don't know what it already in -ckX -acN either, so they might
not apply cleanly.  (also checking -mm now....)

 From BlaisorBlade:
http://marc.theaimsgroup.com/?l=acpi4linux&m=109441393614805&w=2

 From Shaohua Li:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109470272821630&w=2

 From Zwane (update of above):
http://marc.theaimsgroup.com/?l=acpi4linux&m=109473286622679&w=2

-- 
~Randy
