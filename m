Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279832AbRKFRRV>; Tue, 6 Nov 2001 12:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279841AbRKFRRM>; Tue, 6 Nov 2001 12:17:12 -0500
Received: from grex.cyberspace.org ([216.93.104.34]:44810 "HELO
	grex.cyberspace.org") by vger.kernel.org with SMTP
	id <S279832AbRKFRQ7>; Tue, 6 Nov 2001 12:16:59 -0500
Message-ID: <20011106121732.A9281@grex.cyberspace.org>
Date: Tue, 6 Nov 2001 12:17:32 -0500
From: Step 1 B <step1b@cyberspace.org>
To: linux-kernel@vger.kernel.org
Subject: regd kernel compilation
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
 During the processing of compiling the kernel and getting it running, I
observed that my kernel not only contains software for my current hardware
configuration, but also for other hardware as well.(both in the kernel and
as modules). and during bootup, the kernel identifies the hardware and
either uses the concened part in the kernel, or loads the concerned
module. Cant this be done during compilation(ie., kernel building) itself
so that I get a smaller kernel and a smaller set of modules on my disk ? 
Or is just that the current kernel compilation framework does not support
this ? 

Note that I do not know what hardware I have, so I want the 
compilation scripts to identify the hardware and make the correct and minimal config.



I am not on this mailing list, so please
cc me any responses.

thanks
