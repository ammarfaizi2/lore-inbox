Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVFCOas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVFCOas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 10:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVFCOas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 10:30:48 -0400
Received: from pop.gmx.net ([213.165.64.20]:12982 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261289AbVFCOal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 10:30:41 -0400
X-Authenticated: #222744
From: "Dieter Ferdinand" <dieter.ferdinand@gmx.de>
To: linux-kernel@vger.kernel.org
Date: Fri, 03 Jun 2005 16:30:37 +1
MIME-Version: 1.0
Subject: problem with reiserfs and reiserfschk with kernel 2.4.30
Reply-To: Dieter.Ferdinand@gmx.de
Message-ID: <42A085AD.11375.5D5E38EE@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a, DE v4.12a R1a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
i use reisefs on my video-record-system as filesystem.

at the first time, i have a memory-problem, which produce an error in the reiserfs-
file-system.
reiserfsck don't find this error, only a rebuild tree make the system usable again.

after correction of all hardware-errors, this system runs fine.

this errors with reiserfs can also happens, if the system crashed or hangs with a 
software bug or a io-error on harddisk.

if the reiserfs-driver comes to this error, no more access to this hd is possible and it 
is not possible, to shutdown the system. i must press the reset-key or shut off the 
power.

if you have a tool, which can generate some reports, if it checks the filesystems, to 
help you, so solve this bug, i can use this tool next time, i have problems with the 
reiserfs.

i will check one partion in the next time, while the system hangs one time, after 
accessing this disk. at the moment, i copy all files to an other disk.

thank you and goodby
Schau auch einmal auf meine Homepage (http://go.to/dieter-ferdinand).
Dort findest du Information zu Linux, Novell, Win95, WinNT, ...

