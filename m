Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVCYBbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVCYBbz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVCYBaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:30:21 -0500
Received: from ipx10069.ipxserver.de ([80.190.240.67]:36842 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S261402AbVCYB3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:29:32 -0500
Date: Fri, 25 Mar 2005 02:29:31 +0100
From: Felix von Leitner <felix-linuxkernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: nforce 4 audio has no s/pdif out
Message-ID: <20050325012931.GA30885@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My shiny new nforce 4 main board has sound that is detected OK by ALSA:

  intel8x0_measure_ac97_clock: measured 49970 usecs
  intel8x0: clocking to 46877
  ALSA device list:
    #0: NVidia CK804 with ALC850 at 0xd2003000, irq 185

but I can't get my stereo to play.  It is connected via optical S/PDIF.
Works fine under Windoze, so the hardware is ok.

Any idea what I could do?

Felix
