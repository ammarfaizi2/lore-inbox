Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWGHTXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWGHTXP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 15:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWGHTXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 15:23:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34823 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964962AbWGHTXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 15:23:14 -0400
Date: Sat, 8 Jul 2006 21:23:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: dmitry.torokhov@gmail.com
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] input: remove obsolete contact information
Message-ID: <20060708192315.GA5020@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some obsolete contact information from 
Documentation/input/{input,joystick}.txt .

This patch fixes kernel Bugzilla #2804.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/input/input.txt    |   21 ---------------------
 Documentation/input/joystick.txt |   11 -----------
 2 files changed, 32 deletions(-)

--- linux-2.6.17-mm6-full/Documentation/input/input.txt.old	2006-07-08 21:15:58.000000000 +0200
+++ linux-2.6.17-mm6-full/Documentation/input/input.txt	2006-07-08 21:16:52.000000000 +0200
@@ -289,24 +289,3 @@
 EV_REL, absolute new value for EV_ABS (joysticks ...), or 0 for EV_KEY for
 release, 1 for keypress and 2 for autorepeat.
 
-6. Contacts
-~~~~~~~~~~~
-  This effort has its home page at:
-
-	http://www.suse.cz/development/input/
-
-You'll find both the latest HID driver and the complete Input driver
-there as well as information how to access the CVS repository for
-latest revisions of the drivers.
-
-  There is also a mailing list for this:
-
-	majordomo@atrey.karlin.mff.cuni.cz
-
-Send "subscribe linux-input" to subscribe to it.
-
-The input changes are also being worked on as part of the LinuxConsole
-project, see:
-
-	 http://sourceforge.net/projects/linuxconsole/
-
--- linux-2.6.17-mm6-full/Documentation/input/joystick.txt.old	2006-07-08 21:17:07.000000000 +0200
+++ linux-2.6.17-mm6-full/Documentation/input/joystick.txt	2006-07-08 21:17:45.000000000 +0200
@@ -37,17 +37,6 @@
 this driver can't make complete use of, I'm very interested in hearing about
 them. Bug reports and success stories are also welcome.
 
-  The input project website is at:
-
-	http://www.suse.cz/development/input/
-	http://atrey.karlin.mff.cuni.cz/~vojtech/input/
-
-  There is also a mailing list for the driver at:
-
-	listproc@atrey.karlin.mff.cuni.cz
-
-send "subscribe linux-joystick Your Name" to subscribe to it.
-
 2. Usage
 ~~~~~~~~
   For basic usage you just choose the right options in kernel config and

