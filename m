Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTICV76 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 17:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbTICV76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 17:59:58 -0400
Received: from [195.39.17.254] ([195.39.17.254]:4868 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id S263737AbTICV7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 17:59:55 -0400
Date: Wed, 3 Sep 2003 21:17:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: USB modem no longer detected in -test4
Message-ID: <20030903191701.GA2798@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In 2.6.0-test4, USB ELSA modem no longer works. This is UHCI (on
toshiba 4030cdt).

Relevant messages seem to be:

PM: Adding info for usb:1-1.2
drivers/usb/class/cdc-acm.c: need inactive config#2
PM: Adding info for usb:1-1.2:0
drivers/usb/class/cdc-acm.c: need inactive config#2

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
