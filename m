Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUGXPPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUGXPPX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 11:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268668AbUGXPPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 11:15:23 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:41673 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S264113AbUGXPPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 11:15:19 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: [FC1], 2.6.8-rc2 kernel, new motherboard problems
Date: Sat, 24 Jul 2004 11:15:17 -0400
User-Agent: KMail/1.6
References: <Pine.LNX.4.44.0407211334260.3000-100000@mail.birdvet.org> <200407240520.31906.gene.heskett@verizon.net> <4102530C.8060604@gmx.net>
In-Reply-To: <4102530C.8060604@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407241115.17614.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [141.153.89.27] at Sat, 24 Jul 2004 10:15:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 July 2004 08:16, Carl-Daniel Hailfinger wrote:
>Gene Heskett schrieb:
>> On Saturday 24 July 2004 02:06, Lee Revell wrote:
[...]
>>>>>>I believe you'll need forcedeth.c for this one. It's called
>>>>>>"Reverse Engineered nForce Ethernet support", under Device
>>>>>>Driver -> Networking -> Ethernet 10/100 Mbit.
>
>Right. And it should work perfectly with that driver. However, I
> recommend to use at least 2.6.8-rc2 because it has some bugfixes
> you may need.

Thats the kernel version I'm running already :)
[...]
>>>>>Maybe some bad press would set them straight.
>>>>>
>>>>>Lee
[...]
>> I'm under the impression the forcedeth writers did have access to
>> this data.  Is this incorrect? The question is directed at the
>> forcedeth authors.  If you are one, then please clarify.
>
>I am one of the authors. We did not have any information in the
> first place, but now that our reverse engineered driver works well,
> NVidia contributed bugfixes and gigabit support to our driver.

Which would be nice I guess, if the rest of my system wasn't limited 
to 100mb/sec.  In my case here at home, thats plenty fast enough.

In any event thanks for the info.  My biggest squawk is that so far, 
I've had to assign it the same MAC address as the old D-Link card 
wore in order to make the firewall pass me.  arp problems I think.  
Other than that, its working great.

>Regards,
>Carl-Daniel

-- 
Cheers Carl-Daniel, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
