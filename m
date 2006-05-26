Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWEZI4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWEZI4G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 04:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWEZI4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 04:56:05 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:6302 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751199AbWEZIzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 04:55:49 -0400
Date: Fri, 26 May 2006 10:55:37 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17-rc5, patches patches
In-Reply-To: <Pine.LNX.4.64.0605251211250.5623@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0605261052150.16828@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0605241902520.5623@g5.osdl.org>
 <Pine.LNX.4.61.0605251820080.6951@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605251211250.5623@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >http://lkml.org/lkml/2005/7/7/255
>> http://lkml.org/lkml/2005/2/26/92
>> 
>Were they pushed and cc'd to the maintainers?
>
I suppose not since you ask.

>If you don't know your partitions, I don't think just listing them is 
>going to help much).
>
Who knows... forgetting to include your IDE/SCSI driver in bzImage 
(assuming you run without initrd/initramfs) is like forgetting to include 
your filesystem. After all, what is more likely for kernel-compiling 
people? Missing fs or block driver?



Jan Engelhardt
-- 
