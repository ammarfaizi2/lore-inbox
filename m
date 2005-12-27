Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVL0NXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVL0NXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 08:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVL0NXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 08:23:49 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:35850 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S932306AbVL0NXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 08:23:49 -0500
Message-ID: <43B1405D.2050202@superbug.co.uk>
Date: Tue, 27 Dec 2005 13:23:41 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051218)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Mark Knecht <markknecht@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ho ho ho.. Linux 2.6.15-rc7
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>	 <5bdc1c8b0512261002n6167a78ewfc45a6d3a5078ac0@mail.gmail.com> <1135620892.8293.60.camel@mindpipe>
In-Reply-To: <1135620892.8293.60.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Mon, 2005-12-26 at 10:02 -0800, Mark Knecht wrote:
> 
>>Hi Linus,
>>   I've visiting at my parents house and gave 2.6.15-rc7 a try on my
>>dad's machine. This machine is his normal desktop box which I
>>administer remotely, as well as a MythTV server. The new kernel built
>>and booted fine. I then built the NVidia stuff. However when I tried
>>to build the ivtv driver from portage it failed:
> 
> 
> There's nothing the kernel developers can do about regressions in out of
> tree modules - there is no stable kernel module API so the authors of
> that module will have to fix it.
> 
> Any idea why the IVTV module has not been submitted for mainline?
> 
> Lee
> 

No idea. I even asked the IVTV developers mailing list some time ago 
trying to get them to include it in mainline, but they did not want to 
for some odd reason I could not work out.

Maybe someone else can kick them a little harder. :-)

James

