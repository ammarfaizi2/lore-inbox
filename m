Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSK3KF4>; Sat, 30 Nov 2002 05:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267229AbSK3KF4>; Sat, 30 Nov 2002 05:05:56 -0500
Received: from [195.39.17.254] ([195.39.17.254]:772 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262796AbSK3KF4>;
	Sat, 30 Nov 2002 05:05:56 -0500
Date: Sat, 30 Nov 2002 10:44:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.50: seq_file updates broke sleep
Message-ID: <20021130094452.GA7708@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Breakage is probably bigger, anyway echo (something) >
/proc/acpi/sleep no longer works.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
