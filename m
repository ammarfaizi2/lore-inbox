Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266544AbVBEBs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266544AbVBEBs4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 20:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263208AbVBEBrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 20:47:42 -0500
Received: from web26505.mail.ukl.yahoo.com ([217.146.176.42]:42386 "HELO
	web26505.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266412AbVBEBrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 20:47:07 -0500
Message-ID: <20050205014706.79220.qmail@web26505.mail.ukl.yahoo.com>
Date: Sat, 5 Feb 2005 01:47:06 +0000 (GMT)
From: Neil Conway <nconway_kernel@yahoo.co.uk>
Subject: Re: 3TB disk hassles
To: Tomas Carnecky <tom@dbservice.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41C1CE60.5010606@dbservice.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy...  Apologies for the somewhat tardy reply; I've been
concentrating on getting the hardware to play nice recently and not
worrying so much about the software.

--- Tomas Carnecky <tom@dbservice.com> wrote:
> It was gentoo, and I even think I installed it right onto the GPT
> disk, 
> so no migration. But I'm not sure. You just have to look that your 
> kernel supports GPT. I don't know if the kernel from the gentoo
> livecd 
> supports GPT.
> 
> Also have a look here how to create GPT partitions:
> http://www.google.ch/search?q=site%3Ausefulthings.org.uk+gpt
> I think I did it like it's shown there, mklabel, mkpart and mount
> them.
> I don't think I migrated from MSDOS to GPT, because I don't even know
> how it'is possible if you have only one disk with the system on it.

Bizarre...  I will give this a try on a spare system as soon as I can. 
I thought sure I had read somewhere that typical x86 PC BIOSes just
didn't understand the GPT ptbl, and thus couldn't boot from a GPT'ed
disk.

thanks,
Neil

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
