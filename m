Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVLDP1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVLDP1w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVLDP1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:27:52 -0500
Received: from www.stv.ee ([212.7.5.251]:26380 "EHLO www.stv.ee")
	by vger.kernel.org with ESMTP id S932252AbVLDP1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 10:27:51 -0500
Message-ID: <43930AAB.7060903@tuleriit.ee>
Date: Sun, 04 Dec 2005 17:26:35 +0200
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>	 <4392E79B.7080903@tuleriit.ee> <1133701520.5188.34.camel@laptopd505.fenrus.org>
In-Reply-To: <1133701520.5188.34.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>nt model (or at least they have no resources to 
>>do testing [Torvalds])
>>c) end-users (or those who are not kernel maintainers) are directed 
>>permanently to distros kernels and "stay away from kernel.org you 
>>wanna-bees!
>>    
>>
>
>this is not what is being said. What is being said is that if you can't
>deal with occasional breakage, you're better off using vendor kernels.
>But.. if you can't deal with occasional breakage, you wouldn't test test
>kernels EITHER. If you can deal with an occasional breakage, I hope you
>and everyone else who can, will run and test kernel.org kernels,
>especially the -rc ones. 
>
>Most of the "instability" people complain about with the new 2.6 model
>is caused by people not testing the -rc kernels before they are
>released, so that they end up being released with regressions.
>

I think I have seen special live-cd distribution for KDE beta testers. 
Kernel is not a KDE but such a very broken distribution with -rc kernel 
could be more easily maintained than "udev forever!". Live-cd (or 
live-usb) wouldn't be too flexible - you can't say there "can you give a 
whirl to this patch, please" but I bet you will have more testers.

thanks,
Indrek

