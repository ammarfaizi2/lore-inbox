Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318731AbSHAMGP>; Thu, 1 Aug 2002 08:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318721AbSHAMFm>; Thu, 1 Aug 2002 08:05:42 -0400
Received: from [195.39.17.254] ([195.39.17.254]:10880 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318723AbSHAMEd>;
	Thu, 1 Aug 2002 08:04:33 -0400
Date: Thu, 1 Aug 2002 13:00:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.29: fbcon palette not quite right
Message-ID: <20020801110053.GA118@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It is problem in 2.4.X, too.

If I echo this to the console (^[ being escape)

^[c^[(K
^[(K
Tohle je AMD...

Welcome to bug (Linux 2.5.29)

^[]P700b000 ^[]Pf00ff00

Welcome to bug is white while rest of text is green. Everything
becomes green after console switch. Not too serious, but still a bug.

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
