Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266557AbUGPSCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266557AbUGPSCb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 14:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUGPSCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 14:02:30 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:28599 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S266557AbUGPSC3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 14:02:29 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: momentary sensors failure in gkrellm2
Date: Fri, 16 Jul 2004 14:02:27 -0400
User-Agent: KMail/1.6
References: <RmzLkwpu.1089988031.9917620.khali@gcu.info>
In-Reply-To: <RmzLkwpu.1089988031.9917620.khali@gcu.info>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407161402.27643.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [141.153.91.175] at Fri, 16 Jul 2004 13:02:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 July 2004 10:27, Jean Delvare wrote:
>Hi Gene,
[...]
>
> I've no idea which of the patches involving the i2c stuff wasn't
>> right for my chipset (via686 & winbond 697hf IIRC), but something
>> broke it just for 2.6.8-rc1.
>
>That's odd since there isn't much difference, if any, between the
> i2c subsystems of all three kernel versions.
>
>You could try 2.6.8-rc1-bk4 (or any later bk) which has had a
> significant i2c subsystem update.
>
>If you are able to reproduce the problem (presumably with your
> 2.6.8-rc1 kernel), hints about where the problem lies would help.
> Can you see the sysfs files for your monitoring chip under
> /sys/bus/i2c/devices? Are there any relevant error messages in the
> logs? I cannot help much from just "it didn't work", as you must
> realize.

In trying to reproduce it again today, I wasn't able to do so.  This 
mobo has developed a mild case of memory alzheimers, and is on its 
way to the bin as noted in my private message to Jean.

Please excuse the noise, list, but I did reproduce it twice 2 days ago 
before I posted that message.

[...]

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
