Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVCYJh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVCYJh3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 04:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVCYJh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 04:37:29 -0500
Received: from smtp.uninet.ee ([194.204.0.4]:17930 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S261561AbVCYJhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 04:37:22 -0500
Message-ID: <4243DBF8.2050703@tuleriit.ee>
Date: Fri, 25 Mar 2005 11:38:00 +0200
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 1.0 (X11/20050215)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Intel MB + P4 HT: bios processors logo depends on what?
References: <4243D65A.2050007@tuleriit.ee>
In-Reply-To: <4243D65A.2050007@tuleriit.ee>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indrek Kruusa wrote:

> A bit silly point maybe but it is somewhat interesting what makes BIOS 
> on Intel motherboard decide which processor's logo to display.
>
> Situation:
>
> a) Fedora Core 4 test1  + kernel-2.6.11-1.1177_FC4smp
> - going to reboot from fedora the bios shows always processors logo 
> with HT marks
>
> b) Mandrake 10.2 rc1 + kernel-2.6.11-5mdksmp
> - after reboot there is processor logo without HT marks
>
> c) Mandrake + kernel-2.6.12-rc1-mm1 (compiled with SMP+SMT)
> - same as b)
>
>
> There is nothing wrong with those kernels but it is interesting why 
> Fedora's kernel (acpi daemon?) is somewhat special here.



There was missing d) Fedora + kernel-2.6.12-rc1-mm1  :) And bios shows 
that I have hyperthreading processor.

It is difference between distros not kernels.


Indrek

