Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbTLFTIR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 14:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbTLFTIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 14:08:17 -0500
Received: from law9-f56.law9.hotmail.com ([64.4.9.56]:32774 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S265229AbTLFTIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 14:08:16 -0500
X-Originating-IP: [62.73.44.101]
X-Originating-Email: [tero1001@hotmail.com]
From: "Tero Knuutila" <tero1001@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: Re: cdrecord hangs my computer
Date: Sat, 06 Dec 2003 21:08:15 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW9-F56HBdIfuKl3Wq000129a0@hotmail.com>
X-OriginalArrivalTime: 06 Dec 2003 19:08:15.0427 (UTC) FILETIME=[4D146130:01C3BC2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I put my kernel to pre-emptive (or something like that in processor opts) in 
menuconfig.
After recompilation kernel test11 now performs fine. No more hangs while 
burning cdroms!

So now we know that it was Linus's patch which helped me on ide-scsi 
problems.

However, I can't remember if I tried multiple disks when testing with ide-cd 
mode.
It is possible that this new way also works. Too bad that  cdrecord does not 
tell when there's faulty cd on drive.

But my system works now so thank you everyone!!! Keep up the good work.

Rgds,
    Tero

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

