Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130515AbRCPPUk>; Fri, 16 Mar 2001 10:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130516AbRCPPUb>; Fri, 16 Mar 2001 10:20:31 -0500
Received: from buserror.convergence.de ([212.84.236.5]:49159 "EHLO
	midget.convergence.de") by vger.kernel.org with ESMTP
	id <S130515AbRCPPU1>; Fri, 16 Mar 2001 10:20:27 -0500
Date: Fri, 16 Mar 2001 16:19:19 +0100
From: "J. Michael Kolbe" <wicked@convergence.de>
To: linux-kernel@vger.kernel.org
Subject: sysrq.txt
Message-ID: <20010316161919.A30690@midget.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've found that the Sysrq Keys on Apple Computers
are 'Keypad+-F13-<command key>', maybe it would
be a good idea to include that in Documentation/sysrq.txt.

The Patch:

+++ sysrq.txt   Tue Dec 12 20:46:38 2000
@@ -29,8 +29,6 @@
            You send a BREAK, then within 5 seconds a command key. Sending
            BREAK twice is interpreted as a normal BREAK.
 
-On Mac   - Press 'Keypad+-F13-<command key>'
-
 On other - If you know of the key combos for other architectures, please
            let me know so I can add them to this section.


regards,
jmk
