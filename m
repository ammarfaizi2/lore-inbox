Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265345AbUAYXYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbUAYXYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:24:25 -0500
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:42733 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265345AbUAYXYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:24:23 -0500
From: Christian Unger <chakkerz@optusnet.com.au>
Reply-To: chakkerz@optusnet.com.au
Organization: naiv.sourceforge.net
To: Kieran <kieran@ihateaol.co.uk>
Subject: Re: Nvidia drivers and 2.6.x kernel
Date: Mon, 26 Jan 2004 10:24:28 +1100
User-Agent: KMail/1.5.4
References: <200401221004.06645.chakkerz@optusnet.com.au> <200401230942.13888.chakkerz@optusnet.com.au> <401052C6.7040500@ihateaol.co.uk>
In-Reply-To: <401052C6.7040500@ihateaol.co.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401261024.28998.chakkerz@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kieran (et al)

Ok i tried the configuration you sent, and after working out that you have a 
different motherboard chipset which caused the kernel to hang here whenever i 
did anything that involved the hard disk (copy the drivers from my backup 
partition to my work partition for instance - to ensure that i was using 
"good copies") i even had signs of success.

Mere signs though. I continue being told it's an invalid format:
FATAL: Error inserting nvidia (/lib/modules/2.6.1/kernel/drivers/video/
nvidia.ko): Invalid module format

So ... i'm out of ideas ... i don't get why it ain't doing for me what it is 
doing for everyone else. I am wondering IF something screwed up when i 
upgraded Slackware 9.1 from 9.0 ... and in the interest of testing that 
theory might do a rm -f / later and start from scratch. I haven't decided if 
2.6 is worth that much yet though. 
-- 
with kind regards,
  Christian Unger

"You don't need eyes to see, you need vision" (Faithless - Reverence)

  Mobile:            0402 268904
  Internet:          http://naiv.sourceforge.net
  NAIV Status:
     Stable       Testing       Development
      0.2.3r2      0.3.0         0.3.1 - File Handling

"May there be mercy on man and machine for their sins" (Animatrix)

