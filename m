Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161262AbVKRV6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161262AbVKRV6N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161256AbVKRV6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:58:12 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14997 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161262AbVKRV6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:58:10 -0500
Subject: Re: intel8x0 sound of silence on dell system
From: Lee Revell <rlrevell@joe-job.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051118162300.GA22092@kvack.org>
References: <20051118162300.GA22092@kvack.org>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 16:51:50 -0500
Message-Id: <1132350711.6874.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 11:23 -0500, Benjamin LaHaise wrote:
> Hello all,
> 
> On trying out head on my workstation, it seems that no sound comes out.  
> The module is getting loaded and the interrupts line for the 'Intel ICH5' 
> is increasing.  The RHEL 4 kernel is known to work on this machine.  The 
> only output from the driver is below.  Any ideas?
> 
> 		-ben
> 
> intel8x0_measure_ac97_clock: measured 51314 usecs
> intel8x0: clocking to 48000

What do you mean "head"?  Kernel version please.

ALSA bug reports should go to alsa-user@lists.sourceforge.net or
(ideally) in the ALSA bug tracker,
https://bugtrack.alsa-project.org/alsa-bug/main_page.php

Lee

