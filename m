Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVK2Eks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVK2Eks (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 23:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVK2Eks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 23:40:48 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:12152 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750730AbVK2Eks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 23:40:48 -0500
Date: Mon, 28 Nov 2005 23:40:46 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: cx88 totally fried in 2.6.15-rcX -was- Re: HD3000 - no NTSC via
 tuner
In-reply-to: <438BCE5F.7070108@m1k.net>
To: linux-kernel@vger.kernel.org
Cc: Michael Krufky <mkrufky@m1k.net>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Don Koch <aardvark@krl.com>, Perry Gilfillan <perrye@linuxmail.org>
Message-id: <200511282340.46506.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
 <438BCCF9.1000606@m1k.net> <438BCE5F.7070108@m1k.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 November 2005 22:43, Michael Krufky wrote:
>Michael Krufky wrote:
>> Gene Heskett wrote:
>>> Like I said, complete instructions please so that we are on the same
>>> page.  I still have the rc2-git6 tree that didn't work, so as my
>>> script does a make clean, it should be easy enough to do with the
>>> right instructions.  Like what dir in the kernel tree am I supposed
>>> to be in when I issue the cvs checkout command etc.
>
>Oops.... I forgot to answer this question....
>
>It doesnt matter in what directory you are issuing the commands
> below... Although you certainly should NOT issue these within your
> kernel source, and you should be inside the newly-downloaded v4l-dvb
> tree after you "cd" into it.  I recommend either doing this in your
> ~home directory, or in /usr/src

I built it in /usr/src, seemed to be ok ANAICT.  It just didn't work. 
Bear in mind I have no ATSC signals out here in the West Virginia hills
yet, all ntsc.  So I can't as yet test the ATSC side.

[...]

>Michael

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

