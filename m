Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbUBUKJZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 05:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbUBUKJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 05:09:25 -0500
Received: from pop.gmx.de ([213.165.64.20]:35467 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261539AbUBUKJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 05:09:24 -0500
X-Authenticated: #222435
Date: Sat, 21 Feb 2004 11:09:48 +0100
From: Jonas Diemer <diemer@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Sound choppy when switching scaling_gov
Message-Id: <20040221110948.5f023281.diemer@gmx.de>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am experiencing choppy sound playback with xmms. For example, when I
keep switching workspaces in my WindowManager, the sound is nearly not
usable. But also during normal work, mp3 playback is somewhat chopy.

This only occurs after I change the scaling_gov. Not after every change
though. If it happens, and I change the scaling gov again, sound
eventually is ok again.

I have a Pentium III 1.13GHz Laptop with a snd_intel8x0 soundchip. The
CPU (should) run at 733Mhz in powersave, so mp3 playback should be ok...

My Kernel is 2.6.2 (haven't tried the new one yet).

regards
Jonas

PS: CC me in your replies, please.
