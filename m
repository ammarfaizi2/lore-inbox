Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267503AbTAGSwa>; Tue, 7 Jan 2003 13:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267504AbTAGSwa>; Tue, 7 Jan 2003 13:52:30 -0500
Received: from [195.39.17.254] ([195.39.17.254]:516 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267503AbTAGSwa>;
	Tue, 7 Jan 2003 13:52:30 -0500
Date: Tue, 7 Jan 2003 19:51:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Grover <andrew.grover@intel.com>
Subject: kacpidpc needs to die
Message-ID: <20030107185136.GA302@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

For reasons discussed before [forking from timer is not safe, anyway],
kacpidpc needs to die. Andrew, are you going to kill it or should I do
it?

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
