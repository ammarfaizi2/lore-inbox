Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbTJWQTs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 12:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263634AbTJWQTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 12:19:48 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:52661 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263609AbTJWQTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 12:19:47 -0400
Subject: 2.6.0-test8-mm1 crash
From: Harold Martin <cocoadev@earthlink.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1066925860.3309.40.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 23 Oct 2003 09:17:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was running X and a few applications when everything froze.
I tried Ctrl-Alt-Delete but that didn't do anything.
I also trued to use various Alt+SysRq keystrokes, but I was forced to
use Alt+SysRq+b
Here's the only stuff I thought would be relevant from the logs:
Oct 23 07:37:00 [kernel] atkbd.c: Unknown key released (translated set
2, code 0x6e, data 0xff, on isa0060/serio0).Oct 23 07:47:38 [kernel]
SysRq : Emergency Sync

Box specs:
AMD MP 2600
AMD 760MPX chipset
Radeon 7500
Adaptec Ultra160 SCSI adapter

I'm sorry I don't know what other information you guys might want.
Please tell me and I'll send it.

Thanks,
Harold

