Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131063AbRCMOdl>; Tue, 13 Mar 2001 09:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131076AbRCMOdc>; Tue, 13 Mar 2001 09:33:32 -0500
Received: from mta21-acc.tin.it ([212.216.176.74]:19450 "EHLO fep21-svc.tin.it")
	by vger.kernel.org with ESMTP id <S131063AbRCMOdW>;
	Tue, 13 Mar 2001 09:33:22 -0500
Message-ID: <3AAE2F96.EEB3A719@revicon.com>
Date: Tue, 13 Mar 2001 15:32:54 +0100
From: Lars Knudsen <gandalf@revicon.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18pre25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Status of the i2c driver in 2.2.xx
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone tell me what the status of the i2c driver in the
2.2.xx kernels are ?

As far as I can see the only two ways of compiling the kernel
with i2c support is to have CONFIG_ARCH_TBOX which is arm 
specific or have CONFIG_VISWS set which is specific to the 
SGI visual workstation.

Happy hacking,

\Gandalf
