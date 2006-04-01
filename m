Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWDAASX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWDAASX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 19:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWDAASX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 19:18:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56335 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751294AbWDAASW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 19:18:22 -0500
Date: Sat, 1 Apr 2006 02:18:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Eric Persson <eric@persson.tm>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel config repository
Message-ID: <20060401001821.GB28310@stusta.de>
References: <442A99CA.20303@persson.tm> <9a8748490603291505h19be30b0ue454437c9aa1faac@mail.gmail.com> <442C4FFC.2040109@persson.tm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442C4FFC.2040109@persson.tm>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 11:39:08PM +0200, Eric Persson wrote:
>...
> I have experienced a very tough testing phase to make myself believe and 
> thrust a new kernel config, before I put it to live use. I only use HP 
> machines, most of them the same model and the difference in hardware are 
> usually just disks, memory and speed of cpu, which affects the config 
> inself very minmial, otherwise theyre all the same.
> And to hook up and see other HP(replace with any brand/model) users and 
> see what configs they use, so all can benefit from config testing, would 
> be a great idea, thats what I think at least.
> 
> People compiling custom kernels for whatever piece of hardware they can 
> find will most likely not benefit, but the overall "community wisdom" 
> that this might generate would perhaps everyone benefit from.

Even excluding the case that many computers are more or less unique 
combinations of half a dozen different components, everyone will use 
different settings for most hardware-independent things like e.g. file 
systems, preemption or networking options. Even if I had the same 
hardware as you have, my config settings would therefore most likely be 
completely different from yours.

> Today, I find it hard find information about all the different configs, 
> more than whats in the help function in make menuconfig, but thats me. 
> And I think its a waste if good kernel development get ignored since 
> people dont know what config options to turn on. ;)
> 
> Well, I hope I might inspired or given some clarity on the topic, any 
> new input from this?

The help texts for the config options should be enough for an 
experienced system administrator to set the right options.

If you know about help texts that could be improved, patches to improve 
them are welcome.

> Best regards,
> 	Eric

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

