Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267506AbTBDWkz>; Tue, 4 Feb 2003 17:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbTBDWkz>; Tue, 4 Feb 2003 17:40:55 -0500
Received: from fmr01.intel.com ([192.55.52.18]:59861 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267506AbTBDWky>;
	Tue, 4 Feb 2003 17:40:54 -0500
Message-ID: <8A9A5F4E6576D511B98F00508B68C20A1508E565@orsmsx106.jf.intel.com>
From: "Shureih, Tariq" <tariq.shureih@intel.com>
To: "'Banai Zoltan'" <bazooka@vekoll.vein.hu>, linux-kernel@vger.kernel.org
Subject: RE: CPU detection
Date: Tue, 4 Feb 2003 14:50:19 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you check the obvious such as your BIOS is set to the right cpu
frequency?
It's possible you BIOS was reset and the CPU multiplier is not set
correctly.

When the system boots, what does the BIOS report the CPU as?
Intel Celeron running at: ??

Try that first.

--
Tariq Shureih
Intel Corporation
Opinions are my own and don't represent my employer

-----Original Message-----
From: Banai Zoltan [mailto:bazooka@vekoll.vein.hu] 
Sent: Tuesday, February 04, 2003 10:26 AM
To: linux-kernel@vger.kernel.org
Subject: CPU detection

Hi!

I have a Toshiba Satelite S2210CDT.
There is a problem with detecting CPU frequency.
It runs on 258Mhz, but it is an 500Mhz Celeron kernels 2.4.19-pre7-ac4
and 2.4.20.
i attach the configs and the output of lscpi, /proc/cpu
-- 
Udv,
Banai Zoltan
