Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266104AbTLIUcU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266103AbTLIURx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:17:53 -0500
Received: from cantva.canterbury.ac.nz ([132.181.2.27]:13841 "EHLO
	cantva.canterbury.ac.nz") by vger.kernel.org with ESMTP
	id S266116AbTLIUQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:16:46 -0500
Date: Wed, 10 Dec 2003 09:16:49 +1300
From: Oliver Hunt <ojh16@student.canterbury.ac.nz>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
In-reply-to: <yw1x4qwai8yx.fsf@kth.se>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Message-id: <3FD62DB1.7040205@student.canterbury.ac.nz>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.5b)
 Gecko/20030727 Thunderbird/0.1
References: <200312081536.26022.andrew@walrond.org>
 <20031208154256.GV19856@holomorphy.com> <3FD4CC7B.8050107@nishanet.com>
 <20031208233755.GC31370@kroah.com>
 <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
 <3FD577E7.9040809@nishanet.com>
 <pan.2003.12.09.09.46.27.327988@dungeon.inka.de> <yw1x4qwai8yx.fsf@kth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

> Andreas Jellinghaus <aj@dungeon.inka.de> writes:
> 
> 
>>maybe add this to the faq?
>>
>>Q: devfs did load drivers when someone tried to open() a non existing
>>device. will sysfs/hotplug/udev do this?
>>
>>A: there is no need to.
> 
> 
> I never like it when the answer is "you don't want to do this".  It
> makes me think of a certain Redmond based company.
> 
> 
>>hotplug/sysfs/udev will create devices for all hardware supported by
>>the kernel and the available modules. it will do that during boot
>>up, and whenever new hardware is added. so you can expect all
>>devices be already present, no need for a devfs like mechanism.
> 
> 
No... that's MacOS.. it does everything you want it to do... if you 
think otherwise, you're *wrong*, although this isn't as applicable in 
MacOS X...

--Oliver

PS not meant to offend MacOS users...

