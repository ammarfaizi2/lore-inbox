Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbUEAWyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUEAWyB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 18:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUEAWyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 18:54:00 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:22975 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S262468AbUEAWx6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 18:53:58 -0400
In-Reply-To: <20040501182245.3acce85d.seanlkml@rogers.com>
References: <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com> <Pine.LNX.4.44.0405011529541.30657-100000@xanadu.home> <20040501205336.GA27607@valve.mbsi.ca> <20040501173450.006bae55.seanlkml@rogers.com> <3F6634E3-9BB9-11D8-B83D-000A95BCAC26@linuxant.com> <20040501182245.3acce85d.seanlkml@rogers.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6C85D188-9BC2-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: rusty@rustcorp.com.au, riel@redhat.com,
       tconnors+linuxkernel1083378452@astro.swin.edu.au,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, torvalds@osdl.org,
       nico@cam.org
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] clarify message and give support contact for non-GPL modules
Date: Sat, 1 May 2004 18:53:55 -0400
To: Sean Estabrooks <seanlkml@rogers.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 1, 2004, at 6:22 PM, Sean Estabrooks wrote:

>
>> - The word "tainted" is confusing and needlessly scary for average
>> users.
>>
>
> Please stop your political agenda of subverting the open source nature 
> of
> Linux.   The average user SHOULD find it a scary to run modules
> that don't conform to her choice of  OPEN SOURCE OPERATING SYSTEM.
> If the average user wanted to run closed source code she would have 
> picked
> a closed source operating system right?  Lets not let closed source 
> code sneak
> in without putting up big red flags for the user.   Lets make sure 
> that the
> USER IS NOT CONFUSED about the nature of the module they're loading.

Everyone has an agenda.

Ours is to find reasonable compromise between corporate and community 
interests so that Linux users are able to use widespread hardware for 
which open-source drivers are otherwise not available or not adequate. 
There are several types of devices, like softmodems, for which there is 
currently no other alternative method. We believe that this is a 
legitimate business, and beneficial to the linux community. Our goal is 
not to harm open-source, to the contrary, help it spread by removing 
some of the obstacles. Likewise, we help vendors bring their technology 
to Linux. We encourage them to fully open-source it when possible and 
economically feasible (like in the case of Conexant's riptide driver or 
ethernet chipsets for which we have obtained and shared full source 
with the community). Otherwise, we try deliver mixed-binary/source 
drivers in the most convenient form for users.

Regards
Marc

