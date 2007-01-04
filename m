Return-Path: <linux-kernel-owner+w=401wt.eu-S964905AbXADPYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbXADPYM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbXADPYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:24:12 -0500
Received: from styx.suse.cz ([82.119.242.94]:48873 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964905AbXADPYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:24:12 -0500
Date: Thu, 4 Jan 2007 16:24:02 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID core patches
Message-ID: <Pine.LNX.4.64.0701041359150.14220@jikos.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull from 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus

or
	master.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus

to receive updates for HID core layer that should be in 2.6.20 - a simple 
compilation fix and a Kconfig help text update.

Thanks.

--- 

 drivers/hid/Kconfig       |   18 +++++++++++++-----
 drivers/usb/input/Kconfig |    6 ++----
 2 files changed, 15 insertions(+), 9 deletions(-)

Jiri Kosina (1):
      HID: fix help texts in Kconfig

Russell King (1):
      Fix some ARM builds due to HID brokenness


-- 
Jiri Kosina
