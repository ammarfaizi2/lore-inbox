Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWFLHo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWFLHo4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 03:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWFLHo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 03:44:56 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:523 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S1750830AbWFLHo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 03:44:56 -0400
From: Meelis Roos <mroos@linux.ee>
To: rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: PS/2 vs IDE problem on Athlon64 X2
In-Reply-To: <200606102127.11400.rjw@sisk.pl>
User-Agent: tin/1.8.2-20060425 ("Shillay") (UNIX) (Linux/2.6.17-rc5-gba8f5bab-dirty (i686))
Message-Id: <20060612074437.0690014018@rhn.tartu-labor>
Date: Mon, 12 Jun 2006 10:44:36 +0300 (EEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RJW> I have a machnine with Athlon64 X2 and AsRock 939Dual-SATA2 mobo (based
RJW> on the ULI chipset) on which the PS/2 devices (keyboard and mouse) are in a
RJW> bad correlation with IDE, or at least with the LiteOn DVD burner attached to it.

I recently got the same mainboard and it works fine for me with CD
reading/writing (LG CDRW, no DVD drive). Just tried yesterday, wrote a
CD at speed 12 and then read it as fast as it could and I did not notice
anything wrong. I'm using PS/2 keyboard and mouse and a very recent git
kernel (2.6.17-rc6+...). Maybe the CD speed is not enough to trigger it.

Are you sure DMA was on?

-- 
Meelis Roos

