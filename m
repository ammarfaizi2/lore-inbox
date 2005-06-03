Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVFCOOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVFCOOs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 10:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVFCOOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 10:14:48 -0400
Received: from pop.gmx.net ([213.165.64.20]:16340 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261281AbVFCOOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 10:14:45 -0400
X-Authenticated: #222744
From: "Dieter Ferdinand" <dieter.ferdinand@gmx.de>
To: linux-kernel@vger.kernel.org
Date: Fri, 03 Jun 2005 16:14:41 +1
MIME-Version: 1.0
Subject: problem with isdn-audio-driver i4l hisax kernel from 2.2.x to 2.4.30
Reply-To: Dieter.Ferdinand@gmx.de
Message-ID: <42A081F1.15525.5D4F9ED5@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a, DE v4.12a R1a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
i have a big problem with the isdn-audio-drivers.

i use a software-pbx (asterisk) with the isdn-modem-driver with audio-function under 
linux and some times, the system hangs total.
only reset or power of solve this problem.

i have this problem also with vbox as voicemailbox.
if i play some record-files over vbox to a phone, the system hangs and i must press 
the reset.
since this time, i used only the data-functions with the isdn-drivers, but with the pbx-
soft, i need also the audio-functions and there is this bug.

i think, this bug is only by playing audio-data.
i have no more files, which produces this error.

the last time, my system hangs with this bug, was on a long sip-connection (> 1 
hour), the time before, on some tests with one sip-provider.

i can try to get new audio-files with vbox, which produce this error, when this can 
help to find the bug.

i think, there is a endless loop in the drivers, if this error happens, but the system is 
dead, total dead. keyboard don't works at this time.

i think, this error is also, if i use an active card with capi over the modem-driver.
i make some test and at one this, this system hangs also with the same bug.

if i can help, to find this bug, ask me. i can install passive and active capi isdn-cards 
on a test system with a post-diagnose-card or a terminal connect to serial to log 
systemstatus.

i hope, someone can help me, to solve this bug.

thank you, for your help

Schau auch einmal auf meine Homepage (http://go.to/dieter-ferdinand).
Dort findest du Information zu Linux, Novell, Win95, WinNT, ...

