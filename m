Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVCYCPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVCYCPG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 21:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVCYCPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 21:15:06 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:7056 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261178AbVCYCPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 21:15:02 -0500
Subject: Re: nforce 4 audio has no s/pdif out
From: Lee Revell <rlrevell@joe-job.com>
To: Felix von Leitner <felix-linuxkernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050325012931.GA30885@codeblau.de>
References: <20050325012931.GA30885@codeblau.de>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 21:15:01 -0500
Message-Id: <1111716901.9303.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 02:29 +0100, Felix von Leitner wrote:
> My shiny new nforce 4 main board has sound that is detected OK by ALSA:
> 
>   intel8x0_measure_ac97_clock: measured 49970 usecs
>   intel8x0: clocking to 46877
>   ALSA device list:
>     #0: NVidia CK804 with ALC850 at 0xd2003000, irq 185
> 
> but I can't get my stereo to play.  It is connected via optical S/PDIF.
> Works fine under Windoze, so the hardware is ok.
> 
> Any idea what I could do?

This is OT for LKML.  ALSA bugs should be reported here:

https://bugtrack.alsa-project.org/alsa-bug/main_page.php

Lee

