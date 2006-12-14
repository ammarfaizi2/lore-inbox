Return-Path: <linux-kernel-owner+w=401wt.eu-S1751978AbWLNTWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbWLNTWG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbWLNTWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:22:06 -0500
Received: from styx.suse.cz ([82.119.242.94]:44987 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751974AbWLNTWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:22:04 -0500
X-Greylist: delayed 1414 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 14:22:04 EST
Date: Thu, 14 Dec 2006 19:58:02 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID core patches for 2.6.20-rc1
Message-ID: <Pine.LNX.4.64.0612141814250.3831@jikos.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull from 

master.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus

to receive updates for hid core layer, which you merged last week and I am 
going to maintain (acked by Dmitry and Marcel).

Thanks.

--- 

 MAINTAINERS               |    6 ++++++
 drivers/hid/hid-input.c   |   44 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/input/Kconfig |    3 ++-
 include/linux/input.h     |   15 +++++++++++++++
 4 files changed, 67 insertions(+), 1 deletions(-)

Florian Festi (1):
      input/hid: Supporting more keys from the HUT Consumer Page

Jiri Kosina (2):
      Generic HID layer - build: USB_HID should select HID
      Generic HID layer - update MAINTAINERS


