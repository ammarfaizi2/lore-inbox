Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVE2FDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVE2FDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 01:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVE2FDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 01:03:15 -0400
Received: from smtp832.mail.sc5.yahoo.com ([66.163.171.19]:37800 "HELO
	smtp832.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261251AbVE2FBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 01:01:15 -0400
Message-Id: <20050529044813.711249000.dtor_core@ameritech.net>
Date: Sat, 28 May 2005 23:48:13 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 00/13] Input patches for 2.6.12
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I have prepared some input patches that I would like to see in 2.6.12.
Most of them are coming from Vojtech's BK tree and were in -mm for quite
some time. They fix a warning in pmouse module, allow OSS drivers to
be compiled when gameport support is disabled, fix joystick button
mapping, broken mapping for right "win" key and more.

Please consider pulling from:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

branch "for-linus"

--
Dmitry

