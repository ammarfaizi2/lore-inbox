Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbUDXKDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUDXKDw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 06:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUDXKDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 06:03:52 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:44437 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S262073AbUDXKDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 06:03:50 -0400
Message-ID: <408A3B82.5020807@softhome.net>
Date: Sat, 24 Apr 2004 12:03:46 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla Thunderbird 0.5+ (Macintosh/20040414)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guennadi Liakhovetski <gl@dsa-ac.de>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [somewhat OT] binary modules agaaaain
References: <1MJlZ-4mT-47@gated-at.bofh.it>
In-Reply-To: <1MJlZ-4mT-47@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:
> Hello all
> 
> I came across an idea, how Linux could allow binary modules, still having
> reasonable control over them.
> 
> I am not advocating for binary modules, nor I am trying to make their life
> harder, this is just an idea how it could be done.
> 
> I'll try to make it short, details may be discussed later, if any interest
> arises.
> 
> A binary module is "considered good" if
> 

   I belive that you forgot to make "The Point."

   And "discussion" (good vs. bad isn't discussion, but flames) went in 
wrong direction.

   Be constructive. For example: Let's aks h/w producers making at least 
glue layer open source (bsd or something), so people eventually might 
help to maintain this glue layer.
   How it can help? - producer with time may move bigger parts of driver 
into open source domains.
   How it can gets screwed? - producer might just start liking when 
someone is doing his work for him. Some license a-la GPL to not let glue 
layer to slip into binary only domain back must be in place.

   This could be a good starting point for h/w producers and linux 
comunity as a whole.

   Saying Good/Bad is just B.S. - helps no-one.
   Building bridges between comunity and producers - might improve and 
deepen relationships. And that's what I hope for.

P.S. nVidia driver might be an example: IIRC nVidia engineers were 
saying that they have four 2/3rd party code parts inside driver, which 
they are not able to open source/GPL. But open source glue layer to 
connect this "tainted" 4 parts with Linux kernel might help everyone: 
nVidia, LK and even those four companies. At least I hope for this.
