Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSLML56>; Fri, 13 Dec 2002 06:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262648AbSLML5m>; Fri, 13 Dec 2002 06:57:42 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7940 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262783AbSLML52>;
	Fri, 13 Dec 2002 06:57:28 -0500
Date: Thu, 12 Dec 2002 20:34:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.51: new warning from lilo
Message-ID: <20021212193451.GA458@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Lilo now presents me with new warning:

Warning: Kernel & BIOS return differing head/sector geometries for
device 0x80
    Kernel: 8944 cylidners, 15 heads, 63 sectors
      BIOS: 525 cylinders, 255 heads, 63 sectors

lilo did not warn under 2.5.50. Now... Will it boot?
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
