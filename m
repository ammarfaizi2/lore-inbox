Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268945AbTCDBR7>; Mon, 3 Mar 2003 20:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268947AbTCDBR7>; Mon, 3 Mar 2003 20:17:59 -0500
Received: from adsl-67-121-154-32.dsl.pltn13.pacbell.net ([67.121.154.32]:2016
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id <S268945AbTCDBR5>; Mon, 3 Mar 2003 20:17:57 -0500
Message-ID: <1059.192.168.0.10.1046741295.squirrel@mail.triplehelix.org>
Date: Mon, 3 Mar 2003 17:28:15 -0800 (PST)
Subject: PCMCIA unclean in 2.5?
From: "Joshua M. Kwan" <joshk@triplehelix.org>
To: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.4.0 RC1)
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a USR 2410 wifi card which works perfectly fine in Linux 2.5 that
seems to only work in Windows when I boot it twice in a row (ie, don't
boot Linux, then reboot to Windows.) This has only started happening in
recent releases. When it's not working it will register but endlessly
search for an AP that's right in front of it.

Is the new PCMCIA code not resetting something that it should, before it
shuts down?

Thanks and regards,
Josh
