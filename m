Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWBCOJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWBCOJr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 09:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWBCOJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 09:09:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:29347 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750826AbWBCOJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 09:09:46 -0500
Date: Fri, 3 Feb 2006 15:09:36 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: discriminate single bit error hardware failure from slab
 corruption.
In-Reply-To: <20060202192414.GA22074@redhat.com>
Message-ID: <Pine.LNX.4.61.0602031509190.7991@yvahk01.tjqt.qr>
References: <20060202192414.GA22074@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>000: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>Single bit error detected. Possibly bad RAM. Please run memtest86.
>
>--- linux-2.6.15/mm/slab.c~	2006-01-09 13:25:17.000000000 -0500
>+++ linux-2.6.15/mm/slab.c	2006-01-09 13:26:01.000000000 -0500

So, and what do non-x86 users use?


Jan Engelhardt
-- 
