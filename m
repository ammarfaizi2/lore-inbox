Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270436AbTG1SA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270438AbTG1SA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:00:28 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:32385 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270436AbTG1SA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:00:27 -0400
Date: Mon, 28 Jul 2003 20:14:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test2: cursor started to disappear
Message-ID: <20030728181408.GA499@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Under 2.6.0-test2 cursor problems got worse... Sometimes cursor just
disappears. Switching consoles does not help.

Plus I'm seeing some silent data corruption. It may be swsusp or loop
related, don't yet know how to reproduce it (ext2 on hp omnibook xe3).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
