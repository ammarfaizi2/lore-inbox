Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265594AbUBFXYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265596AbUBFXYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:24:09 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:43197 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP id S265594AbUBFXXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:23:49 -0500
Message-ID: <402421CD.1030605@nerdvest.com>
Date: Fri, 06 Feb 2004 17:22:53 -0600
From: Bryan Andersen <bryan@nerdvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FATAL: Kernel too old
References: <Pine.LNX.4.53.0402061550440.681@chaos> <20040206152943.B26348@discworld.dyndns.org> <Pine.LNX.4.53.0402061718030.917@chaos>
In-Reply-To: <Pine.LNX.4.53.0402061718030.917@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Fri, 6 Feb 2004, Charles Cazabon wrote:
> 
> 
>>Richard B. Johnson <root@chaos.analogic.com> wrote:
>>
>>>Script started on Fri Feb  6 15:44:32 2004
>>># rlogin -l johnson quark
>>>ATAL: kernel too old
>>># rlogin -l johnson quark
>>>ATAL: kernel too old
>>
>>I saw something similar at a customer's site, when someone rooted the box and
>>replaced the default login shell with a rootkitted/backdoored one in a newer
>>executable format not supported by the old kernel.
>>
>>
>>>I crashed it and it rebooted fine, little fsck activity, with
>>>nothing in any logs that shows there was any problem whatsoever.
>>
>>Did the problem go away with a reboot?
> 
> Sure. And if you can 'root' that machine, you are really
> good! It isn't even visible to most of the company internally!

You never know what your fellow employees will do...  Where there is a 
will there is a way.

If you don't think it got rooted, what did you or other employees do 
recently on that machine that would cause software to be changed?  Did 
anybody do any upgrades?  Unless you can confirm an alternate 
explanation then I'd assume it was rooted.  If the machine was upgraded 
by downloading from the net, was the site you downloaded from secure? 
Just because a machine is behind many fire walls doesn't mean that it 
can't be rooted.

- Bryan


