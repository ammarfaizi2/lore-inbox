Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTDVUmV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbTDVUmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:42:21 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:39925 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S263861AbTDVUk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:40:58 -0400
Message-ID: <3EA5ABAE.1020009@wmich.edu>
Date: Tue, 22 Apr 2003 16:53:02 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030318
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.68 state of matroxfb 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm just wondering what the state of the matroxfb driver is and why it's 
an option in the kernel when it's completely uncompilable and has been 
for many months. I know it requires patches to work and i was under the 
assumption that these patches were at linux-fbdev.org but that site has 
been down for the past few days i've tried to access it and with no 
documentation updates about the new matroxfb driver since 2.4, I've been 
unable to verify if this is the only place to find the matroxfb patches. 
  So what i'm getting at is why is there a matroxfb option in the 
current kernel when the driver isn't there and what the future/current 
situation is with the framebuffer driver. I'd like to get the most 
hardware support for video output as possible and it seems like the mga 
(mplayer)  driver built on top of the fb driver is the way to do that 
and since my Nvidia card is twice as fast at X operations as my G450, I 
was assuming that the 2.5 fb code was just much better than the 2.4 fb 
code since I use the nvidia fb driver in 2.5 with X using the nvidia 
driver (Xfree's ). I've never been able to test that theory though 
because i've never been able to build 2.5's matroxfb.

