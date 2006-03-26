Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWCZKLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWCZKLK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 05:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWCZKLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 05:11:10 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:17862 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751212AbWCZKLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 05:11:09 -0500
Message-ID: <442668B8.8020905@tlinx.org>
Date: Sun, 26 Mar 2006 02:11:04 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Security downgrade? CONFIG_HOTPLUG required in 2.6.16?
References: <44237D87.70300@tlinx.org> <Pine.LNX.4.61.0603251954030.29793@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603251954030.29793@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> Do you use swsusp?
>
---
    Nep.  It's acting as a server :-).  It's also SMP, does
that work with SWSUSP?  Guess it has to now that laptops
have dual CPU's.  In fact that that makes me wonder: how well
do the SMP laptops do power management under linux?  Back
when I had a dual boot laptop, I seem to remember linux getting
about 25-33% more uptime. 

-l

