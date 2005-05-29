Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVE2TPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVE2TPg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 15:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVE2TPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 15:15:34 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:40084 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261409AbVE2TPR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 15:15:17 -0400
Message-ID: <429A14C3.20604@tiscali.de>
Date: Sun, 29 May 2005 21:15:15 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Thonke <iogl64nx@gmail.com>
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: CPUFREQ/speedstep on Intel 955X chipset based system
References: <429A07EF.6090905@gmail.com>
In-Reply-To: <429A07EF.6090905@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke wrote:
> Hello,
> 
> I recently bought an Asus P5WAD2 motherboard which uses the Intel 955x
> chipset.
> I noticed that CPUFREQ/speedsteps with the same kernel and same config from
> my system with Intel 925XE and Intel Pentium 640 does not work on the
> system with
> Intel 955X chipset (the processor is the same). In Windows it works
> perfectly on 925XE
> and 955X chipset. 
> 
> The kernels I used
> 
> 2.6.12-rc5 vanilla with git4 patch
> 2.6.12-rc5-mm1.
> 
> I attached the output of dmesg and `cat /proc/cpuinfo`
>
Please turn on cpufreq debugging (see Documentation/ for details) and post the output.
 
> Thanks in advance
> 
> Best regards
>     Michael
> [ ... ]

Matthias-Christian Ott
