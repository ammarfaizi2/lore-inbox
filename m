Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbSLML5d>; Fri, 13 Dec 2002 06:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262804AbSLML5c>; Fri, 13 Dec 2002 06:57:32 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7684 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262792AbSLML5C>;
	Fri, 13 Dec 2002 06:57:02 -0500
Date: Thu, 12 Dec 2002 20:29:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: vesafb no longer works on 2.5.50/51
Message-ID: <20021212192937.GA132@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On one of my machines, vesafb no longer works in 2.5.51 (other machine
is okay?!).

Everything is okay, except I can not see anything on the display.

2.4. (vesafb works):
vesafb: framebuffer at 0xee000000, mapped to 0xd080d000, size 8192k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at c000:7652
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0

2.5.51 (vesafb does not work):
vesafb: framebuffer at 0xee000000, mapped to 0xd0815000, size 8192k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at c000:7652
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
