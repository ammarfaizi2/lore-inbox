Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284175AbRLARug>; Sat, 1 Dec 2001 12:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284174AbRLARuQ>; Sat, 1 Dec 2001 12:50:16 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:33805 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S283924AbRLARuP>; Sat, 1 Dec 2001 12:50:15 -0500
Date: Sat, 1 Dec 2001 18:49:55 +0100
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: anybody using the latest 3dfx framebuffer @ high resolutions?
Message-ID: <20011201184955.A335@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having lots of trouble getting my voodoo 4500 pci to give a good
image in my alpha, and I'm wondering if it works allright on other
architectures.

I'm using 2.4.17pre2 and 3dfx-20010507; and anything where my pixclock
is over max_pixclock / 2 just hangs when booting. I'm trying to get
1600x1200-16@80, which XFree displays just fine. So it should be
possible. I'd like to compare settings with someone who has this
working.

Thanks,
Jurriaan
-- 
"Do I take it you and she never got on?" asked Hawk, amused.
"I have had fungal infections I thought more highly of."
	Simon R Green - Beyond the Blue Moon
GNU/Linux 2.4.17-pre1 on Debian/Alpha 64-bits 988 bogomips load:0.55 0.20 0.07
