Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269524AbUIZNA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269524AbUIZNA2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 09:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269527AbUIZNA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 09:00:28 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:37639 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S269524AbUIZNA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 09:00:27 -0400
Date: Sun, 26 Sep 2004 15:59:31 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Michael Thonke <tk-shockwave@web.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: AMD64 and NFORCE3 250GB very slow and USB hungs
In-Reply-To: <41569DE5.4080206@web.de>
Message-ID: <Pine.LNX.4.61.0409261555320.4933@musoma.fsmlabs.com>
References: <41569DE5.4080206@web.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Sep 2004, Michael Thonke wrote:

> I bought just a new AMD64 system with an NForce 3 based mainboard (MSI 
> K8N Neo2 Platinum). When I use the latest kernel from Andrew 
> (2.6.9-rc2-mm3) on boot it sometimes hung on boot and the reset state of 
> system is wrong so a have to power of the system until usb will work 
> again..at probing the usb devices (OHCI,EHCI). Also the system runs 
> really slow and some tasks starts and the system hungs. I also tried 
> staircase patches and voluntary-preemption but they also wont help.
> 
> Any suggestion or hints how to fix that behavior?

Send in your .config, lspci and dmesg to start off with.
