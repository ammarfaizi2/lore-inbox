Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSIWSFJ>; Mon, 23 Sep 2002 14:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbSIWSFJ>; Mon, 23 Sep 2002 14:05:09 -0400
Received: from [195.39.17.254] ([195.39.17.254]:6272 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261173AbSIWSFI>;
	Mon, 23 Sep 2002 14:05:08 -0400
Date: Mon, 23 Sep 2002 19:48:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.38: Compile fails with undefined reference to cmpxchg
Message-ID: <20020923174826.GA8086@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Subject says it all; CONFIG_M386 was used. With CONFIG_M486 it
compiles okay.

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
