Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbUDZNkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUDZNkN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 09:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUDZNkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 09:40:12 -0400
Received: from mail.convergence.de ([212.84.236.4]:2435 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261815AbUDZNkJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:40:09 -0400
To: hunold@linuxtv.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 0/9] LinuxTV.org DVB update
In-Reply-To: 
Message-Id: <10829866543802@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 26 Apr 2004 09:40:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus, Andrew,

I'm sending you a set of 9 patches that sync the
LinuxTV.org CVS with latest linux-2.6.5.

I'm glad that I can announce that we have recently
forked off our 2.6 development tree, so we are really
looking forward to implement
- proper kobject/sysfs support
- proper firmware loading for frontend drivers
- removal of dvb-i2c and use of kernel i2c instead
- other interesting 2.6 specific things

This is the last patchset that rides the dead "2.4 compatiblity"
horse.

As usual, detailed informations about what changed can be 
found at the top of each file.

Please apply! 

CU
Michael.


