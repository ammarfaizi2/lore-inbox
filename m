Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWBRXOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWBRXOc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 18:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWBRXOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 18:14:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12511 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932264AbWBRXOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 18:14:32 -0500
Date: Sun, 19 Feb 2006 00:14:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
Subject: No sound from SB live!
Message-ID: <20060218231419.GA3219@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have SB Live! here. I remember it worked long time ago. Now I can't
get it to produce any sound :-(. 

root@hobit:~# cat /proc/asound/cards
 0 [Live           ]: EMU10K1 - SBLive! Value [CT4830]
                      SBLive! Value [CT4830] (rev.7,
serial:0x80261102) at 0x3000, irq 20
 1 [Bt878          ]: Bt87x - Brooktree Bt878
                      Brooktree Bt878 at 0xd0001000, irq 17

root@hobit:~# uname -a
Linux hobit 2.6.16-rc4 #1 SMP PREEMPT Sat Feb 18 23:53:41 CET 2006
i686 GNU/Linux

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
