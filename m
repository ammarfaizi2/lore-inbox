Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbTD2RwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 13:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTD2RwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 13:52:21 -0400
Received: from watch.techsource.com ([209.208.48.130]:51643 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S262117AbTD2RwU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 13:52:20 -0400
Message-ID: <3EAEBF12.3090102@techsource.com>
Date: Tue, 29 Apr 2003 14:06:10 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ross Vandegrift <ross@willow.seitz.com>,
       Chris Adams <cmadams@hiwaay.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why DRM exists [was Re: Flame Linus to a crisp!]
References: <fa.ivrgub8.1ci079c@ifi.uio.no> <20030427183553.GA955879@hiwaay.net> <20030427185037.GA23581@work.bitmover.com> <20030427220717.GA24991@willow.seitz.com> <20030427223255.GH23068@work.bitmover.com> <1051481114.15485.33.camel@dhcp22.swansea.linux.org.uk> <20030427232835.GM23068@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Larry McVoy wrote:

>On Sun, Apr 27, 2003 at 11:05:15PM +0100, Alan Cox wrote:
>  
>
>>Your economic model is flawed because if something needs doing enough
>>someone will pay to do it. The moment the value exceeds the cost it
>>should happen. 
>>    
>>
>
>Explain to me how BK would have happened under your (non flawed) model.
>Before we gave it to you, you had no idea how to do it.  It cost
>millions to get it to the point that you could see that it was valuable
>by using it.
>
>If I had said "Hey, Red Hat, how about you give me $8M so I can go
>build you the perfect SCM tool" you would have laughed your ass off.
>As would any other company, the amount of money it takes to do something
>new is not a working amount for a single customer.
>
>Under your model, only incremental change will occur, no customer is
>ever going to fund the large amounts required for truly new work.
>  
>
Many open source projects start out as entirely new ideas, but 
admittedly, they then taken on an entirely evolutionary (rather than 
revolutionary) approach to improvement afterwards.  The theoretical 
advantage is that global revolutionary change can occur through fast 
enough evolution.  Is Linux 2.5.68 revolutionarily better than Linux 
1.2?  I'd say so, but it got there through evolutionary, incremental change.

Keep in mind that evolution itself is driven by lots of 
mini-revolutions.  So when Ingo developed his O(1) scheduler, he 
completely replaced the existing one.  Sure he borrowed ideas, but that 
always happens.  The point is that the old one was ripped out and a new 
one was inserted.  An incremental change for Linux was caused by a 
revolutionary change to the process scheduler.

The idea of an O(1) scheduler may not be revolutionary in the grand 
scheme of all of computer science.  But that doesn't make it any less 
important to us or any less useful to the world.

Sometimes, the evolution just doesn't happen fast enough.  GNOME and KDE 
will both get there... eventually.  But they're not fast enough to make 
Linux viable yet on the desktop.  I can't begin to tell you how much 
effort it's taken for me to get Blue Curve and other GNOME-oriented or 
Red Hat-oriented (I know the difference) stuff with RH9 to behave the 
way I want it to.  Actually, it still doesn't.  



