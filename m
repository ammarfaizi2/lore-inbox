Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284322AbRLBUfN>; Sun, 2 Dec 2001 15:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282922AbRLBUfG>; Sun, 2 Dec 2001 15:35:06 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:36736 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S284314AbRLBUev>;
	Sun, 2 Dec 2001 15:34:51 -0500
Date: Sun, 2 Dec 2001 12:19:22 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: ACPI+HP omnibook -- freeze until power is pressed?
Message-ID: <20011202121922.A2356@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm seeing strange thing on hp omnibook... I work on console, and
machine suddenly locks up without me doing anything strange. So I
press powerbutton for a short while, and ... machine continues to work
as if nothing happened. Not even keyboard presses are lost.

But its annoying, anyway. 2.4.14-acpi. Happened ~10 times so
far. Anyone seen something similar?
								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
