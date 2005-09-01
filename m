Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbVIAHND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVIAHND (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 03:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVIAHNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 03:13:01 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:54324 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932553AbVIAHNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 03:13:00 -0400
Message-ID: <4316A9C0.9090509@cisco.com>
Date: Thu, 01 Sep 2005 17:12:00 +1000
From: Lincoln Dale <ltd@cisco.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jmerkey <jmerkey@utah-nac.org>
CC: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] DSFS Network Forensic File System for Linux Patches
References: <E1EAd1J-0007Cw-00@calista.eckenfels.6bone.ka-ip.net> <431651BC.9020108@utah-nac.org> <43165CE3.9080704@utah-nac.org>
In-Reply-To: <43165CE3.9080704@utah-nac.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey wrote:

> It might be helpful for someone to look at these sections of code I 
> had to patch in 2.6.9.
> I discovered a case where the kernel scheduler will pass NULL for the 
> array argument
> when I started hitting the extreme upper range > 200MB/S combined disk 
> and lan
> throughput.  This was running with preemptible kernel and 
> hyperthreading enabled.

Jeff,

you are running a tainted kernel since you're loading proprietary modules.
you'd better go back to your vendor for support.
haha.


cheers,

lincoln.

>
