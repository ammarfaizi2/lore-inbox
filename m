Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWAJQRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWAJQRi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWAJQRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:17:38 -0500
Received: from gromit.trivadis.com ([193.73.126.130]:34108 "EHLO
	lttit.trivadis.com") by vger.kernel.org with ESMTP id S932229AbWAJQRh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:17:37 -0500
Message-ID: <43C3DE1F.9010807@cubic.ch>
Date: Tue, 10 Jan 2006 17:17:35 +0100
From: Tim Tassonis <timtas@cubic.ch>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: State of the Union: Wireless
References: <43C3AAE2.1090900@cubic.ch> <20060110125357.GH3911@stusta.de> <43C3B7C8.8000708@cubic.ch> <20060110141324.GJ3911@stusta.de>
In-Reply-To: <20060110141324.GJ3911@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I won't try to speak for Linus (perhaps he'd like to pipe up at some point), 
> but I think you're pulling that concept wayy out of context here.
> 
> Quoting ManagementStyle:
> 
>> Btw, another way to avoid a decision is to plaintively just whine "can't
>> we just do both?" and look pitiful.  Trust me, it works.  If it's not
>> clear which approach is better, they'll eventually figure it out.  The
>> answer may end up being that both teams get so frustrated by the
>> situation that they just give up.
> 
> Built into that paragraph, I think, is the assumption that you never 'do 
> both'. 

Well, we'd have to ask Linus about this one. I think it can be a good 
idea to do both, if you're not sure which one is better.

> 
> Also, referring to OSS/Alsa is just a great way to illustrate the problem with 
> your idea. There is, today, finally a "dominant" solution, but how long did 
> it take us to get there? By my count, a really long time! And along the way 
> we've had to deal with all kinds of applications that just support the first 
> and not the other. And it seems like far too many people still have just one 
> foot in the door - take for instance the README files shipped with commercial 
> game ports that advise using OSS at the first hint of trouble with Alsa.

A network device is way better abstracted by the operating system, so 
compatibility issues are of much smaller concern.

> Is this what we want for wireless?

We wouldn't get it, see above.


