Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261830AbTCaTB6>; Mon, 31 Mar 2003 14:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261824AbTCaTB5>; Mon, 31 Mar 2003 14:01:57 -0500
Received: from [195.39.17.254] ([195.39.17.254]:9220 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261833AbTCaTBS>;
	Mon, 31 Mar 2003 14:01:18 -0500
Date: Mon, 31 Mar 2003 21:11:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz
Subject: Autorepeat problems in 2.5.66
Message-ID: <20030331191128.GA204@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have strange autorepeat problems in 2.5.66: it sometimes repeats a
key (on console) when it should not do that. Perhaps vesafb blocks
interrupts for too long and software autorepeat screws it up?

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
