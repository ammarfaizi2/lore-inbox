Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVKDTVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVKDTVr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 14:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVKDTVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 14:21:47 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:39052 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S1750752AbVKDTVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 14:21:46 -0500
Message-ID: <436BB4AD.9020202@mnsu.edu>
Date: Fri, 04 Nov 2005 13:21:17 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Gigabyte GA-K8N51GMF-9 Motherboard
References: <436ACD9D.2070501@perkel.com>
In-Reply-To: <436ACD9D.2070501@perkel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not the same MB, but perhaps similar, I have a ga-k8ns. The 
Ethernet port works fine.  However; things did seem a little funky until 
I added ACPI support.  It seem that interrupts weren't being delivered 
as they should have been.

Symptom: sound would stutter REALLY bad, and the Ethernet module would 
load but never work.

-- 
Jeffrey Hundstad

Marc Perkel wrote:

> ****
>
> I just got a Gigabyte **GA-K8N51GMF-9 motherboard with nVidia chipset 
> and Linux for some reason doesn't seem to be able to find the SATA 
> drives or the ethernet port. Just wondering if I'm wasting my time 
> with this board or if I'm missing something?
>
> **
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

