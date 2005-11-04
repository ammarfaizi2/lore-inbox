Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbVKDT3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbVKDT3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 14:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVKDT3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 14:29:07 -0500
Received: from 10.ctyme.com ([69.50.231.10]:28848 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S1750844AbVKDT3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 14:29:06 -0500
Message-ID: <436BB681.1000103@perkel.com>
Date: Fri, 04 Nov 2005 11:29:05 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Gigabyte GA-K8N51GMF-9 Motherboard
References: <436ACD9D.2070501@perkel.com> <436BB4AD.9020202@mnsu.edu>
In-Reply-To: <436BB4AD.9020202@mnsu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeffrey Hundstad wrote:

> It's not the same MB, but perhaps similar, I have a ga-k8ns. The 
> Ethernet port works fine.  However; things did seem a little funky 
> until I added ACPI support.  It seem that interrupts weren't being 
> delivered as they should have been.
>
> Symptom: sound would stutter REALLY bad, and the Ethernet module would 
> load but never work.
>

Thanks for your help. I figured out what the problem was. I was 
installing FC4 and it uses 2.6.11 kernel and when I installed a later 
kernel it works. Aparently the 2.6.12 kernel included the drivers that 
work with this motherboard.

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

