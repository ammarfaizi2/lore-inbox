Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVG1Oc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVG1Oc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVG1OVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:21:33 -0400
Received: from reserv5.univ-lille1.fr ([193.49.225.19]:11183 "EHLO
	reserv5.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S261509AbVG1OVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:21:14 -0400
Message-ID: <42E8E9D1.4070705@lifl.fr>
Date: Thu, 28 Jul 2005 16:21:05 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.6-1mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gabri <metadistros@yahoo.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: Help Me Please
References: <001701c5937b$ca708780$0801a8c0@SEBAS>
In-Reply-To: <001701c5937b$ca708780$0801a8c0@SEBAS>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@lifl.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

07/28/2005 03:53 PM, gabri wrote/a écrit:
> I have a laptop. Is amd mobile SEMPRON but when I
> ejecute cpufreq say this:
> 
> analyzing CPU 0:
>   no or unknown cpufreq driver is active on this CPU
> 
> I remcompiled a lot of kernel" 2.6.12.3 2.6.8 etc"
> witch support for cpu scaling but when i am triying
> load a module powernow-k8 say this error:
> powernow-k8: Found 1 AMD Athlon 64 / Opteron
> processors (version 1.00.09b)
> powernow-k8: BIOS error: maxvid exceeded with pstate
> 0
> 
> and with powernow-k7: powernow: This module only
> works
> with AMD K7 CPUs
> mi claptop isn't overcloked and i don't know how fix
> the problem.

Hello,

According to the message, it's clear that powernow-k8 fits your CPU. I 
don't know the meaning of the error message, though.

First, have you upgraded your BIOS to the latest available version?

Also, you might have better feedback if you contact the cpufreq 
mailing-list: cpufreq@lists.linux.org.uk

Eric
