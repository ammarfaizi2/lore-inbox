Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270761AbRHNTyx>; Tue, 14 Aug 2001 15:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270776AbRHNTyo>; Tue, 14 Aug 2001 15:54:44 -0400
Received: from james.kalifornia.com ([208.179.59.2]:50743 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S270774AbRHNTyc>; Tue, 14 Aug 2001 15:54:32 -0400
Message-ID: <3B7981F9.3000708@blue-labs.org>
Date: Tue, 14 Aug 2001 15:54:33 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Per Jessen <per@computer.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Are we going too fast?
In-Reply-To: <3B776EA5000338FD@mta3n.bluewin.ch> (added by postmaster@bluewin.ch)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Jessen wrote:

>>On Mon, 13 Aug 2001 14:11:32 +0100 (BST), Alan Cox wrote:
>>
>>If you want maximum stability you want to be running 2.2 or even 2.0. Newer
>>less tested code is always less table. 2.4 wont be as stable as 2.2 for a
>>year yet.
>>
>
>Couldn't have put that any better. On mission-critical systems, this is
>exactly what people do. Personally, my experience is from the big-iron
>world of S390 -  if you're a bleeding-edge organisation, you'll be out
>there applying the latest PTFs, you'll be running the latest OS/390 etc. 
>If you're conservative, you're at least 2, maybe 3 releases (in todays 
>OS390 this means about 18-24 months) behind. If you're ultra-conservative,
>you'll wait for the point where you can no longer avoid an upgrade.
>

Unfortunately, this methodology also introduces another important 
factor.  You are the most likely target for exploits and 
vulnerabilities.  As is ever so strongly evidenced by the great numbers 
of people being exploited because the version of software they have is 
outdated.

It's a gross measure of risks; where does the risk come from, how can it 
affect you, and what can you do about it.

Some of the most common questions asked on support areas is (take IIS 
for example) "My server is being exploited, how can I stop it?" and the 
most common answer to that is "Upgrade and install all necessary patches."

Save for the rare occasion of issue, I run a few different server farms 
and they all perform very well and are all rock solid stable.  I should 
also note that they are all 2.4 kernels.  For servers I seem to have 
really good success stories, for my workstation I tend to have issues 
which is fairly natural, my workstation has numerous accessory cards and 
features.

To be honest, save for either power outtage or kernel upgrade, I rarely 
have to deal with reboots.  I tend to keep my servers within a few 
releases of the current code.  Due to this policy I rarely have exploit 
and vulnerability issues.  One particular server (which has a VIA 
chipset...is it jinxed? :) has problems now and then but they get fixed.

David


