Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUG2ObP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUG2ObP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUG2ObO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:31:14 -0400
Received: from styx.suse.cz ([82.119.242.94]:27030 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264961AbUG2OIM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:12 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 31/47] Fix Peter Nelson's e-mail address in gamecon.c
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:56 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <109111019551@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101961887@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1757.28.16, 2004-06-24 17:55:29+02:00, vojtech@suse.cz
  input: Fix Peter Nelson's e-mail address in gamecon.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 gamecon.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
--- a/drivers/input/joystick/gamecon.c	Thu Jul 29 14:39:46 2004
+++ b/drivers/input/joystick/gamecon.c	Thu Jul 29 14:39:46 2004
@@ -2,7 +2,7 @@
  * NES, SNES, N64, MultiSystem, PSX gamepad driver for Linux
  *
  *  Copyright (c) 1999-2004 	Vojtech Pavlik <vojtech@suse.cz>
- *  Copyright (c) 2004 		Peter Nelson <pnelson@andrew.cmu.edu>
+ *  Copyright (c) 2004 		Peter Nelson <rufus-kernel@hackish.org>
  *
  *  Based on the work of:
  *  	Andree Borrmann		John Dahlstrom

