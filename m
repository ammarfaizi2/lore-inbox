Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUIVOYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUIVOYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 10:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUIVOX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 10:23:59 -0400
Received: from mail.dif.dk ([193.138.115.101]:28054 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265900AbUIVOVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 10:21:22 -0400
Date: Wed, 22 Sep 2004 16:19:06 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /sys: Network device status: link; Hard disks?
In-Reply-To: <20040922141630.GE694@schottelius.org>
Message-ID: <Pine.LNX.4.61.0409221616561.14486@jjulnx.backbone.dif.dk>
References: <20040922141630.GE694@schottelius.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004, Nico Schottelius wrote:

> Date: Wed, 22 Sep 2004 16:16:30 +0200
> From: Nico Schottelius <nico-kernel@schottelius.org>
> To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: /sys: Network device status: link; Hard disks?
> 
> Hello everybody!
> Will /sys provide details about link status of network cards
> and can I also find out what devices are harddisks?
> Like having /sys/block/hda/type, which contains "cd-rom" or
> "harddisk" or similar. 
> Or having something like /sys/class/net/eth0/link with 0/1 setting?
> I know some or all information can be retrieved somehow differnt
> (like using /proc), but shouldn't those be found in /sys?
> Just some question on how we can use /sys useful.
> Greetings,
> Nico
> PS: Please CC, I am not subscribed.
> 

Hmm, sounds nice to me. I don't know if something like 
/sys/class/net/eth0/link as you describe it would be accepted, but I've 
been wanting to play with sysfs for a while and this sounds like a nice 
and resonably simple little project, I will take a shot at trying to 
implement that.


--
Jesper Juhl


