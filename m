Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUDIQL3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 12:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUDIQL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 12:11:29 -0400
Received: from [199.72.99.40] ([199.72.99.40]:14853 "EHLO blackbox.ecweb.com")
	by vger.kernel.org with ESMTP id S261462AbUDIQL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 12:11:26 -0400
Subject: 2.6.* "Pointing Device Error" in BIOS on Reboot
From: Danny Cox <Danny.Cox@ECWeb.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Electronic Commerce Systems
Message-Id: <1081527132.833.20.camel@vom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 09 Apr 2004 12:12:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

	Nothing earth-shattering here, but I have noticed that a reboot after
running a 2.6.* kernel (including -rc?s and -mm?s), the BIOS beeps, and
displays "8603\nPointing Device Error" first thing.  After POST and the
other card's BIOS routines, it drops me into the BIOS setup.  I can
either modify the pointer entry, or just exit setup, and all is well.

	The machine is an unremarkable IBM with a Pentium III @ 450 MHz (a
*real* screamer ;-).  The mouse *does* connect through a Linksys KVM
switch, although the 2.4 series didn't exhibit this issue.  The mouse
itself is a cheap optical scroll mouse I've used for two or three years.

	The BIOS is dated "7/19/1999" which of course is ancient (and IBM ;-).

	I wouldn't even mention it, except that in the rare case (well,
actually - not so rare: it's happened twice this year) of our building
losing power after hours, the machine will remain at the prompt in the
BIOS setup on 'Continue'/'Exit' instead of booting back to the login
prompt, and my cron backups don't run.

	Any ideas?  Please reply to me directly, as I'm not prepared to
subscribe to l-k.  Further details available upon request.

	Thanks!

-- 
Daniel S. Cox
Electronic Commerce Systems

