Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbRGEJh2>; Thu, 5 Jul 2001 05:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbRGEJhI>; Thu, 5 Jul 2001 05:37:08 -0400
Received: from [213.97.184.209] ([213.97.184.209]:15744 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S262355AbRGEJhB>;
	Thu, 5 Jul 2001 05:37:01 -0400
Date: Thu, 5 Jul 2001 11:29:46 +0200 (CEST)
From: German Gomez Garcia <german@piraos.com>
To: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Random lockups with latest kernels (2.4.5-ac20+, 2.4.6-pre8+)
Message-ID: <Pine.LNX.4.33.0107051124330.4164-100000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I'm experiencing random lockups, always after long time of
inactivity, so I don't know how to "debug" them. I have the same problem
sometime ago, it was due to ACPI/APM, I had set up the BIOS to deep sleep
the system and when the system went to that power saving mode it was not
able to wake up. Enabling ACPI or APM in the kernel would fix that, as it
seems that this disabled or reseted any option set in the BIOS.

	Now, I have tryed every combo, disabling APM in the BIOS, enabling
it in the kernel, disabling both, enabling both, but it keeps locking up.
If I look through the logs there is no report of any problem or attack or
anything before the lock up.

	Regards,

	- german

-------------------------------------------------------------------------
German Gomez Garcia         | "This isn't right.  This isn't even wrong."
<german@piraos.com>         |                         -- Wolfgang Pauli

