Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWC3VjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWC3VjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWC3VjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:39:08 -0500
Received: from www2.persson.tm.12.198.194.in-addr.arpa ([194.198.12.206]:18056
	"HELO mail.persson.tm") by vger.kernel.org with SMTP
	id S1750974AbWC3VjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:39:07 -0500
Message-ID: <442C4FFC.2040109@persson.tm>
Date: Thu, 30 Mar 2006 23:39:08 +0200
From: Eric Persson <eric@persson.tm>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel config repository
References: <442A99CA.20303@persson.tm> <9a8748490603291505h19be30b0ue454437c9aa1faac@mail.gmail.com>
In-Reply-To: <9a8748490603291505h19be30b0ue454437c9aa1faac@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> For some users being able to grab a pre-made .config may be valuable,
> but for most people I doubt it will be very useful. Peoples hardware
> differ a lot, so a "best" config is always going to be one that you
> tweak personally to match your system. If you don't want to do that
> you are probably just going to use a generic distro kernel anyway (or
> you could use the .config of the distro kernel with make oldconfig
> when building a new kernel).
> 
> Maybe it's a good idea, dunno, but I don't really think so.

I understand your point, and you might as well be right.

I have experienced a very tough testing phase to make myself believe and 
thrust a new kernel config, before I put it to live use. I only use HP 
machines, most of them the same model and the difference in hardware are 
usually just disks, memory and speed of cpu, which affects the config 
inself very minmial, otherwise theyre all the same.
And to hook up and see other HP(replace with any brand/model) users and 
see what configs they use, so all can benefit from config testing, would 
be a great idea, thats what I think at least.

People compiling custom kernels for whatever piece of hardware they can 
find will most likely not benefit, but the overall "community wisdom" 
that this might generate would perhaps everyone benefit from.

Today, I find it hard find information about all the different configs, 
more than whats in the help function in make menuconfig, but thats me. 
And I think its a waste if good kernel development get ignored since 
people dont know what config options to turn on. ;)

Well, I hope I might inspired or given some clarity on the topic, any 
new input from this?

Best regards,
	Eric

