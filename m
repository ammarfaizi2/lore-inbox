Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292886AbSCEMyw>; Tue, 5 Mar 2002 07:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293064AbSCEMym>; Tue, 5 Mar 2002 07:54:42 -0500
Received: from [195.63.194.11] ([195.63.194.11]:4365 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S292886AbSCEMy0>;
	Tue, 5 Mar 2002 07:54:26 -0500
Message-ID: <3C84BFA6.2000800@evision-ventures.com>
Date: Tue, 05 Mar 2002 13:52:54 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <Pine.LNX.4.44.0203051307080.12437-100000@netfinity.realnet.co.sz> <5.1.0.14.2.20020305122312.026b9180@pop.cus.cam.ac.uk> <5.1.0.14.2.20020305124520.026b8a40@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It can't be older then 2.5.4 becouse before it just wasn't there.
> 
> 
> Old is a few days-a week on my time scale but the post i am referring to 
> is going at least a month or so back. And of course it can be older, you 
> seem to be forgetting that Andre's IDE patches have been around for a 
> _long_ time now for 2.4.x...

But is a short time ago that IDE problems appeared in 2.4.18...
Please just have a look at the actual code in ide-taskfile.c
and ask yourself whatever it is *really* stable and usable.
Using an editor with syntax highlighting for code
parts commented out by #if 0 .. #endif will reveal most of
the trouble instantly.

