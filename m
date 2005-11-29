Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbVK2PxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVK2PxO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 10:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbVK2PxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 10:53:14 -0500
Received: from kirby.webscope.com ([204.141.84.57]:30377 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1751388AbVK2PxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 10:53:14 -0500
Message-ID: <438C7942.5080509@m1k.net>
Date: Tue, 29 Nov 2005 10:52:34 -0500
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: cx88 totally fried in 2.6.15-rcX -was- Re: HD3000 - no NTSC via
 tuner
References: <200511282205.jASM5YUI018061@p-chan.krl.com>	<200511282340.46506.gene.heskett@verizon.net>	<438BDF72.1000704@m1k.net> <200511291011.20688.gene.heskett@verizon.net>
In-Reply-To: <200511291011.20688.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>>I should also add this is with 2.6.14.2 and todays v4l-dvb CVS.
>>    
>>
>And I should add that 2.6.14, any version without the cvs update, works
>perfectly in ntsc here. I have to atsc signals available.
>
Gene,

Would you mind trying to install the cvs modules on top of 2.6.14, using 
the instructions that I gave you last night?  This will confirm once and 
for all whether your problems are due to a v4l regression, or an 
upstream regression in 2.6.15.

Thanks,

-- 
Michael Krufky


