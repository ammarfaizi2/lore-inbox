Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264073AbUEMKy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbUEMKy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 06:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUEMKy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 06:54:29 -0400
Received: from pop.gmx.de ([213.165.64.20]:38033 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264073AbUEMKyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 06:54:24 -0400
Date: Thu, 13 May 2004 12:54:23 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: Sound with noise since 2.6.5
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <20324.1084445663@www67.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been experiencing this also - with a HP Evo D310 system P4 system -
you hear some processor or bus activity on the audio output.

Kernel is 2.4.22 on Fedora Core 1.

---

Intel 810 + AC97 Audio, version 0.24, 20:50:53 Apr 21 2004
PCI: Found IRQ 11 for device 00:1f.5
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH4 found at IO 0x2400 and 0x2000, MEM 0xf8500400 and
0xf8500600, IRQ 11
i810: Intel ICH4 mmio at 0xd0ad2400 and 0xd0ad4600
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ADS114 (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2

-- 
Daniel J Blueman

"Sie haben neue Mails!" - Die GMX Toolbar informiert Sie beim Surfen!
Jetzt aktivieren unter http://www.gmx.net/info

