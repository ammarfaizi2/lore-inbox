Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbUAFRxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUAFRxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:53:48 -0500
Received: from cicero2.cybercity.dk ([212.242.40.53]:7 "EHLO
	cicero2.cybercity.dk") by vger.kernel.org with ESMTP
	id S264874AbUAFRxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:53:46 -0500
Subject: TTY problems @ X terms
From: Mads Christensen <mfc@krycek.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: krycek.org
Message-Id: <1073411625.2731.9.camel@krycek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Jan 2004 18:53:45 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

When opening my Eterm i get a: 
mesg: /dev/ttyp3: Operation not permitted

(mfc@krycek:mfc)$ l /dev/ttyp*
crw-rw-rw-    1 root     tty        3,   0 2004-01-06 18:53 /dev/ttyp0
crw-rw-rw-    1 root     tty        3,   1 2004-01-06 18:53 /dev/ttyp1
crw-rw-rw-    1 root     tty        3,   2 2004-01-06 18:47 /dev/ttyp2
crw-rw-rw-    1 root     tty        3,   3 2004-01-06 18:53 /dev/ttyp3
crw-rw-rw-    1 root     tty        3,   4 2004-01-06 18:53 /dev/ttyp4
crw-rw-rw-    1 root     tty        3,   5 2003-12-26 13:41 /dev/ttyp5
crw-rw-rw-    1 root     tty        3,   6 2003-12-27 16:46 /dev/ttyp6
crw-rw-rw-    1 root     tty        3,   7 2003-12-25 11:34 /dev/ttyp7
crw-rw-rw-    1 root     tty        3,   8 2003-12-25 15:27 /dev/ttyp8
crw-rw-rw-    1 root     tty        3,   9 2003-12-25 13:04 /dev/ttyp9
crw-rw-rw-    1 root     tty        3,  10 2004-01-04 13:22 /dev/ttypa
crw-rw-rw-    1 root     tty        3,  11 2004-01-04 13:38 /dev/ttypb
crw-rw-rw-    1 root     tty        3,  12 2004-01-06 16:40 /dev/ttypc
crw-rw-rw-    1 root     tty        3,  13 2003-12-25 14:15 /dev/ttypd
crw-rw-rw-    1 root     tty        3,  14 2001-11-04 23:51 /dev/ttype
crw-rw-rw-    1 root     tty        3,  15 2001-11-04 23:51 /dev/ttypf

(mfc@krycek:mfc)$ groups
mfc adm tty disk lp cdrom floppy audio www-data video users

Thx
-- 
===================================================
| Mads F. Christensen     ||                      |
| Email:                  || mfc@krycek.org       |
| Webdesign Development   || www.krycek.org       |
===================================================



