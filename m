Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTDHTog (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbTDHTog (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:44:36 -0400
Received: from [195.39.17.254] ([195.39.17.254]:260 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id S261664AbTDHTof (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:44:35 -0400
Date: Tue, 8 Apr 2003 20:57:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Documentation/i2c/sysfs-interface
Message-ID: <20030408185711.GA5790@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

First, that file should probably be named sysfs-interface.txt. Then,
it

+vrm            Voltage Regulator Module version number.
+               Read only.
+               Two digit number (XX), first is major version, second
is
+               minor version.
+               Affects the way the driver calculates the core voltage
from
+               the vid pins. See doc/vid for details.

Points to doc/vid, but there's no such file in kernel tree.
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
