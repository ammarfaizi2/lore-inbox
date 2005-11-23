Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVKWU2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVKWU2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVKWU1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:27:55 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:16560 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S932356AbVKWU1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:27:49 -0500
Message-ID: <4384D07A.7030406@lanl.gov>
Date: Wed, 23 Nov 2005 13:26:34 -0700
From: Ronald G Minnich <rminnich@lanl.gov>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: yhlu <yhlu.kernel@gmail.com>, discuss@x86-64.org, linuxbios@openbios.org,
       linux-kernel@vger.kernel.org
Subject: Re: [LinuxBIOS] x86_64: apic id lift patch
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com> <20051121220605.GD20775@brahms.suse.de> <43849FA5.4020201@lanl.gov> <20051123173504.GK20775@brahms.suse.de>
In-Reply-To: <20051123173504.GK20775@brahms.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>At the same time, we seem to be treading in territory where the fuctory 
>>BIOSes have not yet been. We're in the weird position, at times, of 
>>finding things out before the proprietary BIOSes get there.
> 
> 
> You're saying that Arima machine only runs with LinuxBIOS so far?

The Cray XD-1, opteron-based machine, is linuxbios only. Another 
machine, DRC, can only use linuxbios. Island/Aruma was mentioned. These 
are the three I know of, there may well be others.

DRC used linuxbios because fuctory bios could not configure HT correctly 
in their application.

(well, I know of one other, but can't tell you about it).

ron
