Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263086AbUB0SS1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUB0SS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:18:27 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:26021 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S263089AbUB0SRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:17:19 -0500
Message-ID: <403F898A.2000801@matchmail.com>
Date: Fri, 27 Feb 2004 10:16:42 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: Greg KH <greg@kroah.com>, "J.A. Magallon" <jamagallon@able.es>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       sensors@Stimpy.netroedge.com
Subject: Re: 2.6.3-mm4
References: <20040225185536.57b56716.akpm@osdl.org> <403E82D8.3030209@gmx.de> <20040225185536.57b56716.akpm@osdl.org> <20040227001115.GA2627@werewolf.able.es> <20040227004602.GB15075@kroah.com> <1077870909.403f013dd04b6@imp.gcu.info>
In-Reply-To: <1077870909.403f013dd04b6@imp.gcu.info>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> Quoting Greg KH <greg@kroah.com>:
> 
> 
>>Anyway, I think all you need to do is get the cvs tree of the
>>lmsensors package.  Sensors people, the needed changes are commited
>>into the tree, right?
> 
> 
> No. The changes are waiting in my local repository, ready to be applied.
> I didn't want to apply them because we were supposed to release
> lm_sensors 2.8.5 (for Linux 2.6.3 users) and the sysfs names change
> wouldn't belong there.
> 
> The libsensors patches are available on my personal server here:
> http://jdelvare.net1.nerim.net/sensors/
> Apply both patches in order and you'll get a 2.6.3-mm4-compliant
> library.
> 
> I will apply the libsensors changes to the CVS repository as soon as the
> kernel modules changes are accepted into Linus' tree. If we did not
> release a new version since there, I'll take a CVS snapshot right
> before so that Linux 2.6.3 users have a usable version available (but
> my preference strongly goes to releasing 2.8.5 instead).

You have to be kidding me.  Are you saying that with your patches to 
libsensors it won't support 2.6.3 style sensor sysfs names?

